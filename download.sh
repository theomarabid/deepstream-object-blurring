mkdir -p $TMP_DIR
aws s3 cp \
    s3://smartrest-dtf-datasets/video_capture/01391/192.168.129.115/profile7/01391_192.168.129.115_profile7_2022-01-03-23.02.09.mp4 \
    $TMP_DIR/input_video.mp4