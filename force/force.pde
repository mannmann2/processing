SMBH o;
Star[] stars = new Star[200];
Planet[][] planets = new Planet[stars.length][int(random(5, 16))]; 

float g = 9.8;

void setup() {
  
  size(1280,740);
  
   o = new SMBH(100000, width/2, height/2);
   
   for (int i = 0; i < stars.length; i++) {
     float w = random(width);    //width/2+random(-500, 500);
     float h = height/2+random(-175, 175);
     stars[i] = new Star(random(5, 100), w, h);
     
     for (int j = 0; j < planets[i].length; j++) {
       planets[i][j] = new Planet(random(0.1, 1), w+random(-25, 25), h+random(-25, 25)); 
    }
  }
}

void draw() {
  background(40);

  for (int i = 0; i < stars.length; i++) {
    for (int j = 0; j < stars.length; j++) {
      if (i != j) {
        PVector f1 = o.attract(stars[i]);
        PVector f2 = stars[j].attract(stars[i]);
        stars[i].applyForce(f1);
        stars[i].applyForce(f2);
      }
    }
    
    for (int m = 0; m < planets[i].length; m++) {
      for (int n = 0; n < planets[i].length; n++) {
        if (m != n) {
          PVector f3 = stars[i].attract(planets[i][m]);
          //PVector f4 = planets[i][n].attract(planets[i][m]);
          planets[i][m].applyForce(f3);
          //planets[i][m].applyForce(f4);
      }
    }
    planets[i][m].update();
    planets[i][m].display();
    
    }
    stars[i].update();
    stars[i].display();
    o.display();
  }
}