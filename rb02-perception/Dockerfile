FROM ros-melodic-amd64:1.0 
RUN apt-get update; apt-get -y upgrade
RUN mkdir /src; cd /src; git clone https://github.com/OpenKinect/libfreenect.git; cd /src/libfreenect; mkdir build; cd build; cmake -L ..; make; make install
RUN mkdir -p /kinect_ws/src; cd /kinect_ws/src; git clone https://github.com/ros-drivers/freenect_stack.git; cd .. ; catkin_make
