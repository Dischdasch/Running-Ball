import peasy.*;

Player player;
Camera cam;

boolean[] keys;

void setup() {
  size(640, 480, P3D);
  keys = new boolean[4];
  cam = new Camera(100, 50, 5000);
  player = new Player(width/2, height/2, 0);
}

void draw() {
  background(255);
  directionalLight(255,255,255,1,1,-1);
  player.update();
  player.display();
  cam.update(player.position);
}

void keyPressed() {
  
}

void keyReleased() {
}

void mouseMoved() {
}
