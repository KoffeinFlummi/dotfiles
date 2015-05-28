#!/usr/bin/env python3

import os
import sys
import shutil
import subprocess
import re

if "--left" in sys.argv:
    colors = {
        "red": "\\[\\e[1;31m\\]",
        "green": "\\[\\e[1;32m\\]",
        "blue": "\\[\\e[1;36m\\]",
        "yellow": "\\[\\e[1;33m\\]",
        "reset": "\\[\\e[0m\\]"
    }
else:
    colors = {
        "red": "\33[1;31m",
        "green": "\33[1;32m",
        "blue": "\33[1;36m",
        "yellow": "\33[1;33m",
        "reset": "\33[0m"
    }
correction = 0

def get_terminal_size():
    lines, cols = subprocess.check_output(["stty", "size"]).split()
    return int(cols), int(lines)

def segment_whoami():
    global colors

    user = os.environ["USER"]
    host = str(subprocess.check_output("hostname"), "utf-8")[:-1]

    cols, lines = get_terminal_size()

    if len(user) + len(host) + 3 > cols / 5:
        host = host[0]
    if len(user) + 4 > cols / 5:
        user = user[0]

    usercolor = colors["green"]
    if os.geteuid() == 0:
        usercolor = colors["red"]

    hostcolor = colors["blue"]
    if "SSH_TTY" in os.environ:
        hostcolor = colors["yellow"]

    return "[{}{}{}@{}{}{}]".format(
        usercolor, user, colors["reset"],
        hostcolor, host, colors["reset"]
    )

def segment_prompt():
    global colors

    prompt = "$"
    if os.geteuid() == 0:
        prompt = "#"

    if "ERR" in os.environ and int(os.environ["ERR"]) != 0:
        return "{}{}{}".format(colors["red"], prompt, colors["reset"])

    return prompt

def segment_git():
    global colors, correction

    try:
        branch = subprocess.check_output(["git", "name-rev", "--name-only", "HEAD"], stderr=subprocess.PIPE)
    except:
        return ""

    correction = correction + 11
    gitseg = "(" + str(branch, "utf-8")[:-1] + ")"

    local = str(subprocess.check_output(["git", "rev-list", "origin..HEAD"]), "utf-8")
    origin = str(subprocess.check_output(["git", "rev-list", "HEAD..origin"]), "utf-8")
    local, origin = len(local.split("\n")), len(origin.split("\n"))
    if local > 1:
        gitseg = "{}^ ".format(local - 1) + gitseg
    if origin > 1:
        gitseg = "{}v ".format(origin - 1) + gitseg

    porcelain = str(subprocess.check_output(["git", "status", "--porcelain", "--untracked-files"]), "utf-8")
    new = len(list(filter(lambda x: x[:2] == "??", porcelain.split("\n"))))
    if new > 0:
        return colors["red"] + gitseg + colors["reset"]

    diff = str(subprocess.check_output(["git", "diff", "--name-only"]), "utf-8")
    changed = len(diff.split("\n"))
    if changed > 1:
        return colors["red"] + gitseg + colors["reset"]

    diff = str(subprocess.check_output(["git", "diff", "--name-only", "--staged"]), "utf-8")
    staged = len(diff.split("\n"))
    if staged > 1:
        return colors["yellow"] + gitseg + colors["reset"]

    return colors["green"] + gitseg + colors["reset"]

def segment_path():
    global colors

    path = os.getcwd()
    home = os.environ["HOME"]

    if path[:len(home)] == home:
        path = "~" + path[len(home):]

    cols, lines = get_terminal_size()
    while len(path) > cols / 5 and re.search(r"\/[^/][^/]+\/", path) is not None:
        path = re.sub(r"\/([^/])[^/]+\/", r"/\1/", path, count=1)

    return path

def main():
    global correction

    cols, lines = get_terminal_size()

    if "--right" in sys.argv:
        right = "{} {}".format(segment_git(), segment_path())
        print(right.rjust(cols + correction - 1), end="\r")

    if "--left" in sys.argv:
        left = "{} {}".format(segment_whoami(), segment_prompt())
        print(left, end=" ")

if __name__ == "__main__":
    main()
