#!/bin/bash

if [ $# -eq 0 ]; then
  win32yank.exe -o --lf
else
  win32yank.exe -o --lf > "$1"
fi


