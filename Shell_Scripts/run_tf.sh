#!/bin/bash

# Transformation node to fix fcu with world

# change the names in the directory to fit your profile

rosparam set use_sim_time true # needed to use simulation time

cd /home/raymond/catkin_ws
. /home/raymond/catkin_ws/devel/setup.bash
rosrun laser_tfs test_broadcaster.py
