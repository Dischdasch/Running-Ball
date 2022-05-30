class SlidingPlatform extends Platform{

  SlidingPlatform(float x, float y, float z, float xRotation, float yRotation, float zRotation, PVector _size){
     super(x,y,z,xRotation,yRotation,zRotation,_size);
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
    scale(size.x/200,size.y/200,size.z/200);
    rotateX(PI + rotation.x);
    rotateY(rotation.y);
    rotateZ(rotation.z);
    iceMaterial.setMaterial();
    shape(blockModel);
    resetShader();
    popMatrix();
    pushMatrix();
    popMatrix();
    fill(255);
  }
  @Override
  void update(){
  }
}
