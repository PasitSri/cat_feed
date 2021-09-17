package processing.test.box2d;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import shiffman.box2d.*; 
import org.jbox2d.collision.shapes.*; 
import org.jbox2d.common.*; 
import org.jbox2d.dynamics.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class box2d extends PApplet {






Box2DProcessing box2d;
ArrayList<Box> boxes;
public void setup() {
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  boxes = new ArrayList<Box>();

}
public void draw(){
  box2d.step();
  background(255);
  if(mousePressed){
    Box p = new Box(mouseX, mouseY);
    boxes.add(p);
  }
    for(Box b: boxes){
      b.display();
    }
}


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
    fd.density = 1;

    fd.friction = 0.3f;
    fd.restitution = 0.5f;
 
    body.createFixture(fd);
  }
 
  public void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }
  public void killBody() {
    box2d.destroyBody(body);
  }
}
  public void settings() {  size(500,500); }
}
