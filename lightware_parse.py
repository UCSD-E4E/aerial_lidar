#!/usr/bin/env python

import serial

s = serial.Serial('/dev/ttyUSB0', baudrate=115200)

while True:
	line = s.readline()
	dist = line.lstrip(' ').split(' ')[0]
	print dist
