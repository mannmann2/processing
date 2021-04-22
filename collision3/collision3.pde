//import peasy.*;
//import peasy.org.apache.commons.math.*;
//import peasy.org.apache.commons.math.geometry.*;

//PeasyCam cam;

boolean paused = false;
boolean rec = false;

int glow = 24;    // size of glow
int al = 5;      // glow opacity
float galrad = 100;  // galaxy radius
float sep = 240;    // galaxy seperation
float speed = 4;   // intial speed limit
float gvx = 1;      // galaxy x velocity
float gvy = 3;      // galaxy y velocity
float gvz = 1;      // galaxy z velocity

int X1 = 0;
int X2 = 1000000; // ~100000 to 1000000
int M = 1000000000;
float D = 0.00000001;
int N = 1000;       // number of Stars
float G = 9.8;

Star[] Stars = new Star[N];
color[] galcol = new color[2];
color[] galcol2 = new color[2];
PVector[] galp = new PVector[2];
PVector[] galv = new PVector[2];

void setup()
{
  size(1200, 720, P3D);
  //cam = new PeasyCam(this, width/2, height/2, 0, 500);
  background(0);

  galcol[0] = color(200, 40, 200, al);
  galcol[1] = color(255, 200, 40, al);
  galcol2[0] = color(150, 20, 220);
  galcol2[1] = color(255, 150, 20);

  galp[0] = new PVector(-sep, 0);
  galp[1] = new PVector(sep, 0);
  galv[0] = new PVector(-gvx, gvy, -gvz);
  galv[1] = new PVector(gvx, -gvy, gvz);

  for (int i=0; i<Stars.length; i++) 
    Stars[i] = new Star();
}

void draw()
{
  if (paused==false) {
    background(0);
    translate(width/2, height/2);
    noStroke();

    for (Star i : Stars) {
      for (Star j : Stars) {
        if (i != j) {
          PVector f2 = j.attract(i);
          i.applyForce(f2);
        }
      }
    }

    for (Star i : Stars)
      i.update();
  }

  if (rec == true) {
    saveFrame("output/stardance_####.png");
    fill(255, 40, 40);
    noStroke();
    ellipse(50-width/2, 40-height/2, 15, 15);
  }

  if (paused == true) {
    fill(220);
    noStroke();
    rect(20, 20, 5, 20);
    rect(30, 20, 5, 20);
  }
  println(frameRate);
}

void keyPressed()
{
  if (key=='p')
    paused = !paused;

  if (key=='r')
    rec = !rec;
}