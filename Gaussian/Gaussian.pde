import java.util.Random;
Random gen;

void setup() {
size(800, 600);
gen = new Random();

}

void draw(){
 background(150);
 noStroke();
 float h = (float)gen.nextGaussian();
 h = (h*mouseX)+mouseY;
 fill(random(256), random(50), random(256), 180);
 ellipse(400, 300, h, h);
 delay(50);
 
}