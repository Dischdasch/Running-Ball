class MovingPlatform extends Platform{
  int mov = 0;
  int acc = 10;
  MovingPlatform(float x, float y, float z, float xRotation, float yRotation, float zRotation, PVector _size){
     super(x,y,z,xRotation,yRotation,zRotation,_size);
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
  }
  void update(){
    mov += acc;
    position.z+= acc;
    if(mov > 2000 || mov < -2000){
        acc *= -1;
    }
  }
}
