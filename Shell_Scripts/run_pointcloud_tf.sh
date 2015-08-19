#!/bin/bash

# runs listener_tf which subscribes to tf node and point cloud and outputs transformed point cloud in another bag file

# change the names in the directory to fit your profile

# has not been perfected to work yet

cd /home/raymond/catkin_ws
catkin_make
. /home/raymond/catkin_ws/devel/setup.bash
rosrun laser_tfs listener_tf
