class Collectable {
  PVector position;
  
  float radius;
  float diameter;
  float angle;
  boolean destroyed = false;
  SoundFile sound;
  PShape model;
  Material material;
  
  Collectable(PVector position, float radius, Material material) {
    this.position = position.copy();
    this.radius = radius;
    this.diameter = 2*radius;
    this.sound = collectableSound;
    this.model = coinModel;
    this.material = material;
  }
  
  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    rotateY(angle);
    scale(radius);
    material.setMaterial();
    shape(model);
    popMatrix();
    resetShader();
    angle += 0.1;
  }
  
  boolean collidesWith(Player player) {
    if (PVector.dist(player.position, this.position) < this.radius*2.0 + player.radius) {
      collect();
      return true;
    }
    return false;
  }
  
  void collect() {
    collectableCount++;
    sound.play();
  }
}
