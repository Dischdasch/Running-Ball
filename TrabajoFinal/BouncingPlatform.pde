class BouncingPlatform extends Platform{
  boolean isDown;

  BouncingPlatform(float x, float y, float z, float xRotation, float yRotation, float zRotation, PVector _size){
     super(x,y,z,xRotation,yRotation,zRotation,_size);
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
    scale(size.x/200,size.y/200,size.z/200);
    rotateX(rotation.x);
    rotateY(rotation.y);
    rotateZ(rotation.z);
    // shader(material);
    box(200);
    popMatrix();
    pushMatrix();
    popMatrix();
    fill(255);
    noStroke();
  }
  void update(){
  }
}
