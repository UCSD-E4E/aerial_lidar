#!/bin/bash

# open RVIZ with parameters set to use simulation time
# this does not set internal RViz parameters
# refer to screenshot rviz_parameter.png to see all internal parameters
# once the parameters are set, do not forget to save RViz configuration (saves time in the future)

rosparam set use_sim_time true
rosrun rviz rviz
