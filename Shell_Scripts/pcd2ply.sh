#!/bin/bash

# change pcd type file format to ply type file format

# change the names in the directory to fit your profile

cd /home/raymond/Documents/eric/diablo_flight_2/pcd/

$count = 0;
for file in `ls -t1 *.pcd`;
do
	count=$(($count + 1));
	pcl_pcd2ply $count.pcd $count.ply
done;
