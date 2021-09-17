class Cat{
  float x, y;
  float w,h;
  Body body;
  
  Cat(){
    x = width/2;
    y = 0;

    w = 50;
    h = 50;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(mouseX,400));
    body = box2d.createBody(bd);
    
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;
    fd.friction = 1;
    fd.restitution = 0.5;
 
    body.createFixture(fd);
  }
  
  void run(Vec2 pos){
    x = pos.x;
  }
  
  Vec2 pos(){
    return new Vec2(x, 470);
  }
  
  void applyForce(Vec2 force) {
    //Vec2 pos = body.getWorldCenter();
    body.applyForce(force, body.getWorldCenter());
}
  
  

Vec2 attract(Box m){
  float G = 100; // Strength of force{
  Vec2 pos = body.getWorldCenter();
  Vec2 moverPos = m.body.getWorldCenter();
  Vec2 force = moverPos.sub(pos);
  float distance = force.length();
  distance = constrain(distance,1,5);
  force.normalize();
  float strength = (G * 1 * 1) / (distance * distance);

  force.mulLocal(strength);
  return force;
}


  
  void display(Vec2 pos1) {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    //System.out.printf(" %f %f\n", x, pos.y);
    run(pos1);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(a);
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(x,y,w,h);
    popMatrix();
  }
  
}
