Blob[] blobs = new Blob[5];
boolean debug = false;
boolean rec = false;

void setup() {
  size(1000, 600);
  colorMode(HSB);
  for (int i = 0; i < blobs.length; i++) {
    blobs[i] = new Blob(random(width), random(height));
  }
}

void draw() {
  background(51);

  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int index = x + y * width;
      float sum = 0;
      for (Blob b : blobs) {
        float d = dist(x, y, b.pos.x, b.pos.y);
        sum += 100 * b.r / d;
      }
      pixels[index] = color(sum, 255, 255);
    }
  }

  updatePixels();

  for (Blob b : blobs) {
    b.update();
    if (debug)
      b.show();
  }
  
  if (rec)
    saveFrame("output/metaball_####.jpg");
    
  println (frameRate);
}

void keyPressed() {
  if (key == 'r')
    rec = !rec;
    
  if (key=='d')
    debug = !debug;
}