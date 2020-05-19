class BackgroundRender{
  
  float x,y,w, h;
  float angle; 
  float constant;
  ArrayList<Float> pointX;
  ArrayList<Float> pointY;
  ArrayList<Float> c;
  
  BackgroundRender(float x, float y, float w, float h) {
    this.x = x; //x and y position of the center of the background
    this.y = y;
    this.w = w;
    this.y = y;
    
    pointX = new ArrayList<Float>();
    pointY = new ArrayList<Float>();
    
    c = new ArrayList<Float>();
    
    angle = 0;
    
    //generate multiple random x and y values all over the background
    for (int i = 0; i < 80; i++) {
      pointY.add(random(0, h));
    }
    
    for (int i = 0; i < 80; i++) {
      pointX.add(random(0,w));
    }
    
    //generate an array list of random color values between 155 and 255
    for (int i = 0; i < 80; i++) {
      c.add(random(155,255));
    }
  }
  
  void display() {
    colorMode(HSB,255);
    
    for (int i = 0; i < pointY.size(); i++) {
      //calculate the angle from the current point to the center point
      angle = atan2(y-pointY.get(i), x- pointX.get(i)) + constant;
      
      //draw a rectangle at the point 
      //the rectangle is rotated according to the angle from itself to the center point and scaled by a random number
      pushMatrix();
      translate(pointX.get(i), pointY.get(i));
      rotate(angle);
      scale(c.get(i)/20);
      fill(c.get(i),255,255,c.get(i)/5+30);
      noStroke();

      triangle(-30,-8,20,0,-20,60);
      popMatrix();
    }
    constant -= 0.001; //this constant helps change the angle of the triangles over time
    
  }
}
