class BouncingPlatform extends Platform{
  boolean isDown;

  BouncingPlatform(float x, float y, float z, float w, float h, float d, float xRotation, float yRotation, float zRotation, PVector _size){
     super(x,y,z,w,h,d,xRotation,yRotation,zRotation,_size);
     isDown = false;
  }
  int getID(){
    return 6;  
  }
  void triggerDown(){
    isDown = true;
  }
  @Override
   void display() {
    fill(0,10,10);
    stroke(200);
    
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
    popMatrix();
    fill(255);
    noStroke();
  }
  void update(){
  }
}