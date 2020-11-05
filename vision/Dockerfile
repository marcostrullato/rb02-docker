FROM ros-melodic-jetson:1.0
RUN apt-get update; apt-get -y upgrade
RUN apt-get install -y ros-melodic-catkin python-catkin-tools python-rosdep
RUN mkdir -p /create_ws/src; cd /create_ws; catkin init; cd /create_ws/src; git clone https://github.com/marcostrullato/create_robot.git; cd /create_ws; rosdep update; rosdep install -y --rosdistro melodic --from-paths src -i
RUN cd /create_ws; catkin build
RUN usermod -a -G dialout root

RUN mkdir /src; cd ~/src; wget https://github.com/opencv/opencv/archive/3.4.0.tar.gz; wget https://github.com/opencv/opencv_contrib/archive/3.4.0.tar.gz; tar xzf 3.4.0.tar.gz; tar xzf 3.4.0.tar.gz.1; rm 3.4.0.tar.gz 3.4.0.tar.gz.1
RUN cd /src/opencv-3.4.0; mkdir build; cd build;  cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX:PATH=/opt/opencv/3.4.0 -D WITH_CUDA=ON -D CUDA_ARCH_PTX="" -D CUDA_ARCH_BIN="5.3,6.2,7.2" -D WITH_CUBLAS=ON -D WITH_LIBV4L=ON -D BUILD_opencv_python3=ON -D BUILD_opencv_python2=ON -D BUILD_opencv_java=OFF -D WITH_GSTREAMER=ON -D WITH_GTK=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D OPENCV_ENABLE_NONFREE=ON -D OPENCV_EXTRA_MODULES_PATH=/src/opencv_contrib-3.4.0/modules ..
RUN cd /src/opencv-3.4.0/build; make -j4
