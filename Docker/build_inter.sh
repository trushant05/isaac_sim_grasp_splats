#!/bin/bash

# Run the container
docker run --gpus all -it --name gs_inter \
    --entrypoint /setup_script.sh \
    gs_base:latest

# Commit the container state to a new image
docker commit --change 'ENTRYPOINT ["/bin/bash"]' gs_inter grasp_splats:v0.1

# Clean up
docker rm gs_inter 



