class Platform {
  PVector position;
  PVector scale;
  PVector rotation;
  
  Platform(float x, float y, float z, float w, float h, float d, float xRotation, float yRotation, float zRotation) {
    position = new PVector(x, y, z);
    scale = new PVector(w, h, d);
    rotation = new PVector(xRotation, yRotation, zRotation);
  }
  
  void display() {
    noStroke();
    pushMatrix();
    translate(position.x, position.y, position.z);
    scale(scale.x, scale.y, scale.z);
    rotateX(rotation.x);
    rotateY(rotation.y);
    rotateZ(rotation.z);
    box(100);
    popMatrix();
  }
}
