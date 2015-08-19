#!/bin/bash

# removes all back up files from computer
# make sure the shell file is in the home folder before running
# this does not help the LiDAR project

find ./ -name '*~' | xargs rm
