

class ArmRight extends Arm {
  
  ArmRight(int n, float x, float y, float w, float h) {
    super(n,x,y,w,h);
    makeBody();
  }
  
  void makeBody() {
    for(int i=0; i < numPoints; i++) {
      Shape s = null;
      
      s = new Shape(x-i*len,y+i*len,w,h,false); //create shapes that position on the right side of the head
      shapes.add(s);

      //create joints between shapes that are next to each other
      if (i > 0) {
         DistanceJointDef djd = new DistanceJointDef();
         Shape previous = shapes.get(i-1);
         djd.bodyA = previous.body;
         djd.bodyB = s.body;
         djd.length = box2d.scalarPixelsToWorld(len);
         djd.frequencyHz = 0;
         djd.dampingRatio = 0;      
         
         DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
         
      }
    }
    
    //create joint between the first shape of the arm and the head
    DistanceJointDef djdH = new DistanceJointDef();
    Shape first = shapes.get(0);
    djdH.bodyA = first.body;
    djdH.bodyB = super.head.body;
    djdH.length = box2d.scalarPixelsToWorld(len);
    djdH.frequencyHz = 0;
    djdH.dampingRatio = 0;      
      
    DistanceJoint djH = (DistanceJoint) box2d.world.createJoint(djdH);
  } 
  
  
}
