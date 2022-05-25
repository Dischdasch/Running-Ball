class BreakablePlatform extends Platform{
  boolean isDown;
  boolean destroyed;
  PVector posInicial = new PVector(position.x,position.y,position.z);
  int time;
  color cl;
  BreakablePlatform(float x, float y, float z, float w, float h, float d, float xRotation, float yRotation, float zRotation, PVector _size){
     super(x,y,z,w,h,d,xRotation,yRotation,zRotation,_size);
     isDown = false;
     destroyed = false;
     time = 150;
  }
  int getID(){
    return 4;  
  }
  boolean isDown(){
    return isDown;    
  }
  void triggerDown(){
    isDown = true;
  }
  @Override
   void display() {
    fill(cl);
    stroke(200);
    
    pushMatrix();
    translate(position.x, position.y, position.z);
    scale(scale.x, scale.y, scale.z);
    rotateX(rotation.x);
    rotateY(rotation.y);
    rotateZ(rotation.z);
    // shader(material);
    box(size.x,size.y,size.z);
    if(destroyed){
      position.x = 0;
      position.z = 0;
      position.y = -10000;
    }
    popMatrix();
    pushMatrix();
    popMatrix();
    fill(255);
    noStroke();
  }
  void update(){
    if (isDown && !destroyed){
      time--;
    }
    if (destroyed){
      time++;
      
    }
    switch (time){
      case 150:
       if(destroyed){
         destroyed = false;
         isDown = false;
         position.x = posInicial.x;
         position.y = posInicial.y;
         position.z = posInicial.z;
       }
       cl = color(0,255,0);
       break;
      case 100:
       cl = color(255,255,0);
       break;
      case 50:
       cl = color(255,0,0);
       break;
      case 0:
       destroyed = true;
       break;
    }
  }
}
