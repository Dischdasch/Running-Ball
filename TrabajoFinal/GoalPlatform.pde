class GoalPlatform extends Platform{
  boolean isDown;
  GoalPlatform(float x, float y, float z, float xRotation, float yRotation, float zRotation, PVector _size){
     super(x,y,z,xRotation,yRotation,zRotation,_size);
     isDown = false;
  }
  int getID(){
    return 5;  
  }
  void triggerDown(){
    isDown = true;
  }
  @Override
   void display() {
    fill(0,0,0);
    noStroke();
    pushMatrix();
    translate(position.x, position.y, position.z);
    rotateX(rotation.x);
    rotateY(rotation.y);
    rotateZ(rotation.z);
    // shader(material);
    box(size.x,size.y,size.z);
    translate(0,-size.y/2-100,0);
    if(isDown){
      pushMatrix();
      translate(100,-350,-400);
      rotateY(radians(-90));
      fill(0);
      textSize(100);
      text("Meta",10,10);
      fill(255);
      popMatrix();
      fill(0,255,0);
    } else{
      fill(255,0,0);
    }
    
    box(10,500,10);
    translate(0,-400,245);
    box(10,400,500);
    popMatrix();
    fill(255);
  }
  void update(){
  }
}
