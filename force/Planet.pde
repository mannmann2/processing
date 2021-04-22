class Planet {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float size;

  Planet(float m, float x, float y) {
    mass = m;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    size = random(0.1, 3);
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
    //stroke(0);
    //strokeWeight(2);
    //fill(random(255), random(155), random(255));
    fill(30, 16, 50);
    ellipse(position.x, position.y, size, size);
  }

  PVector attract(Planet m) {
    PVector force = PVector.sub(position, m.position);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance, 10.0, 100.0);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction

    float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;
  }


}