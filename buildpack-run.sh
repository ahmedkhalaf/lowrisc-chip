#!/bin/sh

git submodule update --init --recursive
cd riscv-tools
git submodule update --init --recursive
./build.sh
