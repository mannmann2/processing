Star[] Stars;
PVector[] galp;
PVector[] galv;
color[] galcol, galcol2;
boolean paused = false;
int N = 1000;   // number of Stars
int obsize = 20;     // size of glow
float speed = 8;     // intial speed limit
float gravity = 0.3; // gravity strength coefficient
float gpower = 2.0;  // gravity power variable (range 1 - 2.5)
float galrad = 70;   // galaxy radius
float sep = 150;     // galaxy seperation
float gv = 1.8;      // galaxy y velocity
int trans = 3;       // glow transparency

void setup()
{
  translate(width/2, height/2);
  frameRate(25);
  size(1200, 720);
  background(20);
  galp = new PVector[2];
  smooth();
  galp[0] = new PVector(-sep, 0);
  galp[1] = new PVector(sep, 0);

  galv = new PVector[2];
  galv[0] = new PVector(0, gv);
  galv[1] = new PVector(0, -gv);

  galcol = new color[2];
  galcol2 = new color[2];
  
  galcol[0] = color(150, 100, 255, trans);
  galcol[1] = color(200, 200, 0, trans);
  galcol2[0] = color(150, 100, 255);
  galcol2[1] = color(200, 200, 0);

  Stars = new Star[N];
  for (int i=0; i<Stars.length; i++) 
      Stars[i] = new Star(i);
}

void draw()
{
  if(paused==false)
  {
    background(0);
    translate(width/2, height/2);
    noStroke();
    for (Star o:Stars)
      o.gravity();
      
    for (Star o:Stars) {
      o.move();
      fill(o.col);
      noStroke();
      ellipse(o.p.x, o.p.y, obsize, obsize);
      stroke(o.col2);
      strokeWeight(1);
      point(o.p.x, o.p.y);
    }
  }
}    

class Star
{
  PVector p, v;
  color col, col2;
  int gal;

  Star(int i)
  {
    gal = i%2;
    float rad = random(0, galrad);
    float ang = random(0., 360.);
    PVector gp = new PVector(cos(radians(ang))*rad, sin(radians(ang))*rad);
    p = new PVector(gp.x, gp.y);
    p.add(galp[gal]);
    float d = constrain(100/p.mag() - 0.2,0,0.4) * 0.02;
    v = new PVector(gp.y * d, gp.x * -d);
    v.mult(speed);
    v.add(galv[gal]);
    col = galcol[gal];
    col2 = galcol2[gal];
  }

  void gravity()
  {
    for (Star o:Stars)
    {
      if (o!=this)
      {
        PVector d = new PVector(p.x, p.y);
        d.sub(o.p);
        float power = constrain(d.mag(), 1, 10000);// prevent infinite gravity
        power = pow(power, -gpower); // inverse power function
        d.mult(power*-gravity);
        v.add(d);
      }
    }
  }

  void move()
  {
    p.add(v);
  }
}

void keyPressed()
{
  if (key=='p')
      paused = !paused;
}