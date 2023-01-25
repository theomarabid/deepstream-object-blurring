docker run --gpus all \
    -it --rm --net=host \
    --privileged \
    -v $TMP_DIR:$TMP_DIR \
    $SOURCE_DOCKER_NAME:$DOCKER_TAG \
    ./deepstream-redaction-app \
        -c configs/pgie_config_fd_lpd.txt \
        -i sample_videos/sample_output.mp4 \
        -o output.mp4
