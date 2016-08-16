class ColorPixel {

  color colorFix;
  color colorSwap;
  boolean isMoving;

  ColorPixel(){
    colorFix = 0;
    colorSwap = 0;
    isMoving = true;
  }

  void updateColor(color c) {
    if(isMoving) {
      colorFix = c;
      colorSwap = c;
    }
    else colorSwap = c;
  }

  color getColorSwap() {
    return colorSwap;
  }

  color getStroke() {
    if (!isMoving) return 0; //color(255,255,255);
    else return color(0,255,255);
  }

  void checkUpdate(int x, int y, int w, int h) {
    if (colorSwap == getVertexColor(x, y, w, h)) {
      isMoving = false;
    }
  }

  color getColor() {
    return colorFix;
  }


  void randomColor() {
    colorFix = color(random(0,255), random(0,255), random(0,255), random(0,255));
    colorSwap = colorFix;
  }

  void reset() {
    colorFix = 0;
    colorSwap = 0;
    isMoving = true;
  }
}