class FastPlatform extends Platform {
  boolean isDown;

  FastPlatform(float x, float y, float z, float xRotation, float yRotation, float zRotation, PVector _size) {
    super(x, y, z, xRotation, yRotation, zRotation, _size);
    isDown = false;
  }
  int getID() {
    return 7;
  }
  void triggerDown() {
    isDown = true;
  }
  @Override
    void display() {
    fill(0, 125, 125);
    pushMatrix();
    translate(position.x, position.y, position.z);
    rotateX(rotation.x);
    rotateY(rotation.y);
    rotateZ(rotation.z);
    // shader(material);
    box(size.x, size.y, size.z);
    popMatrix();
    pushMatrix();
    popMatrix();
    fill(255);
    noStroke();
    fill(0, 255, 0);
  }
  void update() {
  }
}
