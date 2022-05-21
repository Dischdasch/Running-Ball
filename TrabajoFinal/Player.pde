class Player {
  // Physics
  PVector position, velocity, acceleration;
  float dragIntensity = 1f;
  
  // Geometry
  float radius = 50;
  float diameter = 2*radius;
  
  // Movement
  float movementForce = 2f;
  float maxSpeed = 25;
  float jumpForce = 20f;

  //Platform ID
 
  
  //Plataforma y si esta en el suelo
  int nPlat;
  boolean isFloor = false;
  Player(float x, float y, float z) {
    this.position = new PVector(x, y, z);
    this.velocity = new PVector(0,0,0);
    this.acceleration = new PVector(0,0,0);
  }
  
  void update() {
    PVector drag = velocity.copy();
    drag.y = 0;
    drag.mult(-1);
    drag.setMag(dragIntensity);
    addForce(drag);
    
    PVector horizontalVelocity = velocity.copy();
    horizontalVelocity.y = 0f;
    horizontalVelocity.limit(maxSpeed);
    velocity = new PVector(horizontalVelocity.x, velocity.y, horizontalVelocity.z);
    velocity.add(acceleration);
    position.add(velocity);
    
    acceleration.mult(0);
    collisionDetection();
  }
  
  void updateCollision(ArrayList<Platform> pos){
    int num = 0;
    for(Platform b : pos){
      num++;
      collisionBoxDetection(b,num);  
    }
  }

  void updateCollision(Platform b){
    collisionBoxDetection(b,11);
  }

  void addForce(PVector force) {
    acceleration.add(force.copy());
  }
  
  // Placeholder function for sphere-to-box collision detection with all platforms
  void collisionDetection() {
    /*if (position.y > height - radius - 100) {
      velocity.y = 1f;
    } */
  }
  
  //colision box 2
  void collisionBoxDetection(Platform plat,int num){
    PVector box = plat.getXYZ();
    PVector size = plat.getSize();
    //Colision directa
    if(position.y > box.y - radius*2 - size.y && position.y < box.y - radius*2 + size.y && position.x > box.x-size.x- radius*2 && position.x < box.x+size.x- radius*2 && position.z > box.z-size.z && position.z < box.z+size.z){
      //Deteccion si viene de abajo (usar plataforma de rebote)
      if(position.y > box.y - radius*2 + size.y/2.5 && position.y < box.y - radius*2 + size.y){
        position.y = box.y + radius*2 + size.y;
        //rebote?
        player.addForce(new PVector(0,jumpForce,0));
      } else{
        position.y = box.y - radius*2 - size.y;
      }
      switch(plat.getID()){
        case 1:
          fill(0);
          pushMatrix();
          translate(box.x,box.y-radius*2-size.y,position.z-(position.z-box.z)/4);
          sphere(120);
          position.z -= (position.z-box.z*(box.z/position.z))/30f;
          fill(255);
          popMatrix();
        case 3:
          velocity.x += velocity.x*0.04f;
          velocity.z += velocity.z*0.04f;
        break;
        case 6:
          player.addForce(new PVector(0,-jumpForce*4,0));
        break;
        case 7:
          acceleration.x = velocity.x;
          acceleration.z = velocity.z;
        break;
        case 11:
          if(num == 3){
            position.x = box.x;
            position.y = box.y - size.x;
            position.z = box.z;
          }
        break;
      }
      plat.triggerDown();  
      
      //bouncingplatform
       velocity.y = 0f;
       isFloor = true;
       nPlat = num;
    } else{
      if(num == nPlat){
        isFloor = false;
      }
      
    }
    //Colision indirecta (deteccion por esta por encima de la plataforma
    if(position.y <= box.y - radius - size.y && position.x > box.x-size.x && position.x < box.x+size.x && position.z > box.z-size.z && position.z < box.z+size.z){
      if(plat.getID() == 2){
        if(position.y > box.y-1500){
          velocity.y -= 4f;
        } else{
          velocity.y -= 0.25f;
        }
      } 
    }
    print(nPlat + "\n");
  }
  void control() {
    PVector controlForce = new PVector(0, 0, 0);
    if (keys.get('w')) {
      controlForce.x = 1;
    } else if (keys.get('s')) {
      controlForce.x = -1;
    }
    if (keys.get('a')) {
      controlForce.z = -1;
    } else if (keys.get('d')) {
      controlForce.z = 1;
    }
    controlForce.setMag(movementForce);
    player.addForce(controlForce);
  }
  
  void jump() {
    //no es mio este trabajo
    //if(isFloor){
      player.addForce(new PVector(0,-jumpForce,0));
    //}
    
  }
  
  void display() {
    noStroke();
    pushMatrix();
    translate(position.x, position.y, position.z);
    // shader(material);
    sphere(diameter); // This could be a 3D model
    popMatrix();
    fill(0);
    pushMatrix();
    translate(position.x,position.y);
    textSize(100);
    rotateZ(100);
    //text(position.x, 100,0);
    translate(0,50);
    //text(position.y, 100,0);
    popMatrix();
    fill(255);
  }

}
