#!/bin/bash

export ROS_IP=192.168.1.15
export ROS_MASTER_URI=http://192.168.1.15:11311

screen -d -m roscore
screen -d -m /bin/bash -c '. /create_ws/devel/setup.bash; roslaunch create_bringup create_2.launch'
screen -d -m /bin/bash -c '. /kinect_ws/devel/setup.bash; roslaunch freenect_launch freenect.launch'
screen -d -m /bin/bash -c '. /kinect_ws/devel/setup.bash; roslaunch rtabmap_ros rgbd_mapping.launch rtabmap_args:="--delete_db_on_start --Vis/MaxFeatures 500 --Mem/ImagePreDecimation 2 --Mem/ImagePostDecimation 2 --Kp/DetectorStrategy 6 --OdomF2M/MaxSize 1000 --Odom/ImageDecimation 2" rtabmapviz:=false'
screen -d -m /bin/bash -c '. /vision_ws/devel/setup.bash; roslaunch darknet_ros darknet_ros.launch'
#screen -d -m /bin/bash -c '. /create_ws/devel/setup.bash; roslaunch create_bringup joy_teleop.launch'


screen -d -m /bin/bash -c '. /opt/ros/melodic/setup.bash; . /create_ws/devel/setup.bash --extend; . /kinect_ws/devel/setup.bash --extend; . /vision_ws/devel/setup.bash --extend; . /rb02_ws/devel/setup.bash --extend; roslaunch roomba roomba.launch'

docker run --device=/dev/ttyUSB0 --device /dev/bus/usb:/dev/bus/usb -i -t --entrypoint /bin/bash --network host images.strullato.com:8080/rb02-all-in-one:1.2
