int r = 300;
float hu = 0;
int D = 100;
int num = 100;

float a = 0;
int c = 0;

ArrayList<Float> x = new ArrayList<Float>();
ArrayList<Float> y = new ArrayList<Float>();

void setup() {
  size(800, 600, P3D);
  colorMode(HSB);
  background(0);
}

void draw() {

  background(0);
  translate(width/2, height/2);
  noFill();
  strokeWeight(4);

  if (x.size()<num) {
    x.add(sin(a)*D/4);
    y.add(sin(a/2)*D/2);
  } else {
    x.set(c%num, sin(a)*D/4); 
    y.set(c%num, sin(a/2)*D/2);
    c+=1;
  }
  
  for (int i = 0; i<x.size(); i++) {
    stroke(hu, 255, 255); 
    //ellipse(xx.get(i), yy.get(i), r, r);
    point (x.get(i), y.get(i));
    hu += 0.003;
    if (hu > 255)
      hu = 0;
  }
  a += 0.05;
}