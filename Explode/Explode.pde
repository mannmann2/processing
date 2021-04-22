
PImage img;       // The source image
int cellsize = 4; // Dimensions of each cell in the grid
int columns, rows;   // Number of columns and rows in our system

void setup() {
  size(1240, 660, P3D); 
  img = loadImage("up.jpg");  // Load the image
  columns = img.width / cellsize;  // Calculate # of columns
  rows = img.height / cellsize;  // Calculate # of rows
}

void draw() {
  background(0);
  // Begin loop for columns
  for ( int i = 0; i < columns; i++) {
    // Begin loop for rows
    for ( int j = 0; j < rows; j++) {
      int x = i*cellsize + cellsize/2;  
      int y = j*cellsize + cellsize/2; 
      
      int loc = x + y*img.width;  //  array location of pixels
      color c = img.pixels[loc];  // Grab the color
      // Calculate a z position as a function of mouseX and pixel brightness
      float z = (mouseX / float(width)) * brightness(img.pixels[loc]);
      // Translate to the location, set fill and stroke, and draw the rect
      pushMatrix();
      translate(x + 200, y + 100, 4*z);
      fill(c, 204);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, cellsize, cellsize);
      popMatrix();
    }
  }
}