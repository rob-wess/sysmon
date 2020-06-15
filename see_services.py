#!/usr/bin/python3

import psutil


# Iterate over all running process
for proc in psutil.process_iter():
    try:
        # Get process name & pid from process object.
        processName = proc.name()
        processID = proc.pid
        processUser = proc.username()
        processCmd = proc.cmdline()

        #for line in processCmd:
        #    processCmd = line.split(',')

        print(processCmd)
      








        #print(processName, ',', processID, ',', processUser, sep='')


    except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
        pass



