class WindPlatform extends Platform{

  WindPlatform(float x, float y, float z, float w, float h, float d, float xRotation, float yRotation, float zRotation, PVector _size){
     super(x,y,z,w,h,d,xRotation,yRotation,zRotation,_size);
  }
  int getID(){
    return 2;  
  }
  @Override
   void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    scale(50*scale.x, 50*scale.y, 50*scale.z);
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
    rotation.y += 1;
  }
}
