class WindPlatform extends Platform{

  WindPlatform(float x, float y, float z, float xRotation, float yRotation, float zRotation, PVector _size){
     super(x,y,z,xRotation,yRotation,zRotation,_size);
  }
  int getID(){
    return 2;  
  }
  @Override
   void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    scale(size.x/2,size.y/2,size.z/2);
    rotateX(rotation.x);
    rotateY(rotation.y);
    rotateZ(rotation.z);
    metalMaterial.setMaterial();
    shape(windPlatformModel);
    resetShader();
    popMatrix();
    pushMatrix();
    popMatrix();
  }
  @Override
  void update(){
    rotation.y += 0.2;
  }
}
