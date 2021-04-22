class SMBH {

  PVector position;
  float mass;
  float size;

  SMBH(float m, float x, float y) {
    mass = m;
    position = new PVector(x, y);
    size = 150;
  }

  void display() {
    noStroke();
    //strokeWeight(2);
    //fill(random(200, 255), random(155, 255), random(200, 255), 50);
    fill(random(100,240), random(20), random(50,180), 3);
    ellipse(position.x, position.y, size, size);
  }

  PVector attract(Star m) {
    PVector force = PVector.sub(position, m.position);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance, 50000, 100000);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction

    float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;
  }
}