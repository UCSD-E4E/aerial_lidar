Before continuing, make sure all shell files are made executable using chmod +x "file name"
All Python code files should also be made exexutable. 

Before continuing, make sure you have "roscore" running in the background. Open up a new terminal and type "roscore". 

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Once you have roscore running in the background, run the shell files in the order below:
1) run_rviz.sh
2) run_static_tf.sh
3) run_tf.sh
4) play_bag_file.sh

If everything goes accordingly, RViz should be playing the bag file selected in "play_bag_file.sh"
 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
List of shell files available and their purposes:
pcd2ply.sh
This shell file converts a pcd file to a ply file. ROS has a pointcloud library "pcl_ros" that can help do many things like converting file types. Because RViz was not built to process pointclouds, the pointclouds must be exported to a filetype that an editor can read. The program of choice is called MeshLab. MeshLab cannot read pcd files so the pcd files must be converted to ply. 

play_bag_file.sh
Plays the specific bag file at a specific time.

play_pcd_files.sh
If you have a set of pcd files that you would like to verify before converting it to a ply file, run this shell file. It will open all the pcd file for view only. 

record_bag_to_pcd.sh
"pcl_ros" again includes a number of useful tools including one that extracts pointclouds from a playing bag file and exports it to a pcd file. 

remove_backup.sh
This shell file has no purpose in the LiDAR project. When a file is edited, it creates an invisible backup file that only shows up when you use the "ls" command in terminal. I found the files annoying so I made a shell file that removes all the backup files. 

rename_pcd.sh
Renames the pcd file from 1 to n, n being the number of files in the folder. 

run_pointcloud_tf.sh
This node subscribes to velodyne_points and the tf node in order to create a transformed pointcloud. By applying the transform onto the pointcloud, the final pointcloud should essentially look like something that RViz has been displaying. The purpose of this node is so we can use record_bag_to_pcd.sh. Once the pointcloud in this bag has been converted to a pcd file, it can be converted to a ply file.  

run_rviz.sh
Runs RViz and sets the simulation timing parameter. If simulation time is not set to true, the pointcloud will not play in the world and fcu frame. 

run_static_tf.sh
Runs the static transformation that fixes the LiDAR's orientation with respect to the the fcu onboard the coptor. 

run_tf.sh 
Runs the transformation that fixes the coptors position and orientation with respect to the world frame. 

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
If all goes according to plan, the shell files should be used in the following order:
1) run_rviz.sh (Do not run RViz if you plan on using "run_pointcloud_tf.sh")
2) run_static_tf.sh
3) run_tf.sh
4) play_bag_file.sh

5) run_pointcloud_tf.sh
   -stop playing old pointcloud and play new pointcloud-
6) record_bag_to_pcd.sh
7) rename_pcd.sh
8) play_pcd_files.sh
9) pcd2ply.sh


