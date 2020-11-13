#!/bin/bash
screen -d -m roscore
screen -d -m /bin/bash -c '. /create_ws/devel/setup.bash; roslaunch create_bringup create_2.launch'
