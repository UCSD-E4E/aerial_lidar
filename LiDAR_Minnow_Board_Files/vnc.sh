#!/bin/bash

export DISPLAY=:0

if [[ `ps -A | grep x11vnc | awk -f " " '{print $1}'` == "" ]];
	then
		x11vnc -bg -reopen -forever -passwd remote -shared -viewpasswd view -display :0
fi
#ssh -R 10003:127.0.0.1:5900 terraintest@cg22.ucsd.edu
