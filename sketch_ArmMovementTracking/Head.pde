//this class is used for creating the display of the head object in pixels coordinate

class Head {
  float x,y,w, h;
  float angle;
  float random;
  ArrayList<Float> pointX;
  ArrayList<Float> pointY;

  Head(float x, float y, float w, float h) {
    this.x = x; //x and y values of the center point
    this.y = y;
    this.w = w; //width and height of the head display
    this.h = h;
    
    
    pointX = new ArrayList<Float>();
    pointY = new ArrayList<Float>();

    angle = 0;
   
    for (int i = 0; i < 30; i++) {
      pointY.add(random(y-h,y+h));
    }
    
    for (int i = 0; i < 30; i++) {
      pointX.add(random(x-w, x+w));
    } 
  }
  
  void display() {
    //the display of the head object is created by drawing multiple rotated triangles within a width and height distance from the center point    
    for (int i = 0; i < pointY.size(); i++) {
      //calculate the angle from the specified point to the center point
      angle = atan2(y-pointY.get(i), x - pointX.get(i)) + random;
      
      //at every point, draw a triangle
      //the triangle is rotated by an angle calculated above
      pushMatrix();
      translate(pointX.get(i), pointY.get(i));
      rotate(angle);
      fill(0,180);
      noStroke();
      triangle(-30,-8,20,0,-20,60);
      popMatrix();
    }
    random += 0.1; //this random values helps change the angle of the triangles over time
    
  }

}
