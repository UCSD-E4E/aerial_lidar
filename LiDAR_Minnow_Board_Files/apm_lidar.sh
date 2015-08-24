#!/bin/bash

sudo chmod 777 /dev/ttyUSB*

roslaunch velodyne_pointcloud VLP16_points.launch &
#rosrun velodyne_driver vdump lidar_dump eth0 &
sleep 5
roslaunch apm2.launch &
sleep 5
rosservice call /mavros/set_stream_rate 0 10 1 &
sleep 5
rosbag record -o lidar_apm -e "/velodyne(.*)" -e "/mavros/(.*)"
