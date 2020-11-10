FROM ros-melodic-jetson:1.0

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
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ros-melodic-catkin python-catkin-tools python-rosdep build-essential pkg-config  libtbb2 libtbb-dev  libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libavresample-dev libtiff-dev libjpeg-dev libpng-dev python-tk libgtk-3-dev libcanberra-gtk-module libcanberra-gtk3-module libv4l-dev libdc1394-22-dev cmake python3-dev python-dev python-numpy python3-numpy ccache

#Movement setup
RUN mkdir -p /create_ws/src; cd /create_ws; catkin init; cd /create_ws/src; git clone https://github.com/marcostrullato/create_robot.git; cd /create_ws; rosdep update; rosdep install -y --rosdistro melodic --from-paths src -i
RUN cd /create_ws; catkin build
RUN usermod -a -G dialout root
RUN echo "source /create_ws/devel/setup.bash" >> /root/.bashrc

#Perception
RUN mkdir /src; cd /src; git clone https://github.com/OpenKinect/libfreenect.git; cd /src/libfreenect; mkdir build; cd build; cmake -L ..; make; make install
RUN mkdir -p /kinect_ws/src; cd /kinect_ws/src; git clone https://github.com/ros-drivers/freenect_stack.git; cd .. ; catkin_make

#Vision
RUN mkdir /src; wget -O /src/opencv-3.4.0.tar.gz https://github.com/opencv/opencv/archive/3.4.0.tar.gz; wget -O /src/opencv_contrib-3.4.0.tar.gz https://github.com/opencv/opencv_contrib/archive/3.4.0.tar.gz; tar xzf opencv-3.4.0.tar.gz; tar xzf opencv_contrib-3.4.0.tar.gz
RUN cd /src/opencv-3.4.0; mkdir build; cd build; cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX:PATH=/opt/opencv/3.4.0 -D WITH_CUDA=ON -D CUDA_ARCH_PTX="" -D CUDA_ARCH_BIN="5.3,6.2,7.2" -D WITH_CUBLAS=ON -D WITH_LIBV4L=ON -D BUILD_opencv_python3=ON -D BUILD_opencv_python2=ON -D BUILD_opencv_java=OFF -D WITH_GSTREAMER=ON -D WITH_GTK=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D OPENCV_ENABLE_NONFREE=ON -DCUDA_CUDA_LIBRARY=/usr/local/cuda-10.2/targets/aarch64-linux/lib/stubs/libcuda.so -D OPENCV_EXTRA_MODULES_PATH=/src/opencv_contrib-3.4.0/modules ..
RUN cd /src/opencv-3.4.0/build; make -j4; make install; rm -fr /src
RUN mkdir -p /vision_ws/src; cd /vision_ws/src; git clone https://github.com/marcostrullato/vision_opencv.git; git clone --recursive https://github.com/marcostrullato/darknet_ros.git
RUN cd /vision_ws/src/vision_opencv; git checkout melodic; cd /vision_ws; catkin_make -DCMAKE_BUILD_TYPE=Release


