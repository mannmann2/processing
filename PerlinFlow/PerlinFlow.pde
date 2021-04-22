boolean rec = false;
boolean debug = false;
float inc = 0.05;
int s = 10;
int rows, cols;
float zoff = 0;

float hue;
color col;

int N = 10000;

PVector flow[][];
Particle p[];

void setup() {
  size(1000, 600);
  background(255);
  colorMode(HSB);
  //rect(0, 0, width-20, height-20);

  rows = floor(height/s);
  cols = floor(width/s);

  flow = new PVector[rows][cols];

  p = new Particle[N];
  for (int i = 0; i<N; i++) 
    p[i] = new Particle(random(2, 6), random(0.1, 0.4));
}

void draw() {
  if (debug) {
    background(255);
    rect(10, 10, width-20, height-20);
  }
  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      float r = noise(xoff, yoff, zoff) * TWO_PI * 4;
      PVector v = PVector.fromAngle(r);
      //v.setMag(1);
      flow[y][x] = v;
      xoff += inc;

      if (debug) {
        stroke(0, 80);
        strokeWeight(2);
        pushMatrix();
        translate(x*s, y*s);
        rotate(v.heading());
        line(0, 0, s, 0);
        popMatrix();
      }
    }
    yoff += inc;
  }
  zoff += 0.003;
  
  hue += 0.1;
  if (hue > 255)
    hue = 0;
    
  for (int i = 0; i<N; i++) {
    col = color(hue, 255, 255);
    col = color (0);
    p[i].follow(flow);
    p[i].run();
  }

  if (rec == true)
    saveFrame("output/stardance_####.jpg");

  println(frameRate);
}

void keyPressed()
{
  if (key=='x')
    saveFrame("Holo_noise.png");

  if (key=='r')
    rec = !rec;

  if (key=='d') {
    debug = !debug;
    background(255);
  }
}