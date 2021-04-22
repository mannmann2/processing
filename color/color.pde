PImage col, img;
void setup()
{
  size(500, 699);
  background(200);
  img = loadImage("col2.jpg");  
}

void draw()
{
  loadPixels();
  
    img.loadPixels();  
    for(int x=0; x<width; x++) {
      for(int y=0; y<height; y++) {
        
        int ind = x + y*width;
        float r = red(img.pixels[ind]);
        float g = green(img.pixels[ind]);
        float b = blue(img.pixels[ind]);
        float d = dist(mouseX, mouseY, width/2, height/2);
        float fac = map(d, 0, 300, 0, 10);
        //float a=map(mouseX, 0, width, 0, 255);
        float bb=map(mouseY, 0, height, 0, 255);
        pixels[ind] = color(r+d, g, b);
        
      }
    }
    updatePixels();
}