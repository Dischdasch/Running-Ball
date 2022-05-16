class Camera {
  PVector target;
  PVector position;
  float angle = 0;
  float distance = 0;
  
  // No PeasyCam
  Camera(PVector target, float distance, float minDistance, float maxDistance) {
    this.target = target;
    this.distance = distance;
  }
  
  void update() {
    position = new PVector(target.x - distance*cos(0), target.y - distance*sin(0), target.z);
    camera(position.x, position.y, position.z, target.x, target.y, target.z, 0, 1, 0);
  }

}
