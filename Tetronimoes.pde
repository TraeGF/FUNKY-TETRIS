class Tetronimoes {
  
  // We need to keep track of a Body and a radius and diameter
  Body body;
  float r;
  float d;

  // Constructor
  Tetronimoes(float x, float y) {
  
    r = 10.5;
    d = 2*r;

    // Add the shape to the box2d world
    makeBody(new Vec2(x, y));
    // Create user data for the body
    body.setUserData(this);
  }

void display() {
    
}

  // This function removes the shape from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the shape ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+d*3) {
      killBody();
      return true;
    }
    return false;
  }

  // create the function for applying force to shape
   void applyForce(Vec2 force) {
   Vec2 pos = body.getWorldCenter();
   println(pos);
   body.applyForce(force, pos);
  }

  // function for applying spin to shape
  void setSpin(float vel) {
  body.setAngularVelocity(vel);
  }

  // This function adds the circles to the box2d world
  void makeBody(Vec2 center) {
    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);    
    
    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(random(-5, 5), -1));
    body.setAngularVelocity(0);
  }
}
