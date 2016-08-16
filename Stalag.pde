
class Stalag extends Features {


  Stalag() {
    super();
    startingY = 0;
  }

  void display() {


    //colorMode(HSB, 100);
    for (int i = 0; i < ySteps; i++ ) {
      pushMatrix();
      
      float f = map(i, 0, ySteps, 0, 255);
      stroke(f, 155, 255);
      
      //fill(rainbowIndex/100, 100, 100);
      //rainbowIndex++;
      //if (rainbowIndex > 10000) rainbowIndex = 0;

      //getImageColors(i);
      drip(i);
      
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
  
   void drip(int index) {
    if (millis() - lastCheck > 20) {
      dripCount++;
      if (dripCount > ySteps*2) dripCount = 0;
      lastCheck = millis();
    }
    if (index == dripCount) fill(255);
    else if (index == dripCount - 1) fill(200);
    else if (index == dripCount - 2) fill(150);
    else if (index == dripCount - 3) fill(50);
    else fill(0);
    lastCheck++;
  }
}