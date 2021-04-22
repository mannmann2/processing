static int NUM = 7;
float t;

void setup() {
  size(1200, 700);
  background(20);

}

void draw() {
  //background(40);
  translate(width/2, height/2);
  //noStroke();
  stroke(255);
  strokeWeight(0.005);
  //if(random(100) > 80)
      //stroke(random(40,200),random(40, 200), random(180, 255));
  for (int i =0; i<NUM; i++) { 
    
    point(x1(t+i), y1(t+i));
    point(x2(t+i), y2(t+i));
    line(x1(t+i), y1(t+i), x2(t+i), y2(t+i));
  }
  t+=0.1;
}

float x1(float t) {
  return sin(t/10)*350 + sin(t/4)*50;
}

float y1(float t) {
  return cos(t/10)*300 + cos(t/6)*20;
}

float x2(float t) {
  return sin(t)*60;
}

float y2(float t) {
  return sin(t/4)*200;
}