FROM ros-melodic-jetson:1.0

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

# kinect_ws/
# └── src
#     └── freenect_stack
#         ├── freenect_camera
#         ├── freenect_launch
#         ├── freenect_stack
#         └── rosinstall

# vision_ws/
# └── src
#    ├── darknet_ros
#    │   ├── darknet
#    │   ├── darknet_ros
#    │   └── darknet_ros_msgs
#    └── vision_opencv
#        ├── cv_bridge
#        ├── image_geometry
#        ├── opencv_tests
#        └── vision_opencv

#Environment variables
ENV LD_LIBRARY_PATH=/opt/ros/melodic/lib:/usr/local/cuda-10.2/targets/aarch64-linux/lib:/usr/local/cuda/lib64:/usr/local/cuda-10.2/targets/aarch64-linux/lib
ENV ROS_ETC_DIR=/opt/ros/melodic/etc/ros
ENV CMAKE_PREFIX_PATH=/opt/ros/melodic
ENV ROS_ROOT=/opt/ros/melodic/ros
ENV ROS_VERSION=1
ENV ROS_PYTHON_VERSION=2
ENV PYTHONPATH=/opt/ros/melodic/lib/python2.7/dist-packages
ENV ROS_PACKAGE_PATH=/opt/ros/melodic/share
ENV ROSLISP_PACKAGE_DIRECTORIES=
ENV PATH=/opt/ros/melodic/bin:/usr/local/cuda-10.2/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PKG_CONFIG_PATH=/opt/ros/melodic/lib/pkgconfig
ENV ROS_DISTRO=melodic

#Updates and install required packages
RUN apt-get update; apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ros-melodic-usb-cam ros-melodic-usb-cam ros-melodic-usb-cam libgusb2 libusb-1.0-0 libusb-1.0-0-dev libusbmuxd4 ros-melodic-catkin python-catkin-tools python-rosdep build-essential pkg-config  libtbb2 libtbb-dev  libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libavresample-dev libtiff-dev libjpeg-dev libpng-dev python-tk libgtk-3-dev libcanberra-gtk-module libcanberra-gtk3-module libv4l-dev libdc1394-22-dev cmake python3-dev python-dev python-numpy python3-numpy ccache ros-melodic-joy-teleop ros-melodic-teleop-tools-msgs ros-melodic-rtabmap ros-melodic-rtabmap-ros

#Movement setup
RUN /bin/bash -c "/opt/ros/melodic/setup.bash"; mkdir -p /create_ws/src; cd /create_ws; catkin init; cd /create_ws/src; git clone https://github.com/marcostrullato/create_robot.git; cd /create_ws; rosdep update; rosdep install -y --rosdistro melodic --from-paths src -i; catkin build
RUN usermod -a -G dialout root
RUN echo "source /create_ws/devel/setup.bash" >> /root/.bashrc

#Perception (at catkin_make sourcing the previous one)
RUN mkdir /src; cd /src; git clone https://github.com/OpenKinect/libfreenect.git; cd /src/libfreenect; mkdir build; cd build; cmake -L ..; make; make install
RUN /bin/bash -c "/opt/ros/melodic/setup.bash"; /bin/bash -c "/create_ws/devel/setup.bash"; mkdir -p /kinect_ws/src; cd /kinect_ws/src; git clone https://github.com/ros-drivers/freenect_stack.git; cd .. ; catkin_make
RUN echo "source /kinect_ws/devel/setup.bash" >> /root/.bashrc

#Vision
RUN cd /src; wget -O /src/opencv-3.4.0.tar.gz https://github.com/opencv/opencv/archive/3.4.0.tar.gz; wget -O /src/opencv_contrib-3.4.0.tar.gz https://github.com/opencv/opencv_contrib/archive/3.4.0.tar.gz; tar xzf opencv-3.4.0.tar.gz; tar xzf opencv_contrib-3.4.0.tar.gz
RUN cd /src/opencv-3.4.0; mkdir build; cd build; cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX:PATH=/opt/opencv/3.4.0 -D WITH_CUDA=ON -D CUDA_ARCH_PTX="" -D CUDA_ARCH_BIN="5.3,6.2,7.2" -D WITH_CUBLAS=ON -D WITH_LIBV4L=ON -D BUILD_opencv_python3=ON -D BUILD_opencv_python2=ON -D BUILD_opencv_java=OFF -D WITH_GSTREAMER=ON -D WITH_GTK=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D OPENCV_ENABLE_NONFREE=ON -DCUDA_CUDA_LIBRARY=/usr/local/cuda-10.2/targets/aarch64-linux/lib/stubs/libcuda.so -D OPENCV_EXTRA_MODULES_PATH=/src/opencv_contrib-3.4.0/modules ..; make -j4; make install
RUN /bin/bash -c "/opt/ros/melodic/setup.bash"; /bin/bash -c "/create_ws/devel/setup.bash"; /bin/bash -c "/kinect_ws/devel/setup.bash"; mkdir -p /vision_ws/src; cd /vision_ws/src; git clone https://github.com/marcostrullato/vision_opencv.git; git clone --recursive https://github.com/marcostrullato/darknet_ros.git; cd /vision_ws/src/vision_opencv; git checkout melodic; cd /vision_ws; catkin_make -DCMAKE_BUILD_TYPE=Release
RUN echo "source /vision_ws/devel/setup.bash" >> /root/.bashrc

#Cleanup
RUN rm -fr /src
