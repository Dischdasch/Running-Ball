class MovingPlatform extends Platform{
  int mov = 0;
  int acc = 10;
  MovingPlatform(float x, float y, float z, float w, float h, float d, float xRotation, float yRotation, float zRotation, PVector _size){
     super(x,y,z,w,h,d,xRotation,yRotation,zRotation,_size);
  }
  int getID(){
    return 1;  
  }
  @Override
   void display() {
    fill(255,0,100);
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
  void update(){
    mov += acc;
    position.z+= acc;
    if(mov > 200 || mov < 0){
        acc *= -1;
    }
  }
}
