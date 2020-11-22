docker run --device=/dev/input/js0 -i -t --entrypoint /bin/bash --network host images.strullato.com:8080/rb02-control:1.1

#export ROS_MASTER_URI=http://192.168.1.15:11311
#export ROS_IP=192.168.1.115
screen -d -m /bin/bash -c '. /create_ws/devel/setup.bash; ROS_MASTER_URI=http://192.168.1.15:11311; ROS_IP=192.168.1.115; roslaunch create_bringup joy_teleop.launch joy_config:=gamepad'

