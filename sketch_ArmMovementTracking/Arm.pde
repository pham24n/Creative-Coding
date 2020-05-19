class Arm {

  int numPoints; //the number of shapes that make up an arm
  float w;
  float h;
  float x;
  float y;
  float len; //the length between each shape
  ArrayList<Shape> shapes;
  HeadObject head;

  Arm(int n, float x, float y, float w, float h) {
    this.w = w;
    this.h  =h;
    this.x = x;
    this.y = y;
    
    numPoints = n; 
    shapes = new ArrayList();
    len = 50;  
    
    head = new HeadObject(x,y,w+h/2-13,true); //creat a head object that the arm can be attached to

  }
  
  //this method is used for displaying the arm and the head it's attached to
  void display() {
    head.display();
    for (Shape s: shapes) {
      s.display();
    }
  }  
  
  //this method is used for attaching the arm to the head object
  void attachTo (float x, float y){
    //attach every shape that makes up of the arm to the head object
    for (Shape s: shapes){
      s.attract(x,y);
    }
  }
  
  float getX() {
    return shapes.get(shapes.size()-1).getX();
  } 
  
  float getY() {
    return shapes.get(shapes.size()-1).getY();
  } 
}
