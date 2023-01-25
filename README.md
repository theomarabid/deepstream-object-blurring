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
