#!/bin/bash

docker run -it --rm \
	--device=/dev/input/js0 \
	--entrypoint /bin/bash \
	--privileged \
	--network host \
	--env="DISPLAY" \
	--env="QT_X11_NO_MITSHM=1" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix"  \
	--volume="$HOME/.Xauthority:/root/.Xauthority" \
	images.strullato.com:8080/rb02-control:1.2
