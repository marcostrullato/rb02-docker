export ROS_MASTER_URI=http://192.168.1.15:11311
export ROS_IP=192.168.1.115

screen -d -m /bin/bash -c '. /create_ws/devel/setup.bash; ROS_MASTER_URI=http://192.168.1.15:11311; ROS_IP=192.168.1.115; roslaunch create_bringup joy_teleop.launch joy_config:=gamepad'

roslaunch rtabmap_ros rtabmap.launch subscribe_rgbd:=true rgbd_topic:=/camera/rgbd_image compressed:=true rtabmap_args:="--delete_db_on_start"

