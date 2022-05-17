import java.util.Map;

Player player;
ArrayList<Platform> platforms;
Camera cam;
PVector gravity;

HashMap<Character, Boolean> keys;
ArrayList<PVector> pos = new ArrayList<PVector>();

void setup() {
  size(640, 480, P3D);
  
  
  //almacenar array acon posiciones
  
  pos.add(new PVector(width/2,height,0));
  pos.add(new PVector(2000,-2000,0));
  pos.add(new PVector(1000,450,300));
  
  pos.add(new PVector(2800,-2000,0));
  pos.add(new PVector(4400,-2000,0));
  pos.add(new PVector(6000,-2000,0));
  pos.add(new PVector(7400,-1800,600));
  
  //añadir plataformas
  platforms = new ArrayList<Platform>();
  for(PVector p : pos){
    platforms.add(new Platform(p.x, p.y, p.z, 10, 1, 10, 0, 0, 0));
  }
  
  keys = new HashMap<Character, Boolean>();
  keys.put('w', false);
  keys.put('s', false);
  keys.put('a', false);
  keys.put('d', false);
  player = new Player(width/2, height/2, 0);
  cam = new Camera(player.position, 500, 50, 5000);
  
  
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
  player.updateCollision(pos);
  for (Platform platform : platforms) {
    platform.display();
  }
  
  
}

void keyPressed() {
  keys.put(key, true);
  if (key == ' '){
    player.jump();
  }
 
}

void keyReleased() {
  keys.put(key, false);
}
