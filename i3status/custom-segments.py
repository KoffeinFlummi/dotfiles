#!/bin/env python3

import os
import sys
import math
import locale
import re
import subprocess as sp


def get(cmd):
    out = sp.check_output(cmd.split())
    out = str(out, "utf-8")
    try:
        if out[-1] == "\n":
            return out[:-1]
        return out
    except:
        return ""


def main():
    # Unfuck unicode symbols in argv
    argv = sys.argv
    encoding = locale.getpreferredencoding()
    argvb = [bytes(arg, encoding) for arg in argv]
    argv = [str(arg, "utf-8") for arg in argvb]

    # Find insertion point for new segments
    original = " ".join(argv[1:])
    try:
        start = original.index("[") + 1
        assert start < len(original)
    except:
        return original

    # Remove ethernet segment on laptop, and battery segment on PC
    if "laptop" in get("hostname"):
        original = re.sub(r",\{\"name\":\"ethernet\".*?\}", "", original)
    else:
        original = re.sub(r",\{\"name\":\"battery\".*?\}", "", original)

    # Construct additional segments
    segments = []
    if "laptop" in get("hostname"):
        # Backlight
        backlight = math.floor(float(get("xbacklight -get")))
        segments.append(" {:03}%".format(backlight))

        # Kbdlight
        kbdlight = math.floor(float(get("kbdlight get")) / 255 * 100)
        segments.append(" {:03}%".format(kbdlight))

    # Insert additional segments
    output = original[:start]
    for i, s in enumerate(segments):
        output += '{' + '"name":"custom_{}","full_text":"{}"'.format(i, s) + '},'
    output += original[start:]

    return output


if __name__ == "__main__":
    with open(1, "w", encoding="utf-8", closefd=False) as stdout:
        print(main(), file=stdout)

