# Use NVIDIA base image with Ubuntu 22.04 and CUDA development libraries
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

# Set non-interactive mode for installations
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    git \
    curl \
    build-essential \
    cmake \
    libopencv-dev \
    libeigen3-dev \
    libpcl-dev \
    python3-pip \
    ninja-build \
    x11-apps \
    libgl1-mesa-glx \
    libxrender1 \
    libsm6 \
    libxext6 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Ensure CUDA toolkit and runtime are properly configured
ENV CUDA_HOME=/usr/local/cuda
ENV PATH="/usr/local/cuda/bin:$PATH"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# Clone Grasp Splats Repo
RUN git clone https://github.com/jimazeyu/GraspSplats.git 
WORKDIR /GraspSplats

RUN git clone --recursive https://github.com/vuer-ai/feature-splatting-inria.git && \
    cd feature-splatting-inria && \
    git checkout roger/graspsplats_part

# Create and activate the micromamba environment
RUN pip install torch==2.1.2+cu118 torchvision==0.16.2+cu118 --extra-index-url https://download.pytorch.org/whl/cu118 
   
# Set up GUI environment variables
ENV DISPLAY=:0
ENV QT_X11_NO_MITSHM=1

COPY ./setup_script.sh /setup_script.sh
RUN chmod +x /setup_script.sh

CMD ["bash"]
