import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam; 

boolean pause = false;
float x = 6;
float y = 1;
float z = 0.1;

float sigma = 10;
float rho = 28;
float beta = 8/3.0;

float a = 0;
ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(1000, 600, P3D);
  colorMode(HSB);
  cam = new PeasyCam(this, width/2, height/2, 200, 500);
  //cam = new PeasyCam(this, 500);
}

void draw() {
  if (!pause) {
    background(0);
    float dt = 0.01;
    float dx = sigma * (y - x);
    float dy = x * (rho - z) - y;
    float dz = x * y - beta * z;

    x += dx * dt;
    y += dy * dt;
    z += dz * dt;
    points.add(new PVector(x, y, z));

    translate(width/2, height/2);
    scale(5);
    //rotateY(a);
    //rotateZ(a*0.2);
    //a += 0.01;
    noFill();

    float hu = 0;
    beginShape();
    for (PVector p : points) {
      stroke(hu, 255, 255);
      strokeWeight(0.4);
      vertex(p.x, p.y, p.z);
      //PVector offset = PVector.random3D();
      //offset.mult(0.01);
      //p.add(offset);

      hu += 0.1;
      if (hu > 255) {
        hu = 0;
      }
    }
    endShape();

    println(x, y, z);
  }
}

void keyPressed() {
  if (key == 'p')
    pause = !pause;
}