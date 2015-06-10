#!/bin/env python3

import os
import sys
import math
import locale
import subprocess as sp


def get(cmd):
    out = sp.check_output(cmd.split())
    out = str(out, "utf-8")
    if out[-1] == "\n":
        return out[:-1]
    return out


def main():
    # Unfuck unicode symbols in argv
    argv = sys.argv
    encoding = locale.getpreferredencoding()
    argvb = [bytes(arg, encoding) for arg in argv]
    argv = [str(arg, "utf-8") for arg in argvb]

    original = " ".join(argv[1:])
    try:
        start = original.index("[") + 1
        assert start < len(original)
    except:
        return original

    segments = []

    # Backlight
    backlight = math.floor(float(get("xbacklight -get")))
    segments.append(" {:03}%".format(backlight))

    # Kbdlight
    kbdlight = math.floor(float(get("kbdlight get")) / 255 * 100)
    segments.append(" {:03}%".format(kbdlight))

    output = original[:start]
    for i, s in enumerate(segments):
        output += '{' + '"name":"custom_{}","full_text":"{}"'.format(i, s) + '},'
    output += original[start:]

    return output


if __name__ == "__main__":
    with open(1, "w", encoding="utf-8", closefd=False) as stdout:
        print(main(), file=stdout)

