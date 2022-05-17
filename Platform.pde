class Platform {
  PVector position;
  PVector scale;
  PVector rotation;
  float size = 100;
  
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
    // shader(material);
    box(size);
    popMatrix();
    pushMatrix();
    translate(position.x, position.y, position.z);
    translate(0, -200, 0);

    //text(position.x,10,10);
    popMatrix();
  }
}
