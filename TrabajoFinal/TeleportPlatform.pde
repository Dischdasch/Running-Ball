class TeleportPlatform extends Platform {
  boolean isDown;

  TeleportPlatform(float x, float y, float z, float w, float h, float d, float xRotation, float yRotation, float zRotation, PVector _size){
     super(x,y,z,w,h,d,xRotation,yRotation,zRotation,_size);
     isDown = false;
  }
  int getID(){
    return 11;  
  }
  @Override
   void display() {
    fill(155,15,100);
    stroke(200,200,100);
    pushMatrix();
    translate(position.x, position.y, position.z);
    scale(scale.x, scale.y, scale.z);
    rotateX(rotation.x);
    rotateY(rotation.y);
    rotateZ(rotation.z);
    // shader(material);
    box(size.x,size.y,size.z);
    popMatrix();
    noStroke();
    fill(255);
  }
}
