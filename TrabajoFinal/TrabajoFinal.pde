import processing.sound.*;
Player player;
ArrayList<Platform> platforms;
Camera cam;
PVector gravity;
ControllerManager controllerManager = new ControllerManager();
ArrayList<Platform> plat  = new ArrayList<Platform>();
ArrayList<Collectable> collectables = new ArrayList<Collectable>();
ArrayList<Collectable> toBeRemoved = new ArrayList<Collectable>();
SelectScreen selectUI;
SoundFile music;
SoundFile collectableSound;
PShape coinModel, flagModel;
PShader standardShader;
PImage coinTexture, coinHeight, whiteTexture;
Material coinMaterial;
float speed = 1.0;
int collectableCount = 0;
float fogIntensity = 100;
PVector backgroundColor;
PVector one = new PVector(1,1,1);

void setup() {
  size(1280, 720, P3D);
  
  selectUI = new SelectScreen();
  backgroundColor = new PVector(35f/255f, 161f/255f, 235f/255f);
  
  player = new Player(width/2, height/2, 0);
  cam = new Camera(player.position, 500, 50, 5000);
  
  coinModel = loadShape("Models/coin.obj");
  flagModel = loadShape("Models/flag.obj");
  standardShader = loadShader("shaders/StandardFrag.glsl", "shaders/StandardVert.glsl");
  coinTexture = loadImage("Textures/CoinTexture.jpg");
  coinHeight = loadImage("Textures/CoinHeight.png");
  coinMaterial = new Material(standardShader, .5f, 1.0, 1.0, backgroundColor, one, one, coinTexture, 1.0, coinHeight, 5.0);
  
  collectableSound = new SoundFile(this, "Audio/collect.wav");
  music = new SoundFile(this, "Audio/music2.mp3");
  music.loop();
  
  /* Platform Size
    size = new PVector(x,y,z)
    x = largo*
    y = alto
    z = ancho*
  */
  PVector sizeS = new PVector(1000,400,1000);
  PVector sizeL = new PVector(3000,400,1000);
  PVector sizeH = new PVector(3000,100,3000);
  PVector sizeX2 = new PVector(3000,100,1000);
  
  ArrayList<PVector> pos = new ArrayList<PVector>();
  
  /* Insert common platform positions (id 0)
    pos.add(new PVector(2000,-2000,0));
    (x,y,z)
  */
  pos.add(new PVector(width/2,height,0));
  pos.add(new PVector(2000,-2000,0));
  pos.add(new PVector(2800,-2000,0));
  pos.add(new PVector(4400,-2000,0));
  pos.add(new PVector(6000,-2000,0));
  pos.add(new PVector(8500,-2000,-2000));
  for(PVector p : pos){
    plat.add(new Platform(p.x, p.y, p.z, 0, 0, 0,sizeL));
  }
  
  plat.add(new FastPlatform(6500,-2000,-1900,0 ,0 ,0,sizeX2));
  plat.add(new BouncingPlatform(1000,800,-700, 0, 0 , 0,sizeS));
  plat.add(new MovingPlatform(1000,700,1500, 0, 0, 0,sizeL));
  plat.add(new WindPlatform(1000,700,-1500, 0, 0, 0,sizeS));
  plat.add(new SlidingPlatform(3000,-2000,-2000, 0, 0, 0,sizeH));
  plat.add(new BreakablePlatform(3000,-2000,2000, 0, 0, 0,sizeH));
  plat.add(new GoalPlatform(7400,-1800,600,0,0,0,sizeL));
  
  for (int i = 0; i < 20; i++) {
    collectables.add(new Collectable(new PVector(2000 + 300*i, -2500, 0), 25, coinMaterial));
  }
  
  gravity = new PVector(0, 1, 0);
}

void draw() {
  if (selectUI.shown) {
    selectUI.screenDraw();
  } else {
    pushMatrix();
    cam.update();
    
    background(backgroundColor.x*255, backgroundColor.y*255, backgroundColor.z*255);
    directionalLight(255,255,255,1,1,-1);
    
    player.controlling();
    player.addForce(gravity);
    player.update();
    player.display();
    player.updateCollision(plat);
    for (Platform platform : plat) {
      platform.display();
      platform.update();
    }
    playMusic(player.velocity.mag());
    handleCollectables();
    popMatrix();
    drawUI();
  }
}

void handleCollectables() {
  for (Collectable collectable : collectables) {
    collectable.display();
    if (collectable.collidesWith(player)) toBeRemoved.add(collectable);
  }
  for (Collectable collectable : toBeRemoved) {
    collectables.remove(collectable);
  }
  toBeRemoved.clear();
}

void drawUI() {
    hint(DISABLE_DEPTH_TEST);
    stroke(255);
    fill(255);
    noLights();
    textSize(32);
    text(collectableCount, width -50, 50);
    hint(ENABLE_DEPTH_TEST);
  }

void mousePressed()
{
  selectUI.screenMousePressed();
}

void mouseReleased()
{
  if (selectUI.changeMusic && !music.isPlaying()) {
    music.loop();
    selectUI.changeMusic = false;
  } else if (selectUI.changeMusic) {    
    music.pause();
    selectUI.changeMusic = false;
  }
}

void playMusic(float speed) {
  float velocity = map(speed, 0.0, 25.0, 0.75, 1.25);
  if(velocity > 1.25){
    velocity = 1.25;
  }
  music.rate(velocity);
}

void keyPressed() {
  controllerManager.keyPressed(key);
  player.onKeyPressedOnce();
}

void keyReleased() {
  controllerManager.keyReleased(key);
}
