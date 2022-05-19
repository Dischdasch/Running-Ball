/*
  ID plataformas:
  0: Platform
  1: MovingPlatform
  2: WindPlatform
  3: SlidingPlatform
  4: BreakablePlatform
  5: GoalPlatform
  6: BouncingPlatform
  7: FastPlatform
  11: TeleportPlatform

*/

class Platform {
  PVector position;
  PVector scale;
  PVector rotation;
  PVector size = new PVector();
  
  Platform(float x, float y, float z, float w, float h, float d, float xRotation, float yRotation, float zRotation, PVector _size) {
    position = new PVector(x, y, z);
    scale = new PVector(w, h, d);
    rotation = new PVector(xRotation, yRotation, zRotation);
    size = _size;
  }
  void triggerDown(){
  }
  boolean isDown(){
    return false;
  }
  int getID(){
    return 0;  
  }
  PVector getXYZ(){
    return position;  
  }
  PVector getSize(){
    //scalar
    PVector lSize = new PVector(size.x/2*scale.x,size.y/2*scale.y,size.z/2*scale.z);
    return lSize;  
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
    box(size.x,size.y,size.z);
    popMatrix();
    pushMatrix();
    translate(position.x, position.y, position.z);
    translate(0, -200, 0);

    //text(position.x,10,10);
    popMatrix();
  }
  void update(){
  }
}
