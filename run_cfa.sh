docker run --gpus all \
    -it --rm --net=host \
    --privileged \
    -v $TMP_DIR:$TMP_DIR \
    $SOURCE_DOCKER_NAME:$DOCKER_TAG \
    ./deepstream-redaction-app \
        -c configs/pgie_config_fd_lpd.txt \
        -i $TMP_DIR/input_video.mp4 \
        -o $TMP_DIR/output_video.mp4
