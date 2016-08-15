
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

      translate(xrand, startingY - i*yspacing, zrand);
      cube(base - radiusDec*i+randWidth[i], yspacing, base - radiusDec*i+randWidth[i]);

      // random width
      //box(base - radiusDec*i+randWidth[i]);
      popMatrix();
    }
  }
}