#!/bin/bash

# go to directory and play specific bag file using RVIZ

# change the names in the directory to fit your profile

# --clock uses simulation time
# -s 135 plays the bag file starting at 135 seconds

cd /home/raymond/Documents/eric/camp_flight3
rosbag play --clock -s 135 lidar_apm_2015-01-27-18-02-17.bag

#cd /home/raymond/Documents/eric/camp_flight_bag    
#rosbag play --clock -s 111 lidar_apm_2015-01-27-16-53-53.bag

#cd /home/raymond/Documents/eric/diablo_flight_1
#rosbag play --clock -s 110 lidar_apm_2015-01-27-16-01-07.bag

#cd /home/raymond/Documents/eric/diablo_flight_2
#rosbag play --clock -s 118 lidar_apm_2015-01-27-16-13-25.bag

#cd /home/raymond/Documents/eric/m71_5houses
#rosbag play --clock -s 310 lidar_apm_2015-01-27-16-04-11.bag

#cd /home/raymond/Documents/eric/m71_flight_1
#rosbag play --clock -s 175 lidar_apm_2015-01-27-16-31-12.bag
