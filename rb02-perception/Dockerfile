FROM images.strullato.com:8080/ros-melodic-jetson:1.0

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics


RUN apt-get update; 
RUN mkdir /src; cd /src; git clone https://github.com/OpenKinect/libfreenect.git; cd /src/libfreenect; mkdir build; cd build; cmake -L ..; make; make install
RUN mkdir -p /kinect_ws/src; cd /kinect_ws/src; git clone https://github.com/ros-drivers/freenect_stack.git; cd .. ; catkin_make


FROM images.strullato.com:8080/ros-melodic-jetson:1.0

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ros-melodic-rtabmap-ros unzip
RUN DEBIAN_FRONTEND=noninteractive apt-get -y remove ros-melodic-rtabmap
#RUN mkdir /src/; cd /src; git clone https://github.com/Kitware/VTK.git; cd VTK; git checkout v6.3.0; mkdir build; cd build; cmake -DVTK_Group_Qt=ON -DVTK_QT_VERSION=4 -DBUILD_TESTING=OFF -DCMAKE_BUILD_TYPE=Release ..
RUN mkdir /src; cd /src; wget https://github.com/introlab/rtabmap/files/3457605/vtk6.3.0-arm64-qt4-libs-cmake.zip; unzip vtk6.3.0-arm64-qt4-libs-cmake.zip
RUN rm -f /usr/lib/aarch64-linux-gnu/libvtkGUISupportQt* /usr/lib/aarch64-linux-gnu/libvtkRenderingQt* /usr/lib/aarch64-linux-gnu/libvtkViewsQt* /usr/lib/cmake/vtk-6.3/Modules/vtkGUISupportQtWebkit.cmake 
RUN cd /src/vtk6.3.0-arm64-qt4-libs; cp libvtkGUISupportQt* /usr/lib/aarch64-linux-gnu/.; cp libvtkRenderingQt* /usr/lib/aarch64-linux-gnu/.; cp libvtkGUISupportQtSQL* /usr/lib/aarch64-linux-gnu/.; cp libvtkViewsQt* /usr/lib/aarch64-linux-gnu/.
RUN cd /src/vtk6.3.0-arm64-qt4-libs; cp vtkGUISupportQt.cmake /usr/lib/cmake/vtk-6.3/Modules/.; cp vtkGUISupportQtOpenGL.cmake /usr/lib/cmake/vtk-6.3/Modules/.; cp vtkGUISupportQtSQL.cmake /usr/lib/cmake/vtk-6.3/Modules/. ; cp vtkRenderingQt.cmake /usr/lib/cmake/vtk-6.3/Modules/.; cp vtkViewsQt.cmake /usr/lib/cmake/vtk-6.3/Modules/. 
RUN sed -i 's/IMPORTED_LINK_DEPENDENT_LIBRARIES_NONE "Qt5::OpenGL"/#IMPORTED_LINK_DEPENDENT_LIBRARIES_NONE "Qt5::OpenGL"/g' /usr/lib/cmake/vtk-6.3/VTKTargets-none.cmake; 
RUN sed -i 's/old-text/new-text/g' /usr/lib/cmake/vtk-6.3/VTKTargets-none.cmake; 

/usr/lib/cmake/vtk-6.3/VTKTargets.cmake