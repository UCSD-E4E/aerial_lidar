#!/bin/bash

roscore &
sleep 5
rosrun velodyne_driver vdump lidar_dump eth0
