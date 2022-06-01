class Camera {
  PVector target;
  PVector position;
  float angle = 0;
  float distance, minDistance, maxDistance;
  float zoomSensitivity = 100f;
  float mouseSensitivity = 0.01;
  
  Camera(PVector target, float distance, float minDistance, float maxDistance) {
    this.target = target;
    this.distance = distance;
    this.minDistance = minDistance;
    this.maxDistance = maxDistance;
  }
  
  void update() {
    if (mousePressed) angle += (mouseX - pmouseX) * mouseSensitivity;
    angle += controllerManager.getCameraMovement() * 0.1;
    position = new PVector(target.x - distance*cos(angle), target.y - 200 , target.z - distance*-sin(angle));
    camera(position.x, position.y, position.z, target.x, target.y, target.z, 0, 1, 0);
  }
  
  void zoom(float amount) {
    distance += amount * zoomSensitivity;
    if (distance < minDistance) distance = minDistance;
    if (distance > maxDistance) distance = maxDistance;
  }

  void reset(PVector target) {
    this.target = target;
  }
  
}
