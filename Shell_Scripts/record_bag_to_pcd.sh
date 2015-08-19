#!/bin/bash

# subscribe to velodyne_points and extract point cloud from bag file

cd /home/raymond/Documents/eric/diablo_flight_2/pcd/
rosrun pcl_ros pointcloud_to_pcd input:=/pointcloud2

