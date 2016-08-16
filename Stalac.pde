
// on the bottom

class Stalac extends Features {

  
  
  Stalac() {
    super();
    startingY = height;
    
  }

  void display() {



   
    for (int i = 0; i < ySteps; i++ ) {
      pushMatrix();
      
      //colorMode(HSB, 100);
      //fill(rainbowIndex/100, 100, 100);
      //rainbowIndex++;
      //if (rainbowIndex > 10000) rainbowIndex = 0;

      //getImageColors(i);

      
      gradientStroke(i);
      drip(i);

      translate(xrand, startingY - i*yspacing, zrand);
      cube(base - radiusDec*i+randWidth[i], yspacing, base - radiusDec*i+randWidth[i]);

      // random width
      //box(base - radiusDec*i+randWidth[i]);
      popMatrix();
    }
  }
  
 
  
  void gradientStroke(int index) {
    fill(255);
    float f = map(index, 0, ySteps, 0, 255);
    stroke(f, 255, 255);
  }
  
  void drip(int index) {
    if (millis() - lastCheck > 20) {
      dripCount--;
      if (dripCount <0) dripCount = ySteps*2;
      lastCheck = millis();
    }
    if (index == dripCount) fill(255);
    else if (index == dripCount + 1) fill(200);
    else if (index == dripCount + 2) fill(150);
    else if (index == dripCount + 3) fill(50);
    else fill(0);
    lastCheck++;
  }
}