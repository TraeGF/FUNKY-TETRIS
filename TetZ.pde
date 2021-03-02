class TetZ extends Tetronimoes{
  
 TetZ(float x, float y){
   super(x, y);
 }
  
  // Drawing the TetI
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
  
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    noFill();
    stroke(150,255,150);
    strokeWeight(3);

    ellipse(0,0,d,d);
    ellipse(d,0,d,d);
    ellipse(d*1.5,d*0.866,d,d);
    ellipse(d*2.5,d*0.866,d,d);

    popMatrix();
  }
  
  
  void makeBody(Vec2 center) {
  super.makeBody(center);
  
  CircleShape circle1 = new CircleShape();
    circle1.m_radius = box2d.scalarPixelsToWorld(r);

    CircleShape circle2 = new CircleShape();
    circle2.m_radius = box2d.scalarPixelsToWorld(r);
    Vec2 offset = new Vec2(d,0);
    offset = box2d.vectorPixelsToWorld(offset);
    circle2.m_p.set(offset.x,offset.y);
    
    CircleShape circle3 = new CircleShape();
    circle3.m_radius = box2d.scalarPixelsToWorld(r);
    Vec2 offset2 = new Vec2(d*1.5,d*0.866);
    offset2 = box2d.vectorPixelsToWorld(offset2);
    circle3.m_p.set(offset2.x,offset2.y);
    
    CircleShape circle4 = new CircleShape();
    circle4.m_radius = box2d.scalarPixelsToWorld(r);
    Vec2 offset3 = new Vec2(d*2.5,d*0.866);
    offset3 = box2d.vectorPixelsToWorld(offset3);
    circle4.m_p.set(offset3.x,offset3.y);
    
    FixtureDef fd1 = new FixtureDef();
    fd1.shape = circle1;
    fd1.density = 1;
    fd1.friction = 1;
    fd1.restitution = 0.25;
    body.createFixture(fd1);
    
    FixtureDef fd2 = new FixtureDef();
    fd2.shape = circle2;
    fd2.density = 1;
    fd2.friction = 1;
    fd2.restitution = 0.25;
    body.createFixture(fd2);
    
    FixtureDef fd3 = new FixtureDef();
    fd3.shape = circle3;
    fd3.density = 1;
    fd3.friction = 1;
    fd3.restitution = 0.25;
    body.createFixture(fd3);
    
    FixtureDef fd4 = new FixtureDef();
    fd4.shape = circle4;
    fd4.density = 1;
    fd4.friction = 1;
    fd4.restitution = 0.25;
    body.createFixture(fd4);

  }
}
