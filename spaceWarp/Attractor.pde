class Attractor {
  float mass;    // Mass, tied to size
  PVector position;   // position
  boolean dragging = false; // Is the object being dragged?
  boolean rollover = false; // Is the mouse over the ellipse?
  PVector dragOffset;  // holds the offset for when object is clicked on
  float size, o, angle;

  Attractor(int s) {
    position = new PVector(width/2, height/4);
    mass = s*1000;
    size = s;
    angle = random(TWO_PI);
    o = random(0.01, 0.1);
    //dragOffset = new PVector(0.0, 0.0);
  }

  PVector attract(Mover m) {
    PVector force = PVector.sub(position,m.position);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    //d = constrain(d,5.0,100.0);                          // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * m.mass) / (d * d);     // Calculate gravitional force magnitude
    strength = constrain(strength, 0, 50);
    force.mult(strength);     // Get force vector --> magnitude * direction
    return force;
  }

  // Method to display
  void display() {
    pushMatrix();
    //if (dragging) fill (50);
    //else if (rollover) fill(100);
    //else fill(175, 200);
    colorMode(RGB);
    strokeWeight(0.5);
    stroke(0);
    //noStroke();
    //noFill();
    colorMode(HSB);
    fill(40, 240, 240);
    translate(position.x*w/width, position.y*h/height, -30);
    rotate(angle);
    angle = angle+o;
    sphereDetail(10);
    sphere(size);
    popMatrix();
  }

  // The methods below are for mouse interaction
    //void clicked(int mx, int my) {
    //  float d = dist(mx, my, position.x, position.y);
    //  if (d < mass) {
    //    dragging = true;
    //    dragOffset.x = position.x-mx;
    //    dragOffset.y = position.y-my;
    //  }
    //}

    //void hover(int mx, int my) {
    //  float d = dist(mx, my, position.x, position.y);
    //  if (d < mass) {
    //    rollover = true;
    //  } else {
    //    rollover = false;
    //  }
    //}

    //void stopDragging() {
    //  dragging = false;
    //}

    //void drag() {
    //  if (dragging) {
    //    position.x = mouseX + dragOffset.x;
    //    position.y = mouseY + dragOffset.y;
    //  }
    //}
}