//this class is used for creating a head object in the Box2D world so that it can work well with the arms in the Box2D world.
//this head object uses the display from the Head class

class HeadObject {

  Body body;
  float r; //radius of a circle. The head object is going to be presented by a circle object in the Box2D world for simplicity.
  boolean fixed;
  float x,y;
  Head head;
  
  HeadObject(float x, float y, float r_, boolean fixed) {
    head = new Head(x,y,35,35); //create the display of the head object
    r = r_;
    this.x = x;
    this.y = y;
    this.fixed = fixed; //this boolean value indicates whether the object is static or not
                        //if it is set to true, the head object is static
    
    createHead(); //create the head object in the Box2D world
  }

  void display() {
    head.display();
  }
  
  //this method is used for creating the head object in the Box2D world. The head object is represented by a circle
  //with a radius r in the Box2D world
  void createHead(){
    //create and set up a new body
    BodyDef bd = new BodyDef();
    if (fixed) bd.type = BodyType.STATIC;
    else bd.type = BodyType.DYNAMIC;
    bd.position = box2d.coordPixelsToWorld(x,y);
    body = box2d.world.createBody(bd);

    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    //set up the fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    body.createFixture(fd);

  }
}
