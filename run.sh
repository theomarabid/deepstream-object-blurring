SOURCE_DOCKER_NAME=nvcr.io/nvidia/deepstream.6.1.1-samples
DOCKER_TAG=redaction

docker run --gpus all \
    -it --rm --net=host \
    --privileged \
    $SOURCE_DOCKER_NAME:$DOCKER_TAG
