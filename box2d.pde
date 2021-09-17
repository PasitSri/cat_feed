import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
ArrayList<Box> boxes;
ArrayList<Boundary> boundaries;
Cat c;
void setup() {
  size(500,500);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  boxes = new ArrayList<Box>();
  
  boundaries = new ArrayList<Boundary>();
  boundaries.add(new Boundary(0, height, width*2, 10));
  boundaries.add(new Boundary(width-5,height/2,10,height));
  boundaries.add(new Boundary(5,height/2,10,height));
  c = new Cat();
}
void draw(){
  box2d.step();
  background(255);
  
  Vec2 boxOfFeed;
  try{
    boxOfFeed = boxes.get(0).pos();
  }catch(Exception e){
    boxOfFeed = new Vec2(width/2, 0);
  }
  //Vec2 force = c.attract(boxOfFeed);
  //System.out.printf("%f %f \n", force.x, force.y);
  //c.applyForce(force);
  c.display(boxOfFeed);
  
  
  if(mousePressed){
    Box p = new Box(mouseX, mouseY);
    boxes.add(p);
  }
  
  //p.display();
  for (Boundary wall: boundaries) {
    wall.display();
  }
  
  for(Box b: boxes){
      b.display();
  }
  
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done(c.pos())) {
      boxes.remove(i);
    }
  }
}
