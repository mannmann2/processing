boolean rec = false;
int cols, rows;
int s = 20;
int w = 2000;
int h = 2000;
float fly = 0;
float hue;

float[][] ter;

void setup() {
  size(1000, 600, P3D);
  frameRate(60);
  colorMode(HSB);
  cols = w/s;
  rows = h/s;

  ter = new float[cols][rows];
}

void draw() {

  fly -= 0.1;
  float yoff = fly;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      ter[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2;
    }
    yoff += 0.2;
  }

  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/2);

  background(0);
  //stroke(color (hue, 255, 255));
  fill(color (hue, 200, 150));
  hue += 0.1;
  if (hue>255) 
    hue = 0;
  //noFill();
  lights();
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*s, y*s, ter[x][y]);
      vertex(x*s, (y+1)*s, ter[x][y+1]);
    }
    endShape();
  }
  
  if (rec)
    saveFrame("output/terrain_####.jpg");
    
  println(frameRate);
}

void keyPressed() {
  if (key == 'r')
    rec = !rec;
}
