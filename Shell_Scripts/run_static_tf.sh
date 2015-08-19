#!/bin/bash

# Fix LiDAR orientation with respect to the flight control unit (fcu)
# Run this first before run_tf.sh 

# change the names in the directory to fit your profile

cd /home/raymond/catkin_ws
. /home/raymond/catkin_ws/devel/setup.bash
rosrun tf static_transform_publisher 0 0 0 3.14 -0.65 -1.6 fcu velodyne 1 #if the lidar orientation on the mount changes, fix the angles here to account for the change
