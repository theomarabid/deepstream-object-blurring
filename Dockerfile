FROM nvcr.io/nvidia/deepstream:6.1.1-samples

WORKDIR /opt/nvidia/deepstream/deepstream-6.1/sources/apps

# Install packages
# Note the cuda-nvcc-11-7 package is necessary for compiling some of the examples that require
# the "crt/" files. For some reason, it is not included in the base docker.
RUN apt update && apt install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev ffmpeg \
    cuda-nvcc-11-7 && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/NVIDIA-AI-IOT/redaction_with_deepstream.git && \
    cd redaction_with_deepstream && \
    make

WORKDIR /opt/nvidia/deepstream/deepstream-6.1/sources/apps/redaction_with_deepstream

