
class Stalag extends Features {


  Stalag() {
    super();
    startingY = 0;
  }

  void display() {


    //colorMode(HSB, 100);
    for (int i = 0; i < ySteps; i++ ) {
      pushMatrix();
      
      
      //fill(rainbowIndex/100, 100, 100);
      //rainbowIndex++;
      //if (rainbowIndex > 10000) rainbowIndex = 0;

      //getImageColors(i);

      translate(xrand, startingY + i*yspacing, zrand);
      cube(base - radiusDec*i+randWidth[i], yspacing, base - radiusDec*i+randWidth[i]);

      // random width
      //box(base - radiusDec*i+randWidth[i]);
      popMatrix();
    }
  }

  void getImageColors(int i) {
    
    float sX = screenX(xrand, startingY + i*yspacing, zrand);
    float sY = screenY(xrand, startingY + i*yspacing, zrand);

    //if (getPixelColor(int(sX), int(sY)) == 0) println("i and j " + (startingY + i*yspacing + j) + " " + i + " " + j);

    // fill using image
    //fill(getPixelColor(int(sX), int(sY)));
    
  }
}