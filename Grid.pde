
public class Grid {

  int imgStep;
  float cellSize;
  float xRot, yRot, zRot;
  float [][] noiseGrid;
  
  int cols, rows, x, y, z;

  Grid(int w, int h, float cellSize) {
    this(w, h, cellSize, 0, 0, 0, 0, 0, 0);
  }

  Grid(int w, int h, float cellSize, int x, int y, int z, float xRot, float yRot, float zRot) {
    this.cols = int(w/cellSize);
    this.rows = int(h/cellSize);
    this.x = x;
    this.y = y;
    this.z = z;
    
    this.cellSize = cellSize;
    this.xRot = xRot;
    this.yRot = yRot;
    this.zRot = zRot;
    noiseGrid = new float [cols][rows];
   
    imgStep = cols*rows-1;
    setNoiseGrid();

    //setWaveGrid();
  }

  public void display() {
    
    
    pushMatrix();
    translate(x, y, z);
    rotateY(radians(yRot));
    rotateX(radians(xRot));
    rotateZ(radians(zRot));
    translate(-x, -y, -z);
    
    for (int i = 0; i < rows-1; i++ ) { 
      beginShape(QUAD_STRIP); 
      for (int j = 0; j < cols-1; j++) {

        // filling grid based on noise
        vertex(x + j * cellSize, y+cellSize*i, noiseGrid[j][i]);
        vertex(x + j * cellSize, y+cellSize*(i+1), noiseGrid[j][i+1]);
        vertex(x + (j+1) * cellSize, y+cellSize*i, noiseGrid[j+1][i]);
        vertex(x + (j+1) * cellSize, y+cellSize*(i+1), noiseGrid[j+1][i+1]);
 
       
       
       //// filling grid sinusoidally
       // vertex(x + j * cellSize, y+cellSize*i, noiseGrid[j][i]);
       // vertex(x + j * cellSize, y+cellSize*(i+1), noiseGrid[j][i+1]);
       // vertex(x + (j+1) * cellSize, y+cellSize*i, noiseGrid[j+1][i]);
       // vertex(x + (j+1) * cellSize, y+cellSize*(i+1), noiseGrid[j+1][i+1]);
       

      }
      endShape();
    }
    popMatrix();
  }

  public void setNoiseGrid() {
    float yoff = .01;
    float xoff = 0;
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        noiseGrid[i][j] = map(noise(xoff, yoff), 0, 1, -30, 30);
        xoff += .2;
      }
      yoff += .2;
    }
  }

  public void setWaveGrid() {
    float yoff = .01;
    float xoff = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        int xspacing = 20;
        float period = 200;
        float period2 = 200;
        float amplitude = 50;
        float amplitude2 = 50;
        float dx = (TWO_PI / period) * xspacing;
        float dx2 = (TWO_PI / period2) * xspacing;
        noiseGrid[j][i] = sin(i*dx)*amplitude + sin(j*dx2)*amplitude2;
        xoff += .2;
      }
      yoff += .2;
    }
  }
}