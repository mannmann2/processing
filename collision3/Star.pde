class Star
{
  int gal;
  float mass;
  PVector p, v, a;
  color col, col2;

  Star() {  
    gal = int(random(0, 2));
    mass = random (0.5, 1) * M;
    a = new PVector(0, 0);
    
    float rad = random(0, galrad);
    float ang = random(0, 360);
    PVector gp = new PVector(cos(radians(ang))*rad, sin(radians(ang))*rad, 
                             cos(radians(ang))*rad);
    p = new PVector(gp.x, gp.y, gp.z);
    p.add(galp[gal]);
    
    v = new PVector(0, 0, 0);
    //float d = 0.001;
    //v = new PVector(gp.y * -d , gp.x * d); //, gp.z * d, gp.x * -d);
    //v.mult(speed);
    v.add(galv[gal]);
  }
  
  PVector attract(Star m) {
    PVector force = PVector.sub(p, m.p);   // Calculate direction of force
    float distance = force.mag();          // == p.dist(m.p) Distance between objects
    distance = distance * D;
    force.normalize();          // Normalize vector (distance doesn't matter here, we just want this vector for direction
    float strength = (G * mass * m.mass)/(distance * distance);
    strength = constrain(strength, X1, X2);
    force.mult(strength);                    // Get force vector --> magnitude * direction
    return force;
  }
  
  void applyForce(PVector force) {
    PVector f = force.div(mass);
    a.add(f);
  }

  void update() {
    v.add(a);
    p.add(v);
    a.mult(0);
    
    //pushMatrix();
    stroke(galcol2[gal]);
    strokeWeight(2);
    point(p.x, p.y, p.z);
    //stroke(galcol[gal]); 
    //strokeWeight(glow);
    //point(p.x, p.y, p.z);
    //fill(galcol[gal]);
    //noStroke();
    //ellipse(p.x, p.y, glow, glow);
    //translate(p.x, p.y, p.z);
    //sphere(glow/3);

    //popMatrix(); 
  }
}