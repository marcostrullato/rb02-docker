FROM ros-melodic-jetson:1.0
RUN apt-get update; apt-get -y upgrade
RUN apt-get install -y ros-melodic-catkin python-catkin-tools python-rosdep
RUN mkdir -p /create_ws/src; cd /create_ws; catkin init; cd /create_ws/src; git clone https://github.com/marcostrullato/create_robot.git; cd /create_ws; rosdep update; rosdep install -y --rosdistro melodic --from-paths src -i
RUN cd /create_ws; catkin build
RUN usermod -a -G dialout root


