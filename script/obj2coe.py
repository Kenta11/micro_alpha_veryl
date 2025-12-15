#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys


def parse_main_memory(size, lines):
    memory = ["0000"] * size

    for line in lines:
        address, value = line.split()
        memory[int(address, 16)] = f"{int(value, 16):04x}"

    return memory


def parse_control_memory(size, lines):
    memory = ["0000000000"] * size

    for line in lines:
        address, value = line.split()
        memory[int(address, 16)] = f"{int(value, 16):010x}"

    return memory


def main(memory_size, input_file, output_file):
    # read input
    with open(input_file) as f:
        lines = f.readlines()

    # parse lines
    first, _ = lines[0].split()
    if first == "MM":
        memory = parse_main_memory(memory_size[0], lines[1:])
    elif first == "CM":
        memory = parse_control_memory(memory_size[1], lines[1:])
    else:
        exit(1)

    # write coe
    with open(f"{output_file}", "w") as f:
        f.write("memory_initialization_radix=16;\n")
        f.write("memory_initialization_vector=\n")
        f.write(",\n".join(memory))
        f.write(";")


if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage:", sys.argv[0], "<board>", "<input>", "<output>")
        print("<board>:=(arty-a7-100|basys-3)")
        exit(1)

    memory_size_list = {
        "arty-a7-100": [65536, 4096],
        "basys-3": [1024, 512]
    }

    memory_size = memory_size_list[sys.argv[1]]
    input_file = sys.argv[2]
    output_file = sys.argv[3]

    main(memory_size, input_file, output_file)
