#!/usr/bin/env bash

for d in */; do (cd "$d" && make clean); done
