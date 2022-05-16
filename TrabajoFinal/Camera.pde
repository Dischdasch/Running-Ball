class Camera {
  PeasyCam cam;
  Player target;
  
  // PeasyCam implementation
  Camera(PApplet app, float distance, float minDistance, float maxDistance) {
    cam = new PeasyCam(app, distance);
    cam.setMinimumDistance(minDistance);
    cam.setMaximumDistance(maxDistance);
  }
  
  // No PeasyCam
  Camera(float distance, float minDistance, float maxDistance) {
    
  }
  
  void update(PVector position) {
    camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), position.x, position.y, position.z, 0, 1, 0);
  }

}
