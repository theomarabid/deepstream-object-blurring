# deepstream-object-blurring
This repository demonstrates how to use DeepStream's redaction app for blurring objects. Typically used for privacy reasons. This Dockerfile clones the source code for the sample app provied in the [redaction_with_deepstream](https://github.com/NVIDIA-AI-IOT/redaction_with_deepstream) repository. It relies on the [DeepStream Container](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/deepstream). Note we use the samples tag `deepstream:6.1.10samples` and that accessing this link may require signing into an NVIDIA NGC account.


# Usage
## Building and Connecting to the Docker Container
1. Build the docker container by running the build script with `sh build.sh`.
2. Connect to the docker container using the run script with `sh run.sh`.
3. You should now be in the docker container. Run the examples provided below.

## DeepStream Sample Video Inference
To run inference provided by DeepStream, run the following command:
```
./deepstream-redaction-app -c configs/pgie_config_fd_lpd.txt -i sample_videos/sample_output.mp4 -o output.mp4
```
This will generate an `output.mp4` file that overlays bounding boxes on License Plates and Faces as part of the blurring demo.

## Running Inference on Video Stored on S3
This example shows how a video stored on S3 can be retrieved, infered on, and then uploaded back to S3. Note that running this example assumes you have the correct permissions for reading / writing to an S3 bucket. In our example, we use an EC2 instance with an IAM role set for the correct permissions. See AWS's Security Best Practices [link](https://docs.aws.amazon.com/AmazonS3/latest/userguide/security-best-practices.html) for more information in case an IAM role is not used.


## Candidate Files
1. /home/omarabid/quantiphi/cfa/data/01072/01072_dt_stack_10_13.mp4
    - res: 1920 x 1080
    - may be used for face blurring
2. /home/omarabid/quantiphi/cfa/data/01573/10_13_upload/01573_outside_dt_window_10_13.mp4
    - may be used for face blurring
    - input video size: 1920 x 1080
    - face size: 20 x 20 (0.02% of input frame)
3. /home/omarabid/quantiphi/cfa/data/01391/192.168.129.116/profile5/01391_192.168.129.116_profile5_2021-12-21-17.20.02.mp4
    - not ideal, but may be used for LPD
4. /home/omarabid/quantiphi/cfa/data/01573/10_13_upload/01573_dt_entrance_10_13.mp4
    - potentially for LPD.
    - LPs are very small and will most likely be missed
5. /home/omarabid/quantiphi/cfa/data/01573/192.168.129.116/profile4/01573_192.168.129.116_profile4_2022-09-28-00.18.05.mp4
    - potentially for LPD.
    - this is a 360 camera, so I will need to pick the area to infer upon.


## Clipping
export INPUT_VIDEO=input.mp4
ffmpeg -i $INPUT_VIDEO -ss 00:00:00 -t 00:02:00 -c:v copy -c:a copy $INPUT_VIDEO.clip.mp4

## Notes

### deepstream_redaction_app.c
- L299: Image width / height @ 1280 x 720 (1.77)
- L312: image width / height @ 1280 x 720

### Experimentation with Other Models
- If the provided model doesn't work, experiment with using one of the test applications on the other trained models on NGC
- [FaceNet](https://catalog.ngc.nvidia.com/orgs/nvidia/teams/tao/models/facenet)
    - input resolution: 736 x 416 x 3 (1.77)
- [LPDNet](https://catalog.ngc.nvidia.com/orgs/nvidia/teams/tao/models/lpdnet)
    - input resolution: 640 x 480 x 3 (1.33)
- DeepStream Redaction FD + LPD Model
    - input resolution: 480 x 270 x 3 (1.77)

### DeepStream Plugin Reference
- [NVinfer](https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_plugin_gst-nvinfer.html)


## Examples
### Video A
- 01573/192.168.129.116/profile4/01573_192.168.129.116_profile4_2022-01-05-17.20.13.mp4
```
resized_frame = frame[100:500, 1100:, :]
(1200, 1600, 3) -> (400,500, 3)
```
1. deepstream-object-blurring/lpd_blurring_crop_example_good_3.mp4 and
    deepstream-object-blurring/lpd_blurring_crop_example_good_1.mp4
    - Uses the fd_lpd_model from the redaction app.
        - input resolution: 480 x 270 x 3 (1.77)
2. deepstream-object-blurring/lpd_blurring_crop_example_good_2.mp4
    - Uses the LPDNet only (no face detection)
        - input resolution: 640 x 480 x 3 (1.33)

### Video B
- 01573/10_13_upload/01573_outside_dt_window_10_13.mp4
```
resized_frame = frame[400:1000, 860:1920, :]
(1080, 1920, 3) -> (600, 1060, 3)
```
3. deepstream-object-blurring/face_blurring_crop_example.mp4
    - Uses the fd_lpd_model from the redaction app.
        - input resolution: 480 x 270 x 3 (1.77)

