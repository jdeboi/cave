
public abstract class Features {
  
  int xrand, base, stalH, yspacing, ySteps, radiusDec, startingY, zrand;
  int [] randWidth;
  int rainbowIndex;
  
  Features() {
    rainbowIndex = 0;
    
    zrand = int(random(-1200, 0));
    if (int(random(0, 2)) == 0 ) xrand = int(random (-width/2, width/3));
    else xrand = int(random (2*width/3, width+width/2));
    base = int(random(10, 80));
    radiusDec = int(random(3, 8));

    yspacing = int(random(10, 20));

    ySteps = base / radiusDec;
    stalH = yspacing * ySteps;

    
    
    randWidth = new int[ySteps];
    for (int i = 0; i < randWidth.length; i++) {
      randWidth[i] = int(random(-5, 5));
    }
  }
  
  abstract void display();
  
}