#!/usr/bin/env python
import roslib
roslib.load_manifest('laser_tfs')
import rospy
import math 
import matplotlib.pyplot as plt
import numpy as np
import tf
from geometry_msgs.msg import PoseWithCovarianceStamped  

def handle_fcu_pose(msg):
    br = tf.TransformBroadcaster()
    global count
    p = msg.pose.pose.position    # capture translational position
    o = msg.pose.pose.orientation # capture quaternion

    if handle_fcu_pose.first_run:
        handle_fcu_pose.origin = p
        count = 0 
        handle_fcu_pose.first_run = False

    x_p = p.x - handle_fcu_pose.origin.x
    y_p = p.y - handle_fcu_pose.origin.y
#    print "x " + str(x_p)
#    print "y " + str(y_p)
#    print " "

    plt.ion()
    xdata = [0]*10
    ydata = [0]*10
    plt.ylim([-150,150])
    plt.xlim([-150,150])
    
    if count < 10:
       count = count + 1
    

    line, = plt.plot(xdata,ydata, 'ro')
    if count == 10:
       xdata.append(x_p)
       ydata.append(y_p) 
       line.set_xdata(np.arange(len(xdata)))
       line.set_xdata(xdata)
       line.set_ydata(np.arange(len(ydata)))
       line.set_ydata(ydata)
       count = 0
       plt.draw()
    del ydata[0]
    del xdata[0]

if __name__ == '__main__':
    rospy.init_node('test_broadcaster')
    rospy.Subscriber('/mavros/global_position/local',
                     PoseWithCovarianceStamped,
                     handle_fcu_pose)
    handle_fcu_pose.first_run = True
    handle_fcu_pose.origin = None
    rospy.spin()

