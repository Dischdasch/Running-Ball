Player player;
ArrayList<Platform> platforms;
Camera cam;

boolean[] keys;

void setup() {
  size(640, 480, P3D);
  keys = new boolean[4];
  player = new Player(width/2, height/2, 0);
  cam = new Camera(player.position, 500, 50, 5000);
  platforms = new ArrayList<Platform>();
  platforms.add(new Platform(width/2, height, 0, 10, 1, 10, 0, 0, 0));
}

void draw() {
  cam.update();
  
  background(255);
  directionalLight(255,255,255,1,1,-1);
  
  player.update();
  player.display();
  
  for (Platform platform : platforms) {
    platform.display();
  }
}

void keyPressed() {
  
}

void keyReleased() {
  
}

void mouseMoved() {
  
}
