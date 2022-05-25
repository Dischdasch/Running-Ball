class Camera {
  PVector target;
  PVector position;
  float angle = 0;
  float distance = 0;
  
  Camera(PVector target, float distance, float minDistance, float maxDistance) {
    this.target = target;
    this.distance = distance;
  }
  
  void update() {
    if (mousePressed) angle += (mouseX - pmouseX)*0.01;
    position = new PVector(target.x - distance*cos(angle), target.y - 200 , target.z - distance*-sin(angle));
    camera(position.x, position.y, position.z, target.x, target.y, target.z, 0, 1, 0);
  }

}
