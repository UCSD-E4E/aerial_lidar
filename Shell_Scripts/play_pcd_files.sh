#!/bin/bash

# after extracting pcd file from the bag file, view all pcd files in directory using pcl_viewer

# change the names in the directory to fit your profile

# *.pcd will look for at all files in the folder and open those with the extension .pcd

cd /home/raymond/Documents/eric/camp_flight3/pcd/1
pcl_viewer *.pcd
