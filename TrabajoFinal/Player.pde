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
  
  void updateCollision(ArrayList<PVector> pos){
    int num = 0;
    for(PVector b : pos){
      num++;
      collisionBoxDetection(b,num);  
    }
    
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
  void collisionBoxDetection(PVector box,int num){
    if(position.y > box.y - radius - 100 && position.y < box.y - radius + 100 && position.x > box.x-500 && position.x < box.x+500 && position.z > box.z-500 && position.z < box.z+500){
      if(position.y > box.y - radius + 50 && position.y < box.y - radius + 100){
        position.y = box.y + radius + 100;
        //rebote?
        player.addForce(new PVector(0,jumpForce,0));
      } else{
        position.y = box.y - radius - 100;
      }
      
      if(num == 3){
        player.addForce(new PVector(0,-jumpForce*4,0));
      }
      else if(num == 7){
        velocity.y = 0f;
        pushMatrix();
        
        translate(box.x+100,box.y-350,box.z-200);
        rotateY(radians(-90));
        fill(0);
        textSize(100);
        text("Meta",10,10);
        fill(255);
        popMatrix();
      }
      else{
        velocity.y = 0f;
      }
    } 
    
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
    player.addForce(new PVector(0,-jumpForce,0));
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
