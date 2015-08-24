#!/usr/bin/env python

import serial
import csv

s = serial.Serial('/dev/ttyUSB0', baudrate=460800) 

csvfile =  open('/home/raymond/Documents/Transformed_PointCloud/ins.csv','w')			#Writes data to specified file
fieldnames = ['gpstime', 'gpsweek', 'status', 'yaw', 'pitch', 'roll', 'lat', 'lng', 'alt']
writer = csv.DictWriter(csvfile, fieldnames = fieldnames, lineterminator = '\n')
writer.writeheader()

while True:
	line = s.readline()
	ary_line = line.split(',')
        print "line: " + str(line)
	if ary_line[0] == '$VNINS':
		gpstime = ary_line[1]
		gpsweek = ary_line[2]
		status = ary_line[3]
		yaw = ary_line[4]
		pitch = ary_line[5]
		roll = ary_line[6]
		lat = ary_line[7]
		lng = ary_line[8]
		alt = ary_line[9]

		writer.writerow({'gpstime': gpstime, 'gpsweek': gpsweek, 'status': status, 'yaw': yaw, 'pitch': pitch, 'roll': roll, 'lat': lat, 'lng': lng, 'alt': alt})

		print "Time: " + str(gpstime) + "\n" + "Week: " + str(gpsweek) + "\n" + "GPS Status: " + str(status) + "\n" +"yaw: " + str(yaw) + "\n" + "pitch: " + str(pitch) + "\n" + "roll: " + str(roll) + "\n" + "latitude: " + str(lat) + "\n" + "longitude: " + str(lng) + "\n" + "alt: " + str(alt) + "\n"	#print yaw, pitch 


	
