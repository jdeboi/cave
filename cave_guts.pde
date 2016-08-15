
import java.util.*;



// tweet
ConfigurationBuilder cb;
Date lastTweet;
long lastChecked = 0;
ArrayList<PImage> savedImages = new ArrayList();
TwitterStream twitterStream;
StatusListener listener;


// stalg
ArrayList<Features> features = new ArrayList();

// grids
Grid [] grids;

// light
int lightStep = 0;
int lightDir = 1;

void setup() {
  size (1200, 600, P3D);
  savedImages.add(loadImage("data/cavreal.jpg"));
  //initTwitter();
  ellipseMode(CENTER);
  //image(savedImages.get(savedImages.size()-1), 0, 0);
  setStalag();

  // grid
  grids = new Grid[6];
  // Grid(int w, int h, float cellSize, int x, int y, int z, float xRot, float yRot, float zRot) {
  grids[0] = new Grid(width*2, height*2, 25, -width/2, height, 0, -90, 10, 0); // left floor
  grids[1] = new Grid(width*2, height, 25, -width/3, 0, 0, 0, 105, 0);         // left wall
  grids[2] = new Grid(width*2, height, 25, width/4, 0, -450, 0, 135, 0);         // center left wall
  grids[3] = new Grid(width*2, height, 25, width/2, 0, 0, 0, 0, 0);         // center right wall
  grids[4] = new Grid(width*2, height, 25, 5*width/4, 0, 0, 0, -85, 0);
  grids[5] = new Grid(width*2, height*2, 25, -width/2, 0, 0, -90, 0, 0);           //ceiling
}

void draw() {
  background(0);
  
  //lights();
  //ambientLight(0, 0, 0);
  lightStep += lightDir*15;
  if (lightStep > width*2) lightDir = -1;
  else if (lightStep < -width) lightDir = 1;
  //pointLight(155, 155, 155, lightStep, height/2, -100);
  spotLight(255, 255, 255, lightStep, height/2, 0, 0, 0, -1, PI/2, 1);
  
  strokeWeight(1);
  stroke(0, 255, 255);
  fill(255);
  drawFeatures();
  drawGrids();

  //fill(255);
  //text(frameRate, 100, height-100);
  
  pushMatrix();
  translate(width/2, height/2, 100);
  rotateY(radians(45));
  
  noFill();
  strokeWeight(3);
  stroke(255, 0, 255);
  cube(width, height, width);
  popMatrix();
}

void setStalag() {
  for (int i = 0; i < 100; i++) {
    fill(255);
    stroke(0, 255, 255);
    features.add(new Stalag());
    features.add(new Stalac());
  }
}

void drawFeatures() {
  for (int i = 0; i < features.size(); i++) {
    features.get(i).display();
  }
}

void drawGrids() {
  for (int i = 0; i < grids.length; i++) {
    grids[i].display();
  }
}

color getPixelColor(int xp, int yp) {
  if (xp >= 0 && xp <= width && yp >= 0 && yp <= height) {
    PImage img = savedImages.get(savedImages.size()-1);
    img.loadPixels();
    //println(xp + " " + yp + " " + img.width + " " + img.height + " " + int(img.width*1.0/width*xp + img.height*1.0/height*yp));
    return img.pixels[xp + yp*img.width];
    //return img.pixels[int(img.width*(w*xp)+ int(yp*cellSize*img.width)];
  }
  println("black " + xp + " " + yp);
  return 0;
}

void cube(int w, int h, int d) {
  beginShape(QUADS);
  // Front face
  vertex(-w/2, -h/2, d/2);
  vertex(w/2, -h/2, d/2);
  vertex(w/2, h/2, d/2);
  vertex(-w/2, h/2, d/2);
  //left
  vertex(-w/2, -h/2, d/2);
  vertex(-w/2, -h/2, -d/2);
  vertex(-w/2, h/2, -d/2);
  vertex(-w/2, h/2, d/2);
  //right
  vertex(w/2, -h/2, d/2);
  vertex(w/2, -h/2, -d/2);
  vertex(w/2, h/2, -d/2);
  vertex(w/2, h/2, d/2);
  //back
  vertex(-w/2, -h/2, -d/2); 
  vertex(w/2, -h/2, -d/2);
  vertex(w/2, h/2, -d/2);
  vertex(-w/2, h/2, -d/2);
  //top
  vertex(-w/2, -h/2, d/2);
  vertex(-w/2, -h/2, -d/2);
  vertex(w/2, -h/2, -d/2);
  vertex(w/2, -h/2, d/2);
  //bottom
  vertex(-w/2, h/2, d/2);
  vertex(-w/2, h/2, -d/2);
  vertex(w/2, h/2, -d/2);
  vertex(w/2, h/2, d/2);
  endShape();
}