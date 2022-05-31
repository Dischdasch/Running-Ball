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
  boolean isDown(){
    return isDown;    
  }
  @Override
   void display() {
    fill(0,0,0);
    noStroke();
    pushMatrix();
    translate(position.x, position.y, position.z);
    scale(size.x/200,size.y/200,size.z/200);
    rotateX(PI + rotation.x);
    rotateY(rotation.y);
    rotateZ(rotation.z);
    platformMaterial.setMaterial();
    shape(blockModel);
    resetShader();
    popMatrix();
    
    pushMatrix();
    translate(position.x, position.y, position.z);
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
    scale(size.y/2,size.y/3,size.z/6);
    
    rotateX(PI);
    translate(0, -1, 0);
    flagMaterial.material.set("u_time", millis()/100f);
    flagMaterial.material.set("windScale", 0.1);
    flagMaterial.material.set("windStrength", 0.1);
    flagMaterial.setMaterial();
    shape(flagModel);
    popMatrix();
    fill(255);
  }
  void update(){
  }
}
