class Star {
  
  //PVector p;
  float x, y, z, pz;
  color col;
  
  Star() {
    x = random(-width/2,width/2);
    y = random(-height/2, height/2);
    z = random(width/2);
    pz = z;
    col = color(random(180, 220), random(150, 220), random(200, 255));
  }
  
  void update() {
    z = z - speed;
    
    if (z < 1) {
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
      z = width/2;
      pz = z;
      col = color(random(100, 220), random(100, 200), random(220, 255));
    }
  }
  
  void show() {
    float x1 = map(x/z, 0, 1, 0, width/2);
    float y1 = map(y/z, 0, 1, 0, height/2);
    float size = map(z, 0, width/2, 10, 0.001);
    fill(col);
    noStroke();
    ellipse(x1, y1, size, size);
    
    float px = map(x / pz, 0, 1, 0, width/2);
    float py = map(y / pz, 0, 1, 0, height/2);

    pz = z;

    stroke(col);
    strokeWeight(1.5);
    line(x1, y1, px, py);
    //line(x1, y1, x, y);
  }
}