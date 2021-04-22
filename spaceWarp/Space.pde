class Space {

  color col;
  float weight;
  float[][] ter;

  Space(color c, float w) {
    col = c;
    weight = w;
    ter = new float[cols][rows];
  }

  float update(Mover m, float x, float y) {
    float D = dist(x*s, y*s, 0, m.position.x*w/width, m.position.y*h/height, 10);
    //float D = dist(x*s, y*s, m.velocity.x*w/width, m.velocity.y*h/height);
    //return constrain(-(G*m.mass)/(pow(D, 2)), -140, 0);
    return -(G*m.mass)/(pow(D, 2));
  }

  void display(float[][] ter) {
    stroke(col);
    strokeWeight(weight);
    fill(0, 255);
    for (int y = 0; y < rows-1; y++) {
      //beginShape(TRIANGLE_STRIP);
      beginShape(QUAD_STRIP);
      for (int x = 0; x < cols; x++) {
        //int xx=x-w/2;
        //int yy=y-h/2;
        vertex(x*s, y*s, ter[x][y]);
        vertex(x*s, (y+1)*s, ter[x][y+1]);
      }
      endShape();
    }
  }
}