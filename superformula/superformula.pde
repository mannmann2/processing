float x3, y3, x1, x2, y1, y2, t, r, g, b;
static int NUM = 10;

void setup() {
  size(700, 700);
  
  
  //x1 = -width/4;
  //x2 = width/4;
  //y1 = -height/4;
  //y2 = height/4;
  background(106);
  r=g=b=255;
}

void draw() {
  delay(20);
  translate(width/2, height/2);
  //fill(140, 10, 220);
  fill(r, g, b) ;
  stroke(255-r, 255-g, 255-b);
  strokeWeight(2);
  delay(20);
  if (random(100) >95) {
    background(r,g,b);
    r = red();
    g = green();
    b = blue();
  }
  //background(106);
  //noStroke();
  beginShape();
  for(float theta = 0; theta < 2*PI; theta += 0.01) {
    float rad = r(theta, 
    3, //a
    3, //b
    mouseX/20 , //m
    1, //n1
    sin(t)+0.3, //n2
    cos(t)+0.3); //n3
    
    float x = rad*cos(theta) * 50;
    float y = rad*sin(theta) * 50;
    vertex(x, y);  
  }
  endShape();
  t+=0.1;

  /*point(x1+x3, y1-NUM*10 );
  point(x2-x3, y2+NUM*10);
  if(x3<width/2)
    x3+=3;
  point(x1-NUM*10, y2-y3);
  point(x2+NUM*10, y1+y3);
  if(y3<height/2)
    y3+=2;
  */
}
  
float r(float theta, float a, float b, float m, float n1, float n2, float n3) {
  return pow(pow(abs(cos(m*theta/4.0) / a), n2) +
             pow(abs(sin(m*theta/4.0) / b), n3), -1/n1);
}

float red() {
  return random(255);
}

float green() {
  return random(255);
}

float blue() {
  return random(255);
}