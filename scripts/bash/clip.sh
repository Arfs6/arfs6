#!/bin/bash

if [ $# -eq 0 ]; then
  while read -r line; do
    echo "$line"
  done | clip.exe
else
  cat "$1" | clip.exe
fi


