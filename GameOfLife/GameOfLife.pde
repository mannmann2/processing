int cellSize = 4;
float probAlive = 20;
float probMut= 1;
float probVirus = 3;
int interval = 100;
int lastRecordedTime = 0;
int gen = 1;

color alive = color(20, 180, 100);
color dead = color(0);
color mut = color(50, 30, 250);
color virus = color(200, 50, 0);

int[][] cells; 
int[][] cellsBuffer; 

boolean pause = false;

void setup() {
  size (1200, 680);

  // Instantiate arrays 
  cells = new int[width/cellSize][height/cellSize];
  cellsBuffer = new int[width/cellSize][height/cellSize];
  
  //stroke(10, 40);
  noStroke();
  noSmooth();
  //frameRate(20);

  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      float state = random (100);
      if (state <= probMut) { 
        state = 2;
      }
      else if (state <= probVirus) {
        state = 3;
      }
      else if (state <= probAlive) {
        state = 1;
      }
      else state = 0;
      
      cells[x][y] = int(state);
    }
  }
  background(0);
}

void draw() {

  //Draw grid
  int al = 0;
  int m = 0;
  int v = 0;
  int d = 0;
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      if (cells[x][y]==1) {
        fill(alive); // If alive
        al++;
      }
      else if(cells[x][y]==2) {
        fill(mut);
        m++;
      }
      else if (cells[x][y]==3) {
        fill(virus);
        v++;
      }
      else {
        fill(dead);
        d++; 
     }
      
      rect (x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
  
  fill(255);
  textSize(14);
  text("Generation: " + gen + "\nAlive: " + (al+m) + "\n-Normal: " + al +
       "\n-Mutations: " + m + "\nVirus: " + v + "\nDead: " + d, 10, 30);
  
  if (millis()-lastRecordedTime>interval) {
    if (!pause) {
      gen++;
      iteration();
      lastRecordedTime = millis();
    }
  }

  if (pause && mousePressed) {

    int xCellOver = int(map(mouseX, 0, width, 0, width/cellSize));
    xCellOver = constrain(xCellOver, 0, width/cellSize-1);
    int yCellOver = int(map(mouseY, 0, height, 0, height/cellSize));
    yCellOver = constrain(yCellOver, 0, height/cellSize-1);

    if (key == 'm' || key == 'M') {
      cells[xCellOver][yCellOver] = 2;
      fill(mut);
    }
    else if (key == 'v' || key == 'V') {
      cells[xCellOver][yCellOver] = 3;
      fill(virus);
    }
    else if (cellsBuffer[xCellOver][yCellOver] > 0) {
      cells[xCellOver][yCellOver] = 0;
      fill(dead);
    }
    else {
      cells[xCellOver][yCellOver] = 1;
      fill(alive);
    }
  } 
  else if (pause && !mousePressed) { 
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        cellsBuffer[x][y] = cells[x][y];
      }
    }
  }
}


void iteration() { 
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      cellsBuffer[x][y] = cells[x][y];
    }
  }

  // Visit each cell:
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {

      int nA = 0;
      int nV = 0;
      int nM = 0;
      for (int xx=x-1; xx<=x+1;xx++) {
        for (int yy=y-1; yy<=y+1;yy++) {  
          
          if (((xx>=0)&&(xx<width/cellSize))&&((yy>=0)&&(yy<height/cellSize))) { 
            if (!((xx==x)&&(yy==y))) {
              
              if (cellsBuffer[xx][yy]==1)
                nA ++;
              else if (cellsBuffer[xx][yy]==2)
                nM++;
              else if (cellsBuffer[xx][yy]==3)
                nV++;
                
            }
          }
        }
      }
      
      int neighbours = nA + nV + nM;
      float p;
      
      
      if (cellsBuffer[x][y] == 1) {       //normal
        if ((neighbours > 1 && neighbours < 5) || neighbours == 6)
        {
          if(nV > 1)
            cells[x][y] = 3;
        }
        else cells[x][y] = 0;
      }
      
      
      else if (cellsBuffer[x][y] == 2) {       //mutations
        if (neighbours < 3 || neighbours > 4)
          cells[x][y] = 0;
        else if (nV == 4)
          cells[x][y] = 3;
      }
      
      
      else if (cellsBuffer[x][y] == 3) {   // virus
        if ((nV < 3) || (neighbours > 4))
          cells[x][y] = 0;
         else if (nM > 1)
          cells[x][y] = 2;
      }
      
      
      else {                    //dead
      
        if (neighbours > 4) {
          p=random(100);
          if (p < 0.5)
            cells[x][y] = 2;
          else if(neighbours == 6 && nA > 4)
            cells[x][y] = 1; 
          else if(nV > 1)
            cells[x][y] = 3;
        }
        
        if (neighbours == 4) {
          if ((nV == 4) || (nV == 2 && nA == 2))
            cells[x][y] = 3;
           else if(nM > 1)
             cells[x][y] = 2;
        }
        
        else if (neighbours == 3) {
          if (nM == 3)
            cells[x][y] = 2;
          else if(nA + nM == 3 && nM < 2)
            cells[x][y] = 1;
          else if (nV == 1 && nA == 2)
            cells[x][y] = 3;
        }
        
        
        else if (neighbours == 2) {
          if(nM == 1 && nV == 1) {
            p=random(100);
            if (p<50)
              cells[x][y] = 2; 
            else
              cells[x][y] = 3;
             //else cells[x][y] = 1;
          }
        }
        
      } // End of if
    } // End of y loop
  } // End of x loop
} // End of function

void keyPressed() {
  if (key=='r' || key == 'R') {
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        float state = random (100);
        if (state > probAlive) {
          state = 0;
        }
        else {
          state = 1;
        }
        cells[x][y] = int(state);
      }
    }
  }
  if (key==' ') {
    pause = !pause;
  }
  if (key=='c' || key == 'C') {
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        cells[x][y] = 0;
      }
    }
  }
}