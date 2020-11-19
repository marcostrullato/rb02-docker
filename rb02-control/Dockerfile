FROM images.strullato.com:8080/ros-amd64:1.0

# Workspaces

# create_ws/
# ├── build
# └── src
#     └── create_robot
#         ├── create_bringup
#         ├── create_description
#         ├── create_driver
#         ├── create_msgs
#         └── create_robot

#Environment variables
#ENV LD_LIBRARY_PATH=/opt/ros/melodic/lib:/usr/local/cuda-10.2/targets/aarch64-linux/lib:/usr/local/cuda/lib64:/usr/local/cuda-10.2/targets/aarch64-linux/lib
#ENV ROS_ETC_DIR=/opt/ros/melodic/etc/ros
#ENV CMAKE_PREFIX_PATH=/opt/ros/melodic
#ENV ROS_ROOT=/opt/ros/melodic/ros
#ENV ROS_VERSION=1
#ENV ROS_PYTHON_VERSION=2
#ENV PYTHONPATH=/opt/ros/melodic/lib/python2.7/dist-packages
#ENV ROS_PACKAGE_PATH=/opt/ros/melodic/share
#ENV ROSLISP_PACKAGE_DIRECTORIES=
#ENV PATH=/opt/ros/melodic/bin:/usr/local/cuda-10.2/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#ENV PKG_CONFIG_PATH=/opt/ros/melodic/lib/pkgconfig
#ENV ROS_DISTRO=melodic

#Updates and install required packages
RUN apt-get update;
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python-rosdep python-catkin-tools ros-melodic-catkin python-catkin-tools python-rosdep build-essential pkg-config ros-melodic-joy-teleop ros-melodic-teleop-tools-msgs
#RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ros-melodic-usb-cam ros-melodic-usb-cam ros-melodic-usb-cam libgusb2 libusb-1.0-0 libusb-1.0-0-dev libusbmuxd4 ros-melodic-catkin python-catkin-tools python-rosdep build-essential pkg-config  libtbb2 libtbb-dev  libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libavresample-dev libtiff-dev libjpeg-dev libpng-dev python-tk libgtk-3-dev libcanberra-gtk-module libcanberra-gtk3-module libv4l-dev libdc1394-22-dev cmake python3-dev python-dev python-numpy python3-numpy ccache ros-melodic-joy-teleop ros-melodic-teleop-tools-msgs ros-melodic-rtabmap ros-melodic-rtabmap-ros screen ros-melodic-rgbd-launch
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install net-tools iputils-ping

#Movement setup
RUN /bin/bash -c ". /opt/ros/melodic/setup.bash"; mkdir -p /create_ws/src; cd /create_ws; catkin init; cd /create_ws/src; git clone https://github.com/marcostrullato/create_robot.git; cd /create_ws; rosdep update; rosdep install -y --rosdistro melodic --from-paths src -i; catkin build
RUN usermod -a -G dialout root
RUN echo "source /create_ws/devel/setup.bash" >> /root/.bashrc

#Cleanup
RUN apt-get -y autoremove
