class Particle {

  PVector p, pp, v, a, force;
  float maxspeed, maxforce;

  Particle(float ms, float mf) {
    p = new PVector(random(width), random(height));
    pp = p.copy();
    v = PVector.random2D();
    v.mult(random(0, 3));
    a = new PVector(0, 0);
    maxspeed = ms;
    maxforce = mf;
  }

  void run() {
    update();
    edges();
    show();
  }

  void applyForce(PVector f) {
    a.add(f);
  }

  void follow(PVector vectors[][]) {
    int x = int(constrain(p.x/s, 0, cols-1));
    int y = int(constrain(p.y/s, 0, rows-1));
    force = vectors[y][x];

    //force.mult(maxspeed);
    //PVector steer = force.sub(v);
    //steer.limit(maxforce);

    applyForce(force);
  }

  void update() {
    v.add(a);
    v.limit(maxspeed);
    p.add(v);
    a.mult(0);
  }

  void edges() {
    if (p.x > width) {
      p.x = 0;     
      pp.set(p);
    }
    if (p.x < 0) {
      p.x = width;
      pp.set(p);
    }
    if (p.y > height) {
      p.y = 0;
      pp.set(p);
    }
    if (p.y < 0) {
      p.y = height;
      pp.set(p);
    }
  }
  //void edges() {
  //  if (p.x > width) {
  //    v.x = -v.x;     
  //    //pp.set(p);
  //  }
  //  if (p.x < 0) {
  //    v.x = -v.x;
  //    //pp.set(p);
  //  }
  //  if (p.y > height) {
  //    v.y = -v.y;
  //    //pp.set(p);
  //  }
  //  if (p.y < 0) {
  //    v.y = -v.y;
  //    //pp.set(p);
  //  }
  //}

  //void edges() {
  //  if (p.x > width+3) {
  //    p.x = -3;     
  //    pp.set(p);
  //  }
  //  if (p.x < -3) {
  //    p.x = width+3;
  //    pp.set(p);
  //  }
  //  if (p.y > height+3) {
  //    p.y = -3;
  //    pp.set(p);
  //  }
  //  if (p.y < -3) {
  //    p.y = height+3;
  //    pp.set(p);
  //  }
  //}

  //void edges() {
  //  if (p.x > width-D) {
  //    p.x = D;     
  //    pp.set(p);
  //  }
  //  if (p.x < D) {
  //    p.x = width-D;
  //    pp.set(p);
  //  }
  //  if (p.y > height-D) {
  //    p.y = D;
  //    pp.set(p);
  //  }
  //  if (p.y < D) {
  //    p.y = height-D;
  //    pp.set(p);
  //  }
  //}

  void show() {
    if (debug) {
      stroke(0, 150);
      strokeWeight(2);
    } else {
      stroke(col, 7);
      strokeWeight(0);
    }
    line(p.x, p.y, pp.x, pp.y);
    pp.set(p);
  }
}