/*
  Platform ID:
  0: Platform
  1: MovingPlatform
  2: WindPlatform
  3: SlidingPlatform
  4: BreakablePlatform
  5: GoalPlatform
  6: BouncingPlatform
  7: FastPlatform
  11: TeleportPlatform (not used)

*/

class Platform {
  PVector position;
  PVector rotation;
  PVector size = new PVector();
  
  Platform(float x, float y, float z, float xRotation, float yRotation, float zRotation, PVector _size) {
    position = new PVector(x, y, z);
    rotation = new PVector(xRotation, yRotation, zRotation);
    size = _size;
  }
  void triggerDown(){
  }
  boolean isDown(){
    return false;
  }
  int getID(){
    return 0;  
  }
  PVector getXYZ(){
    return position;  
  }
  PVector getSize(){
    //scalar
    PVector lSize = new PVector(size.x/2,size.y/2,size.z/2);
    return lSize;  
  }
  
  //Platform trigger
  void getEffect(Player p){
    PVector box = this.getXYZ();
    PVector size = this.getSize();
     switch(this.getID()) {
        case 1:
          fill(0);
          pushMatrix();
          translate(box.x, box.y-p.radius*2-size.y, position.z-(position.z-box.z)/4);
          sphere(120);
          position.z -= (position.z-box.z*(box.z/position.z))/30f;
          fill(255);
          popMatrix();
        case 3:
          p.velocity.x += p.velocity.x*0.04f;
          p.velocity.z += p.velocity.z*0.04f;
          break;
        case 6:
          player.addForce(new PVector(0, -p.jumpForce*3, 0));
          break;
        case 7:
          p.acceleration.x = p.velocity.x;
          p.acceleration.z = p.velocity.z;
          break;
      }
  }
  void display() {
    noStroke();
    pushMatrix();
    translate(position.x, position.y, position.z);
    
    /*Platform scale required (PShape , divide beetween platform size and PShape size*/
    
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
    //translate(0, -200, 0);

    //text(position.x,10,10);
    popMatrix();
  }
  void update(){
  }
}
