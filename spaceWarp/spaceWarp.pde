boolean rec = false;
int cols, rows;
int s = 10;
int w = 1600;
int h = 1600;

//int w = 1600;
//int h = 1200;

float G = 9.8;
float[][] ter, temp;

Space sp;
Attractor a;
Mover[] movers = new Mover[4];

void setup() {
  size(1000, 600, P3D);
  cols = w/s;
  rows = h/s;

  sp = new Space(color (255, 40), 1);
  a = new Attractor(50);
  for (int i = 0; i < movers.length; i++)
    movers[i] = new Mover(random(10, 20));

  ter = new float[cols][rows];
}

void draw() {
  colorMode(RGB);
  background(40, 5, 50);
  lights();

  //a.drag();
  //a.hover(mouseX, mouseY);
  //a.position.x = mouseX;
  //a.position.y = mouseY;

  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      float D = dist(x*s, y*s, 0, a.position.x*w/width, a.position.y*h/height, 50); //add Z here
      ter[x][y] = -(G*a.mass)/(pow(D, 2));
      //ter[x][y] = constrain(-(G*a.mass)/(pow(D, 2)), -240, 0);
    }
  }

  for (Mover m : movers) {
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        ter[x][y] += sp.update(m, x, y);
      }
    }
  }

  translate(width/2, height/2);
  rotateX(PI/4);
  translate(-w/2, -h/2);
  
  sp.display(ter);
  a.display();
  
  for (int i = 0; i < movers.length; i++) {
    PVector force = a.attract(movers[i]);
    movers[i].applyForce(force);
    movers[i].update();
    movers[i].orbit();
    movers[i].display();
  }

  if (rec)
    saveFrame("output/spaceWarp_####.jpg");
}

void keyPressed() {
  if (key == 'r')
    rec = !rec;
}

//  void mousePressed() {
//    a.clicked(mouseX, mouseY);
//  }

//  void mouseReleased() {
//    a.stopDragging();
//  }