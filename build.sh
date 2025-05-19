#!/usr/bin/env bash

make clean > /dev/null 2>&1
make && chmod a+x ffft
