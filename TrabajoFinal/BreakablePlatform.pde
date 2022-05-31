class BreakablePlatform extends Platform {
  boolean isDown;
  boolean destroyed;
  PVector posInicial = new PVector(position.x, position.y, position.z);
  int time;
  PVector green = new PVector(0f, 1f, 0f);
  PVector yellow = new PVector(1f, 1f, 0f);
  PVector red = new PVector(1f, 0f, 0f);
  PVector col;

  BreakablePlatform(float x, float y, float z, float xRotation, float yRotation, float zRotation, PVector _size) {
    super(x, y, z, xRotation, yRotation, zRotation, _size);
    isDown = false;
    destroyed = false;
    time = 150;
    col = green;
  }
  int getID() {
    return 4;
  }
  boolean isDown() {
    return isDown;
  }
  void triggerDown() {
    isDown = true;
  }
  @Override
    void display() {
    stroke(200);

    pushMatrix();
    translate(position.x, position.y, position.z);
    scale(size.x/200, size.y/200, size.z/200);
    rotateX(rotation.x);
    rotateY(rotation.y);
    rotateZ(rotation.z);
    breakableMaterial.setMaterial(col);
    box(200);
    resetShader();
    if (destroyed) {
      position.x = 0;
      position.z = 0;
      position.y = -100000;
    }
    popMatrix();
    pushMatrix();
    popMatrix();
    fill(255);
    noStroke();
  }
  void update() {
    if (isDown && !destroyed) {
      time--;
    }
    if (destroyed) {
      time++;
    }
    switch (time) {
    case 150:
      if (destroyed) {
        destroyed = false;
        isDown = false;
        position.x = posInicial.x;
        position.y = posInicial.y;
        position.z = posInicial.z;
      }
      col = green;
      break;
    case 100:
      col = yellow;
      break;
    case 50:
      col = red;
      break;
    case 0:
      destroyed = true;
      break;
    }
  }
}
