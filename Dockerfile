FROM nvcr.io/nvidia/deepstream:6.1.1-samples

WORKDIR /opt/nvidia/deepstream/deepstream-6.1/sources/apps

# Install packages
RUN apt update && apt install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev ffmpeg && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/NVIDIA-AI-IOT/redaction_with_deepstream.git && \
    cd redaction_with_deepstream && \
    make

WORKDIR /opt/nvidia/deepstream/deepstream-6.1/sources/apps/redaction_with_deepstream

