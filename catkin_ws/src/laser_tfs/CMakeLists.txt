# %Tag(FULLTEXT)%
cmake_minimum_required(VERSION 2.8.3)
project(laser_tfs)


find_package(PCL REQUIRED)


## Find catkin and any catkin packages
find_package(catkin REQUIRED COMPONENTS geometry_msgs roscpp pcl_ros rospy sensor_msgs tf)

## Declare ROS messages and services
#add_message_files(FILES Num.msg)
#add_service_files(FILES AddTwoInts.srv)

## Generate added messages and services
generate_messages(DEPENDENCIES std_msgs)

## Declare a catkin package
catkin_package()

## Build talker and listener
include_directories(${PCL_INCLUDE_DIRS})
include_directories(include ${catkin_INCLUDE_DIRS})

link_directories(${PCL_LIBRARY_DIRS})
add_definitions(${PCL_DEFINITIONS})

add_executable(listener_tf /home/raymond/catkin_ws/src/laser_tfs/src/nodes/listener_tf.cpp)
target_link_libraries(listener_tf ${catkin_LIBRARIES} ${PCL_LIBRARIES})



# %EndTag(FULLTEXT)%
