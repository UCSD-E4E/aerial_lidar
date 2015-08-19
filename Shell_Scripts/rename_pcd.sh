#!/bin/bash

# rename pcd files in a folder in reverse choronological order

cd /home/raymond/Documents/eric/diablo_flight_2/pcd/

$count = 0;
for file in `ls -t1 *.pcd`;
do
	count=$(($count + 1));
	mv $file $count.pcd
done;
