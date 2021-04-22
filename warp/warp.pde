boolean pause = false;
boolean rec = false;
Star[] s = new Star[800];
float speed = 0.4;
float inc = 0.1;

void setup() {
  size(1200, 700);
  background(0);
  for (int i = 0; i< s.length; i++) {
    s[i] = new Star();
  }
}

void draw() {
  if (!pause) {
    background(0);
    translate(width/2, height/2);
    //speed = map(mouseX, 0, width, 1, 60);
    if (speed > 65) {
      speed = 10;
      inc = -inc*2;
    }
    speed += inc;
    if (speed < 0.4)
      inc = 0;
      
    println (speed);

    for (int i = 0; i< s.length; i++) {
      s[i].update();
      s[i].show();
    }
  }

  if (rec)
    saveFrame("output/warp_####.jpg");

  //println(frameRate);
}

void keyPressed() {
  if (key =='p')
    pause = !pause;

  if (key=='r')
    rec = !rec;
}