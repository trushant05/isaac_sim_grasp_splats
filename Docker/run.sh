#!/bin/bash

docker run -it --rm --gpus all -p 8080:8080 \
	-e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	grasp_splats:v0.1

