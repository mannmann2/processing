float inc = 0.01;

void setup() {
  size(800, 600);
  //pixelDensity(1);
}

void draw() {

  loadPixels();
  float yoff = 0;
  for (int y=0; y<height; y++) {
    float xoff = 0;
    for (int x = 0; x<width; x++) {
      int ind = x + y*width;
      //noiseDetail(20);
      float r = noise(xoff, yoff)*255;
      //r = random(255);
      
      pixels[ind] = color (r, 255);

      xoff+=inc;
    }
    yoff += inc;
  }
  updatePixels();
  //noLoop();
}