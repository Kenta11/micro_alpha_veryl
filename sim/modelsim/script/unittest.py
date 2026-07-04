#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os

from vunit.verilog import VUnit

vu = VUnit.from_argv()

lib = vu.add_library("lib")

for src in os.environ["SRCS"].split():
    lib.add_source_files(src)


for src in os.environ["TESTS"].split():
    lib.add_source_files(src)

vu.main()
