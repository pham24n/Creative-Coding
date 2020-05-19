# Creative-Coding
# BODY MOVEMENT TRACKING PROJECT

This is a creative coding project that aims to create an aesthetic-looking program that simulates human body movements. This project spanned over 3 months and is operated mainly on Processing 3.5.3.

The program creates a piece of art that features an object embodying the human’s head and arms. This object simulates the arms’ movements and responses to the distance from the human body to the camera. A video illustrating how the program works is in the documentation folder.

The program utilizes the background subtraction technique to detect the human body from the camera and its movements. To create a smooth simulation of the arms’ movements, the program keeps track of the largest and smallest x-values of the changing pixels (A changing pixel is a pixel whose value is different from its background value. It indicates that there is a movement at the specified pixel. Thus, a group of changing pixels represents the human body in the image). The reason for keeping track of the smallest and largest x values is because if we measure the body’s width, the left arm is usually in the lowest range and the right arm is in the largest range. Hence, the pixel with the smallest x-value would tend to locate near the left arm and the pixel with the largest x-value would locate near the right arm. This works well under many cases when the image of the arms is distinctive to the rest of the body, for example,
  
when a person raises their hand above his/her head or when a person stretches out his/her arms horizontally or diagonally.
The object also responses to how close the person is to the camera. It gets larger if the person gets closer to the camera and vice versa. This is done by keeping track of how many changing pixels are there. The more changing pixels, the closer the person is to the camera. To stimulate a smooth simulation, the program calculates the ratio of the changing pixels to a threshold. This threshold is the average number of changing pixels that we can estimate after running the program multiple times. If the number of the changing pixels is above the threshold, it means that the body now comprises a majority of the image which can indicate that it is close to the camera and vice versa. The threshold is heavily monitored in the program. The threshold being used in the program is 15000 pixels for a 320 x 240 video image.

The program also utilizes the Box2D library by Daniel Shiffman to create smooth physics simulations for the arms of the object. For reference on how to use the Box2D physics simulation, please find the documentation for the Box2D library here: http://box2d.org/documentation.html.

There are some limitations when it comes to the accuracy of the arms’ movement detection. To create the expected simulations, it is recommended that:
- The program is run initially with a clean background cleared of objects
- There is only one person in front of the camera
- The arms are not moving too fast
- The image of the arms is distinctive to the image of the rest of the body
