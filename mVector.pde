class mVector extends PVector {
  
  boolean curved;
  
  mVector(float x, float y, float z) {
    this(x, y, z, false);
  }
  
  mVector(float x, float y, float z, boolean curved) {
    super(x, y, z);
    this.curved = curved;
  }

}