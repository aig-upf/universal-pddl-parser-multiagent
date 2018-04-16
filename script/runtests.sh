#!/usr/bin/env bash
set -e # halt script on error

valgrind -q --leak-check=yes --log-file="valgrind.txt" ./tests/test.bin