class SlidingPlatform extends Platform{

  SlidingPlatform(float x, float y, float z, float w, float h, float d, float xRotation, float yRotation, float zRotation, PVector _size){
     super(x,y,z,w,h,d,xRotation,yRotation,zRotation,_size);
  }
  int getID(){
    return 3;  
  }
  @Override
   void display() {
    fill(200,200,200);
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
    popMatrix();
    fill(255);
  }
  @Override
  void update(){
  }
}