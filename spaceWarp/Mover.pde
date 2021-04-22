class Mover {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass, size, dist, angle, o, hue;

  Mover(float m) {

    size = m;
    mass = m*100;
    hue = random(255);
    velocity = new PVector(-2, -2);
    //velocity = PVector.random2D();
    position = new PVector(random(width/2), random(height/3, 2*height/3));
    
    //position = new PVector(width/2, height/4);
    //dist = constrain(dist(velocity.x, velocity.y, a.position.x, a.position.y), 5, 1000);  
    //velocity.mult(random(400, 500));
    angle = random(TWO_PI);
    o = random(0.1, 0.2);

    acceleration = new PVector(0, 0);
  }

  void orbit() {
    angle = angle + o;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    pushMatrix();
    strokeWeight(0.5);
    colorMode(RGB);
    stroke(0);
    //noStroke();
    colorMode(HSB);
    fill(hue, 255, 255);
    translate(position.x*w/width, position.y*h/height);
    PVector v1 = new PVector(100, 0, 0);
    PVector v2 = new PVector(0, 100, 0);
    PVector p = v1.cross(v2);
    rotate(angle, p.x, p.y, p.z);
    //position = velocity;
    line(0, 0, 0, velocity.x, velocity.y, velocity.z);
      //line(0, 0, 0, v2.x, v2.y, v2.z);
    //line(0, 0, 0, p.x, p.y, p.z);
    //translate(velocity.x, velocity.y);
    sphereDetail(7);
    sphere(size);
    popMatrix();
  }
}