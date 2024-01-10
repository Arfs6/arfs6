# -*- coding: utf-8 -*-
from time import sleep
from psutil import sensors_battery
from winsound import Beep


# start the loop
constant = 30000
duration = 250
while True:
    try:
        battery_info = sensors_battery()
        # check if battery isn't charging
        if not battery_info[2]:
            # beep based on how low the battery is
            freq = (1 / battery_info[0]) * constant
            freq = int(freq)
            Beep(freq, duration)

        sleep(2)
    except Exception as e:
        # write the exception into a file.
        from traceback import format_exc
        from os import getenv
        from datetime import datetime
        error = format_exc()
        temp_file = getenv('temp')
        temp_file = 'error.txt'
        with open(temp_file, 'a') as file:
            file.write(datetime.now().isoformat())
            file.write(error)
            exit(1)
    except KeyboardInterrupt:
        Beep(2000, 250)
        Beep(2000, 250)
        exit(0)
