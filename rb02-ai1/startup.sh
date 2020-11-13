#!/bin/bash
screen -d -m roscore
screen -d -m /bin/bash -c '. /create_ws/devel/setup.bash; roslaunch create_bringup create_2.launch'

docker run --device=/dev/ttyUSB0 --device /dev/bus/usb:/dev/bus/usb -i -t --entrypoint /bin/bash images.strullato.com:8080/rb02-all-in-one:1.1
