class Player {
  PVector position, velocity, acceleration;
  
  Player(float x, float y, float z) {
    this.position = new PVector(x, y, z);
    this.velocity = new PVector(0,0,0);
    this.acceleration = new PVector(0,0,0);
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    
    acceleration.mult(0);
  }
  
  void addForce(PVector force) {
    acceleration.add(force.copy());
  }
  
  void display() {
    noStroke();
    pushMatrix();
    translate(position.x, position.y, position.z);
    sphere(100);
    popMatrix();
  }

}
