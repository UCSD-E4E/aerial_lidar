#!/usr/bin/env python
import roslib
roslib.load_manifest('laser_tfs')
import rospy
import math 
import tf
import matplotlib.pyplot as plt
import numpy as np
from geometry_msgs.msg import PoseWithCovarianceStamped
#from velodyne_msgs.msg import VelodyneScan

def handle_fcu_pose(msg): 
    br = tf.TransformBroadcaster()
    p = msg.pose.pose.position    # capture translational position (cartesian) 
    o = msg.pose.pose.orientation # capture quaternion
    if handle_fcu_pose.first_run:
        handle_fcu_pose.origin = p
	handle_fcu_pose.orientation = o
        handle_fcu_pose.first_run = False

    x_p = p.x - handle_fcu_pose.origin.x
    y_p = p.y - handle_fcu_pose.origin.y
    z_p = p.z - handle_fcu_pose.origin.z + 0.45

    x_o = o.x
    y_o = o.y
    z_o = o.z
    w_o = o.w

#    plt.ion()  		#Plot the flight path of the LiDAR
#    xdata = [0]*10
#    ydata = [0]*10
#    plt.ylim([-10,10])
#    plt.xlim([-10,10])
#    line, = plt.plot(xdata,ydata, 'ro')
#    xdata.append(x_p)
#    ydata.append(y_p) 
#    line.set_xdata(np.arange(len(xdata)))
#    line.set_xdata(xdata)
#    line.set_ydata(np.arange(len(ydata)))
#    line.set_ydata(ydata)
#    plt.draw()
#    del ydata[0]
#    del xdata[0]
#    eul = tf.transformations.euler_from_quaternion((x_o, y_o, z_o, w_o)) #Convert Quaternion to Euler angles
#    print "roll " + str(math.degrees(eul[0])) #Print the roll angle
#    print "pitch " + str(math.degrees(eul[1])) #Print the pitch angle
#    print "yaw " + str(math.degrees(eul[2])) #Print the yaw angle
#    print " "
#    roll = tf.transformations.quaternion_from_euler(math.radians(0), 0, 0) 
#    pitch = tf.transformations.quaternion_from_euler(0, math.radians(-180), 0) #180
#    yaw = tf.transformations.quaternion_from_euler(0, 0, math.radians(-15)) #110
	
    br.sendTransform( (x_p, y_p, z_p), # x,y,z 
                      (x_o, y_o, z_o, w_o),
                      rospy.Time.now(),
                      "fcu",
                      "world")

 #   print "time: " + str(rospy.get_time())
 #   print "time: " + str(rospy.Time.now())

if __name__ == '__main__':
    rospy.init_node('test_broadcaster')
    rospy.Subscriber('/mavros/global_position/local',
                     PoseWithCovarianceStamped,
                     handle_fcu_pose)
#    rospy.Subscriber('/velodyne_packets',
#		     VelodyneScan,
#		     handle_scans)
    handle_fcu_pose.first_run = True
    handle_fcu_pose.origin = None
    rospy.spin()

