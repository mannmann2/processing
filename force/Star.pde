class Star {
 
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float size;
  color c;
  
  Star(float m, float x, float y) {
    mass = m;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    size = random(10, 25);
    if (size < 13) 
      c = color(random(50, 100), random(20), random(180,255));
    else if (size < 20)
      c = color(random(180, 240), random(80, 180), random(20));
    else 
      c = color(random(210, 255), random(80), random(20)); 
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
    noStroke();
    //strokeWeight(2);
    //fill(random(250), random(155), random(20), 50);
    fill(c, 140);
    ellipse(position.x, position.y, size, size);
  }

  PVector attract(Star m) {
    PVector force = PVector.sub(position, m.position);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance, 5000, 10000);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction

    float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;
  }
  
  PVector attract(Planet p) {
    PVector force = PVector.sub(position, p.position);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance, 100, 500);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction

    float strength = (g * mass * p.mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;
  }
}