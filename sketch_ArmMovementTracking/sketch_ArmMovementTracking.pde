import processing.video.*;
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import java.awt.Rectangle;
import java.util.*;


Rectangle[] faces;
Box2DProcessing box2d;
Arm armL,armR;
int numPixels;
int[] backgroundPixels = null;
Capture video;
float backgroundX ;
float backgroundY ;
float x,y;
float maxX,maxY, minX, minY;
BackgroundRender bg;
int count;
int threshold;

void setup() {
  size(1280, 720);
  
  video = new Capture(this, width/4, height/3);
  video.start();
  numPixels = video.width *video.height;
  
  box2d = new Box2DProcessing(this); //create Box2D world
  box2d.createWorld();

  armL = new ArmLeft(6,width/2, height/2,30,50); //create left arm
  armR = new ArmRight(6,width/2, height/2,30,50); //create right arm
  
  bg = new BackgroundRender(width/2, height/2, width,height); //create background
  
  threshold = 15000;
}

void draw(){
  
  //creating variables used for keeping track of the arm movements
  minX = width; 
  maxX = 0; 
  minY = 0; 
  maxY = 0;
  
  count = 0; //variable to keep track of the number of changing pixels
      
  if (video.available()){
     
    video.read();
    video.loadPixels();
    
    //BACKGROUND SUBTRACTION
    
    //storing the background
    if( backgroundPixels ==  null) {
      backgroundPixels =new int[numPixels];
      for (int i =0; i <numPixels;i++){
        backgroundPixels[i] = video.pixels[i];  
      }
    }


    int i = 0;
    for (int y = 0; y < video.height; y++){
      for (int x = 0; x< video.width; x++){
        color currColor = video.pixels[i];
        color backgroundColor = backgroundPixels[i];
      
        int currR = (currColor >> 16) & 0xFF; //getting R,G,B values of the current pixel
        int currG = (currColor >> 8) & 0xFF;
        int currB = currColor & 0xFF;
    
        int backgroundR = (backgroundColor >> 16) & 0xFF; //getting R,G,B values of the equivalent background pixel
        int backgroundG = (backgroundColor >> 8) & 0xFF;
        int backgroundB = backgroundColor & 0xFF;
    
        int diffR = abs(currR - backgroundR); //subtracting these values
        int diffG = abs(currG - backgroundG);
        int diffB = abs(currB - backgroundB);
        
        int diff = diffR+diffG+diffB; //sum the differences

        //if the sum is above a certain threshold, it means that there is movement at the current pixel because there is a difference between the background and the current pixels
        if (diff>150){
          
          count++; //count is used to keep track of the number of changing pixels. The changing pixels represent the moving object detected from background subtraction.
                   //thus, count is used to keep track of how large the moving object is. The larger count is, the larger the object and vice versa.
          
          //track the pixel with the largest x value among all the changing pixels
          if (maxX<x){
            maxX = x;
            maxY = y;
          }
          
          //track the pixel with the smallest x value among all the changing pixels
          if (minX >x) {
            minX= x;
            minY = y;
          }
        }
        i++;
      }
      
    }
    
    //Because the width of the video is width/4 and the height of the video is height/3, we have to scale the x and y values by 4 and 3 respectively
    armL.attachTo(maxX*4,maxY*3); //left arm is attracted to the pixel with the largest x value
    armR.attachTo(minX*4,minY*3);  //right arm is attracted to the pixel with the smallest x value
  }
   
  bg.display(); //display the background
  
  //println(count); //Uncomment this to track the number of changing pixels
  
  box2d.step(); 
  
  //calculate the ratio for scaling
  //the number in the calculation is heavily monitored for a 320 x 240 video image
  //by this calculation, the more changing pixels in the image (or we can also understand as the larger the object that is detected from the camera)
  //the bigger the body object is displayed
  float ratio= (count - threshold) /1000; 
  
  //scale the body object
  translate(width/2, height/2);  
  scale(1.5 + ratio/20);  
  translate(-width/2, -height/2);
    
  armL.display(); //display the head and the arms 
  armR.display();  
  
  if (mousePressed){
    saveFrame("output####.png");
  }
}
