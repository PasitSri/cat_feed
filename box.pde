

class Box  {
  float x,y;
  float w,h;
  Body body;
 
  Box(float x_, float y_) {
    x = x_;
    y = y_;

    w = 16;
    h = 16;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(mouseX,mouseY));
    body = box2d.createBody(bd);
    
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 0.5;

    fd.friction = 0.5;
    fd.restitution = 0.5;
 
    body.createFixture(fd);
  }
  
  boolean done(Vec2 posOfCat) {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+w*h) {
      killBody();
      return true;
    }
    //System.out.printf(" %f\n", dist(posOfCat.x, posOfCat.y, pos.x, pos.y));
    if(dist(posOfCat.x, posOfCat.y, pos.x, pos.y) <20){
      killBody();
      //System.out.printf(" %f\n", dist(posOfCat.x, posOfCat.y, pos.x, pos.y));
      return true;
    }
    return false;
  }
  
  Vec2 pos(){
    return box2d.getBodyPixelCoord(body);
  }
 
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    //System.out.printf("%f %f\n", pos.x, pos.y);
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }
  void killBody() {
    box2d.destroyBody(body);
  }
}
