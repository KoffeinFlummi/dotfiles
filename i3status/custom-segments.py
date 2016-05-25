#!/bin/env python3

import os
import sys
import math
import locale
import re
import subprocess as sp

import requests


def get(cmd):
    out = sp.check_output(cmd.split())
    out = str(out, "utf-8")
    try:
        if out[-1] == "\n":
            return out[:-1]
        return out
    except:
        return ""


def get_file(path):
    with open(path) as f:
        s = f.read()

    return float(s.strip())


def main():
    # Unfuck unicode symbols in argv
    argv = sys.argv
    encoding = locale.getpreferredencoding()
    argvb = [bytes(arg, encoding) for arg in argv]
    argv = [str(arg, "utf-8") for arg in argvb]
    laptop = "alfheim" in get("hostname")

    # Find insertion point for new segments
    original = " ".join(argv[1:])
    try:
        start = original.index("[") + 1
        assert start < len(original)
    except:
        return original

    # Remove ethernet segment on laptop, and battery segment on PC
    if laptop:
        original = re.sub(r",\{\"name\":\"ethernet\".*?\}", "", original)
    else:
        original = re.sub(r",\{\"name\":\"battery\".*?\}", "", original)
        original = re.sub(r",\{\"name\":\"wireless\".*?\}", "", original)

    # Construct additional segments
    segments = []

    try:
        mpc = get("mpc").split("\n")
        assert len(mpc) > 1
        if "playing" in mpc[1]:
            segments.append(" "+mpc[0])
        else:
            segments.append(" "+mpc[0])
    except:
        pass

    # Bitcoin price
    r = requests.get("https://api.bitcoinaverage.com/ticker/global/EUR/")
    segments.append(" "+str(r.json()["last"]))

    if laptop:
        # Backlight
        backlight = get_file("/sys/class/backlight/mba6x_backlight/actual_brightness") / 2.5
        segments.append(" {:02}%".format(int(backlight)))

        # Kbdlight
        kbdlight = math.floor(float(get("kbdlight get")) / 255 * 100)
        segments.append(" {:02}%".format(kbdlight))

    # Memory usage
    meminfo = get("cat /proc/meminfo").split("\n")
    total = int(meminfo[0].split()[1])
    avail = int(meminfo[2].split()[1])
    memusage = round((1 - avail / total) * 100)
    segments.append(" {:02}%".format(memusage))

    # Insert additional segments
    output = original[:start]
    for i, s in enumerate(segments):
        output += '{' + '"name":"custom_{}","full_text":"{}"'.format(i, s) + '},'
    output += original[start:]

    return output


if __name__ == "__main__":
    with open(1, "w", encoding="utf-8", closefd=False) as stdout:
        print(main(), file=stdout)

