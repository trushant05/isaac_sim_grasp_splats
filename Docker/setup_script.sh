#!/bin/bash

# Exit on any error
set -e

# Function to print error messages
error_exit() {
	echo "Error: $1"
	exit 1
}

echo "=== Starting Installation ==="

# Install diff-gaussian-rasterization submodule
echo "Installing diff-gaussian-rasterization.."
cd /GraspSplats/feature-splatting-inria/submodules/diff-gaussian-rasterization || error_exit "diff-gaussian-rasterization submodule not found."
pip install -e . || error_exit "Failed to install diff-gaussian-rasterization"

# Install simple-knn submodule
echo "Installing simple-knn..."
cd ../.. || error_exit "Could not navigate back to the root directory."
cd submodules/simple-knn || error_exit "simple-knn submodule not found."
pip install -e . || error_exit "Failed to install simple-knn."

# Install remaining Python requirements
echo "Installing remaining Python requirements..."
cd ../.. || error_exit "Could not navigate back to the root directory."
pip install -r requirements.txt || error_exit "Failed to install requirements from requirements.txt."

# Install Grasp Pose Detection (GPD)
echo "Installing Grasp Pose Detection (GPD)..."
cd /GraspSplats/gpd || error_exit "Could not navigate to gpd directory."
mkdir -p build && cd build || error_exit "Failed to create or navigate to gpd build directory."
cmake .. || error_exit "Failed to run cmake for GPD."
make -j8 || error_exit "Failed to build GPD using make."
cd ../.. || error_exit "Could not navigate to root directory."

# Install additional dependencies for grasping and visualization
echo "Installing additional Python dependencies for grasping and visualization..."
pip install viser==0.1.10 roboticstoolbox-python transforms3d || error_exit "Failed to install visualization dependencies."
pip install panda_python || error_exit "Failed to install panda_python."

# Downgrade scipy for randn issue in roboticstoolbox
pip install "scipy<1.12.0"

# Compute object part features
python3 feature-splatting-inria/compute_obj_part_feature.py -s scene_data/example_data

# Perform feature splatting training
python3 feature-splatting-inria/train.py -s scene_data/example_data -m outputs/example_data --iterations 3000 --feature_type "clip_part"

# Open a shell 
# exec bash

echo "Installation complete"
