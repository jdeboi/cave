
public class Grid {

  int imgStep, gridMode, animateIndex;
  float cellSize;
  float xRot, yRot, zRot;
  float [][] noiseGrid;
  ColorPixel [][] colorGrid;

  int cols, rows, x, y, z;

  Grid(int w, int h, float cellSize) {
    this(w, h, cellSize, 0, 0, 0, 0, 0, 0, 0);
  }

  Grid(int w, int h, float cellSize, int x, int y, int z, float xRot, float yRot, float zRot, int gridMode) {
    this.cols = int(w/cellSize);
    this.rows = int(h/cellSize);
    this.x = x;
    this.y = y;
    this.z = z;
    this.gridMode = gridMode;

    this.cellSize = cellSize;
    this.xRot = xRot;
    this.yRot = yRot;
    this.zRot = zRot;
    noiseGrid = new float [cols][rows];
    colorGrid = new ColorPixel [cols][rows];
    animateIndex = -1;

    imgStep = cols*rows-1;
    setNoiseGrid();
    setColorGrid();

    //setWaveGrid();
  }

  public void display() {


    pushMatrix();
    translate(x, y, z);
    rotateY(radians(yRot));
    rotateX(radians(xRot));
    rotateZ(radians(zRot));
    //translate(-x, -y, -z);
    //translate(x, y, z);

    for (int i = 0; i < rows-1; i++ ) { 
      beginShape(QUAD_STRIP); 
      PImage img =savedImages.get(0);
      texture(img);
      for (int j = 0; j < cols-1; j++) {
        //noStroke();
        //fill(0, 255, 255);
        // filling grid based on noise

        float f = map(i, 0, rows-1, 0, 255);
        stroke(0, f, 225);

        if (gridMode == 1) {
          //float b = 2*PI/cols;
          float b = 1;
          float a = 200;
          float xt = map(j, 0, cols-1, 0, 2*PI);
          //fill(colorGrid[j][i].getColor());
          //stroke(colorGrid[j][i].getStroke());
          vertex(j * cellSize, cellSize*i, noiseGrid[j][i]+a*cos(b*xt),  j*(img.width*1.0/cols),i*(img.height*1.0/rows));
          vertex(j * cellSize, cellSize*(i+1), noiseGrid[j][i+1]+a*cos(b*xt),j*(img.width*1.0/cols),(i+1)*(img.height*1.0/rows));
        } else {
          if (gridMode == 2) stroke(0, 255, 225);

          vertex(j * cellSize, cellSize*i, noiseGrid[j][i], j*(img.width*1.0/cols),i*(img.height*1.0/rows));
          vertex(j * cellSize, cellSize*(i+1), noiseGrid[j][i+1],j*(img.width*1.0/cols),(i+1)*(img.height*1.0/rows));
        }
      }
      endShape();
    }
    popMatrix();
    //rainImage();
  }

  public void rainImage() {
    // fall in color order and stick when hitting spot
    if (animateIndex == -1) {
      resetGrid();
    } else if (animateIndex == 0) {
      for ( int i = 0; i < cols; i++) {
        colorGrid[i][0].randomColor();
      }
    } else {
      for ( int i = 0; i < cols; i++) {
        for (int j = rows-1; j > 0; j--) {
          if (animateIndex > 1 && animateIndex%2 == 0) {
            int xp = imgStep%cols;
            int yp = imgStep/cols;

            colorGrid[xp][0].updateColor(getVertexColor(xp, yp, cols, rows));
            imgStep--;
            if (imgStep < 0) imgStep = cols*rows-1;
          } else {
            colorGrid[i][0].randomColor();
          }
          colorGrid[i][j].updateColor(colorGrid[i][j - 1].getColorSwap());
          colorGrid[i][j].checkUpdate(i, j, cols, rows);
        }
      }
    }
    animateIndex++;
    if (animateIndex > 200) animateIndex = -1;
  }


  public void setImage() {
    PImage img = savedImages.get(savedImages.size()-1);
    img.loadPixels();
    for (int i = 0; i < img.pixels.length; i++) {
      //img.pixels
    }
  }

  public void resetGrid() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        colorGrid[i][j].reset();
      }
    }
  }

  public void setColorGrid() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        colorGrid[j][i] = new ColorPixel();
      }
    }
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