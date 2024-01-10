#!/usr/bin/python3

import sys

if len(sys.argv) != 3:
    print("Invalid number of arguments")
    sys.exit()

with open(sys.argv[1], 'r') as f_obj_1:
    with open(sys.argv[2], 'r') as f_obj_2:
        stream_2 = f_obj_2.readlines()
    stream_1 = f_obj_1.readlines()

len_1 = len(stream_1)
len_2 = len(stream_2)
i = 0
if len_1 != len_2:
    print(f"{sys.argv[1] != sys.argv[2]}")
    print(f"{len_1} != {len_2}")
while i < len_1 or i < len_2:
    if stream_1[i] != stream_2[i]:
        print('>' * 10)
        print(f"{len_1}|\t{stream_1[i]}")
        print('=' * 10)
        print(f"{len_2}|\t{stream_2[i]}")
        print('<' * 10)
    i += 1
