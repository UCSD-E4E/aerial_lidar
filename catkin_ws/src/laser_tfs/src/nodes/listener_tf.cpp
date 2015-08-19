#include <ros/ros.h>
#include <pcl_ros/point_cloud.h>
#include <pcl/point_types.h>
#include <tf/transform_listener.h>
#include <sensor_msgs/PointCloud2.h>
#include <pcl_ros/transforms.h>
#include <pcl/point_cloud.h>
#include <pcl/PCLPointCloud2.h>
#include <pcl_conversions/pcl_conversions.h>
#include <sensor_msgs/point_cloud_conversion.h>
#include <rosbag/bag.h>
#include <iostream>
#include <std_msgs/String.h>
#include <sensor_msgs/Image.h>
#include <pcl_ros/impl/transforms.hpp>

typedef pcl::PointCloud<pcl::PointXYZ> PointCloud2;

using namespace std;
rosbag::Bag bag;

void callback(const sensor_msgs::PointCloud2& msg)
{
   ROS_INFO("I Heard");
      static tf::TransformListener plistener(ros::Duration(1000));
      bag.open("/home/raymond/Documents/Transformed_PointCloud/diablo2.bag", rosbag::bagmode::Append);
      tf::StampedTransform transform;
      ros::Time time = ros::Time::now();
      ros::Time t = ros::Time(0);
      
      pcl::PCLPointCloud2 pcl2; //creates variable pointcloud2
      pcl_conversions::toPCL(msg,pcl2); 
      pcl::PointCloud<pcl::PointXYZ> newpcl; //creates varaible pointcloud
      pcl::PointCloud<pcl::PointXYZ> pcl_tf; //creates variable final
      pcl::fromPCLPointCloud2(pcl2, newpcl); //from pcl2 to pcl
      
      const string frametarget = "world";
     try{
      plistener.waitForTransform("world","fcu",t,ros::Duration(1.0));
      cout<<"I am waiting for the transform"<<endl;
      plistener.lookupTransform("world", "fcu",t, transform);
      cout<<"I am listening to the transform"<<endl;
     }
    catch (tf::TransformException ex){
      ROS_ERROR("%s",ex.what());
      ros::Duration(1.0).sleep();
     }
      ros::Duration d = ros::Duration(0.2);
      d.sleep();

      pcl_ros::transformPointCloud (frametarget,newpcl,pcl_tf,plistener);

      pcl::PCLPointCloud2 newpcl2;
      pcl::toPCLPointCloud2(pcl_tf,newpcl2);

      bag.write("pointcloud2", ros::Time::now(), newpcl2);
      bag.close();
      cout<<"closed"<<endl;
}

int main(int argc, char** argv){
  bag.open("/home/raymond/Documents/Transformed_PointCloud/diablo2.bag", rosbag::bagmode::Write);
  bag.close();
  ros::init(argc, argv, "listener_tf");
  ros::NodeHandle n;
  ros::Subscriber sub = n.subscribe("velodyne_points", 1,callback);
  cout<<"waiting for velodyne points"<<endl;
  ros::spin();
 
  return 0;
};
