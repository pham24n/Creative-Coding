//this class is used for creating the shapes that make up of the arm

class Shape {
  Body body;
  float w,h,x,y,b;
  boolean fixed;
  Vec2 pos;
  
  Shape(float x, float y, float width, float height, boolean fixed ){
    b = random(155,255);
    this.w = width;
    this.h = height;
    this.x = x;
    this.y = y;
    this.fixed = fixed; //this boolean value is used to indicate whether the object is static or not
                        //if it is static, fixed is set to true
    createShape(); //create new shape object in Box2D world
  }
  
  void display(){
    //this is polygon shape
    
    //because the shape is moving according to the physics stimulation in Box2D world, we need to have
    //a variable to keep track of the position of the shape in Box2D world and then translate it into pixels coordinate
    //so that we can manipulate the display of the shape in pixels coordinate
    Vec2 pos = box2d.getBodyPixelCoord(body); //this variable is the position of the shape in pixels coordinate

    float a = body.getAngle(); //angle of the shape in Box2D world

    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
    
    fill(0,230);
    noStroke();

    pushMatrix();
    translate(pos.x, pos.y);
    
    rotate(-a); //the shape is rotated according to its angle in the Box2D world to get a smooth display of physics stimulation
    beginShape();
    
    //getting the vertices that make up the polygon in the Box2D world and translate them to pixels coordinate
    //so that we can use them to draw a PShape in pixesl coordinate
    for (int i = 0; i < ps.getVertexCount(); i++) {
      Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    popMatrix();
    
  }
  
  //this method is to create a Shape object in Box2D world
  //in Box2D world, this shape is represented by a polygon made up of multiple vertices
  void createShape(){
    //create and set up body in Box2D world
    BodyDef bd = new BodyDef();
    
    if (fixed) bd.type = BodyType.STATIC;
    else bd.type = BodyType.DYNAMIC;
    
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);
    
    PolygonShape sd = new PolygonShape();
    
    //set up the vertices of the polygon in Box2D world
    Vec2[] vertices = new Vec2[4];
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-w,0));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(0,-h));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(w,0));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(0,h));

    sd.set(vertices,vertices.length);
    
    //set up the fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    body.createFixture(fd);
    
    pos = box2d.getBodyPixelCoord(body);
  }
  
  //this method is used for attracting this shape to a specified x and y values in pixels coordinate
  void attract(float x,float y) {
    Vec2 worldTarget = box2d.coordPixelsToWorld(x,y);   
    Vec2 bodyVec = body.getWorldCenter();
    worldTarget.subLocal(bodyVec);
    worldTarget.normalize();
    worldTarget.mulLocal((float) 8000);
    body.applyForce(worldTarget, bodyVec);
  }
  
  float getX(){
     Vec2 pos = box2d.getBodyPixelCoord(body);
      return pos.x;
  }
  
  float getY(){
     Vec2 pos = box2d.getBodyPixelCoord(body);
      return pos.x;
  }
  


}
