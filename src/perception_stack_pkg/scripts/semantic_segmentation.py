#!/usr/bin/env python3

import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2
import numpy as np
import torch
from torchvision import transforms

# Load the pre-trained DeepLabV3 model
model = torch.hub.load('pytorch/vision:v0.10.0', 'deeplabv3_resnet50', pretrained=True)
model.eval()

# Set up the ROS-to-OpenCV bridge
bridge = CvBridge()

# Initialize a frame counter
frame_id = 0

# Define preprocessing transformations for the model
preprocess = transforms.Compose([
    transforms.ToPILImage(),
    transforms.Resize((256, 256)),  # Resize for the model
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])

# Define a fixed colormap (21 classes based on DeepLabV3 training data)
COLORMAP = np.array([
    [0, 0, 0],        # Background (Black)
    [128, 0, 0],      # Aeroplane (Maroon)
    [0, 128, 0],      # Bicycle (Green)
    [128, 128, 0],    # Bird (Olive)
    [0, 0, 128],      # Boat (Navy Blue)
    [128, 0, 128],    # Bottle (Purple)
    [0, 128, 128],    # Bus (Teal)
    [128, 128, 128],  # Car (Gray)
    [64, 0, 0],       # Cat (Dark Red)
    [192, 0, 0],      # Chair (Bright Red)
    [64, 128, 0],     # Cow (Dark Olive)
    [192, 128, 0],    # Dining Table (Orange)
    [64, 0, 128],     # Dog (Dark Purple)
    [192, 0, 128],    # Horse (Pink)
    [64, 128, 128],   # Motorbike (Dark Teal)
    [192, 128, 128],  # Person (Light Pink)
    [0, 64, 0],       # Potted Plant (Dark Green)
    [128, 64, 0],     # Sheep (Brown)
    [0, 192, 0],      # Sofa (Bright Green)
    [128, 192, 0],    # Train (Lime)
    [0, 64, 128],     # TV/Monitor (Sky Blue)
], dtype=np.uint8)


def image_callback(msg):
    """Callback to process the incoming image and publish blended segmentation output."""
    global frame_id  # Use the frame counter

    try:
        # Increment the frame ID
        frame_id += 1

        # Convert the ROS image to OpenCV format
        cv_image = bridge.imgmsg_to_cv2(msg, "bgr8")

        # Save the original image dimensions
        original_size = cv_image.shape[:2]

        # Preprocess the input image for the model
        input_tensor = preprocess(cv_image)
        input_batch = input_tensor.unsqueeze(0)  # Add batch dimension

        # Perform inference with the model
        with torch.no_grad():
            output = model(input_batch)['out'][0]  # Model output
        output_predictions = output.argmax(0).byte().numpy()  # Get class indices (HxW)

        # Resize the output predictions back to the original image size
        output_resized = cv2.resize(output_predictions, (original_size[1], original_size[0]), interpolation=cv2.INTER_NEAREST)

        # Create a colorized segmentation image
        segmented_frame = COLORMAP[output_resized]

        # Blend the segmented regions with the original frame
        blended_output = cv2.addWeighted(cv_image, 0.7, segmented_frame, 0.3, 0)

        # Convert the blended output to a ROS Image message and publish it
        blended_msg = bridge.cv2_to_imgmsg(blended_output, encoding="rgb8")
        blended_pub.publish(blended_msg)

        # Display the blended output
        cv2.imshow("Blended Segmentation", blended_output)
        cv2.waitKey(1)

        # Print the frame ID
        rospy.loginfo(f"Frame ID: {frame_id} - Blended segmentation successfully applied.")

    except Exception as e:
        rospy.logerr(f"Error in processing image (Frame ID: {frame_id}): {e}")


def main():
    """Main function to initialize the ROS node and manage topics."""
    global blended_pub

    rospy.init_node('blended_segmentation_node')

    # Publisher for blended semantic segmentation frames
    blended_pub = rospy.Publisher("/blended_frame", Image, queue_size=10)

    # Subscriber to the input camera stream
    rospy.Subscriber("/camera_stream", Image, image_callback)

    rospy.loginfo("Blended Segmentation Node Initialized.")
    rospy.spin()


if __name__ == "__main__":
    main()
