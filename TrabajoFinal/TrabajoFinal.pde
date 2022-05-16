import java.util.Map;

Player player;
ArrayList<Platform> platforms;
Camera cam;
PVector gravity;

HashMap<Character, Boolean> keys;

void setup() {
  size(640, 480, P3D);
  
  keys = new HashMap<Character, Boolean>();
  keys.put('w', false);
  keys.put('s', false);
  keys.put('a', false);
  keys.put('d', false);
  
  player = new Player(width/2, height/2, 0);
  cam = new Camera(player.position, 500, 50, 5000);
  platforms = new ArrayList<Platform>();
  platforms.add(new Platform(width/2, height, 0, 10, 1, 10, 0, 0, 0));
  
  gravity = new PVector(0, 1, 0);
}

void draw() {
  cam.update();
  
  background(255);
  directionalLight(255,255,255,1,1,-1);
  
  player.control();
  player.addForce(gravity);
  player.update();
  player.display();
  
  for (Platform platform : platforms) {
    platform.display();
  }
}

void keyPressed() {
  keys.put(key, true);
  if (key == ' ') {
    player.jump();
  }
}

void keyReleased() {
  keys.put(key, false);
}
