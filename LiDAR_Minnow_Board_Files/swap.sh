#!/bin/bash

# Initialization - only use if you need to recreate the swap file
#sudo dd if=/dev/zero of=/home/eric/swappy bs=1024M count=64
#sudo mkswap swappy

sudo swapon swappy
