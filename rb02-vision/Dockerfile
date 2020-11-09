FROM ros-melodic-jetson:1.0
RUN apt-get update; apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential pkg-config  libtbb2 libtbb-dev  libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libavresample-dev libtiff-dev libjpeg-dev libpng-dev python-tk libgtk-3-dev libcanberra-gtk-module libcanberra-gtk3-module libv4l-dev libdc1394-22-dev cmake python3-dev python-dev python-numpy python3-numpy ccache
RUN mkdir /src; wget -O /src/opencv-3.4.0.tar.gz https://github.com/opencv/opencv/archive/3.4.0.tar.gz; wget -O /src/opencv_contrib-3.4.0.tar.gz https://github.com/opencv/opencv_contrib/archive/3.4.0.tar.gz; cd /src/; tar xzf opencv-3.4.0.tar.gz; tar xzf opencv_contrib-3.4.0.tar.gz; rm -f /src/*gz
RUN cd /src/opencv-3.4.0; mkdir build; cd build; LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda-10.2/targets/aarch64-linux/lib; PATH=/usr/local/cuda-10.2/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX:PATH=/opt/opencv/3.4.0 -D WITH_CUDA=ON -D CUDA_ARCH_PTX="" -D CUDA_ARCH_BIN="5.3,6.2,7.2" -D WITH_CUBLAS=ON -D WITH_LIBV4L=ON -D BUILD_opencv_python3=ON -D BUILD_opencv_python2=ON -D BUILD_opencv_java=OFF -D WITH_GSTREAMER=ON -D WITH_GTK=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D OPENCV_ENABLE_NONFREE=ON -DCUDA_CUDA_LIBRARY=/usr/local/cuda-10.2/targets/aarch64-linux/lib/stubs/libcuda.so -D OPENCV_EXTRA_MODULES_PATH=/src/opencv_contrib-3.4.0/modules ..
RUN cd /src/opencv-3.4.0/build; make -j4
RUN rm -fr /src/opencv*
RUN apt-get -y install git; mkdir -p /vision_ws/src; cd /vision_ws/src; git clone https://github.com/marcostrullato/vision_opencv.git; git clone --recursive https://github.com/marcostrullato/darknet_ros.git
RUN cd /vision_ws/src/vision_opencv; git checkout melodic; 
ENV ROS_ETC_DIR=/opt/ros/melodic/etc/ros
ENV CMAKE_PREFIX_PATH=/opt/ros/melodic
ENV ROS_ROOT=/opt/ros/melodic/ros
ENV ROS_MASTER_URI=http://localhost:11311
ENV ROS_VERSION=1
ENV ROS_PYTHON_VERSION=2
ENV PYTHONPATH=/opt/ros/melodic/lib/python2.7/dist-packages
ENV ROS_PACKAGE_PATH=/opt/ros/melodic/share
ENV ROSLISP_PACKAGE_DIRECTORIES=
ENV PATH=/opt/ros/melodic/bin:/usr/local/cuda-10.2/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PKG_CONFIG_PATH=/opt/ros/melodic/lib/pkgconfig
ENV ROS_DISTRO=melodic
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda-10.2/targets/aarch64-linux/lib
RUN env; which catkin_make; cd /vision_ws; catkin_make -DCMAKE_BUILD_TYPE=Release
