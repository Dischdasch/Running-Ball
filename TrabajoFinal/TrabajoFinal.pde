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
PShape coinModel, flagModel, blockModel, windPlatformModel;
PShader standardShader, flagShader;
PImage coinTexture, coinHeight, whiteTexture, grayTexture, flagTexture, 
  platformTexture, iceTexture, iceHeight, stoneTexture, stoneHeight;
PImage coinIcon;
Material coinMaterial, flagMaterial, platformMaterial, metalMaterial, iceMaterial;
float speed = 1.0;
int collectableCount = 0;
float fogIntensity = 100;
PVector backgroundColor;
PVector one = new PVector(1,1,1);
PFont letterFont, numberFont;
float musicVelocity = 1.0;

Fluid fluid;

void setup() {
  size(1280, 720, P3D);
  
  selectUI = new SelectScreen();
  backgroundColor = new PVector(35f/255f, 161f/255f, 235f/255f);
  letterFont = createFont("Fonts/SportypoRegular.ttf", 128);
  numberFont = createFont("Fonts/Chopsic.otf", 128);
  textFont(letterFont);
  
  player = new Player(width/2, height/2, 0);
  cam = new Camera(player.position, 500, 50, 5000);
  
  // Shaders, textures, models and materials
  coinModel = loadShape("Models/coin.obj");
  flagModel = loadShape("Models/flag.obj");
  blockModel = loadShape("Models/SplitBlock.obj");
  windPlatformModel = loadShape("Models/WindPlatform.obj");
  standardShader = loadShader("Shaders/StandardFrag.glsl", "Shaders/StandardVert.glsl");
  flagShader = loadShader("Shaders/StandardFrag.glsl", "Shaders/WindVert.glsl");
  coinTexture = loadImage("Textures/CoinTexture.jpg");
  coinHeight = loadImage("Textures/CoinHeight.png");
  whiteTexture = loadImage("Textures/white.jpg");
  grayTexture = loadImage("Textures/Gray.jpg");
  flagTexture = loadImage("Textures/FlagTexture.jpg");
  platformTexture = loadImage("Textures/PlatformTexture.jpg");
  iceTexture = loadImage("Textures/IceTexture.jpg");
  iceHeight = loadImage("Textures/IceHeight.png");
  stoneTexture = loadImage("Textures/PlatformTexture.jpg");
  stoneHeight = loadImage("Textures/StoneHeight.png");
  coinMaterial = new Material(standardShader, 0.5f, 1.0, 1.0, backgroundColor, one, one, one, coinTexture, 1.0, coinHeight, 1.0);
  flagMaterial = new Material(flagShader, 0.5f, 1.0, 0.0, backgroundColor, one, one, one, flagTexture, 1.0, grayTexture, 1.0);
  platformMaterial = new Material(standardShader, 0.5f, 1.0, 0.0, backgroundColor, one, one, one, stoneHeight, 1.0, stoneHeight, 1.0);
  metalMaterial = new Material(standardShader, 0.5f, 1.0, 1.0, backgroundColor, one, one, one, grayTexture, 1.0, whiteTexture, 1.0);
  iceMaterial = new Material(standardShader, 0.5f, 1.0, 1.0, backgroundColor, one, one, one, iceTexture, 1.0, iceHeight, 1.0);
  
  coinIcon = loadImage("UI/CoinIcon.png");
  coinIcon.resize(50,50);
  
  collectableSound = new SoundFile(this, "Audio/collect.wav");
  music = new SoundFile(this, "Audio/music2.mp3");
  music.loop();
  
  //tamaño
  PVector sizeL = new PVector(100,400,100);
  PVector sizeH = new PVector(300,100,300);
  PVector sizeX2 = new PVector(300,100,100);
  //almacenar array acon posiciones
  ArrayList<PVector> pos = new ArrayList<PVector>();
  pos.add(new PVector(width/2,height,0));
  pos.add(new PVector(2000,-2000,0));
  pos.add(new PVector(2800,-2000,0));
  pos.add(new PVector(4400,-2000,0));
  pos.add(new PVector(6000,-2000,0));
  pos.add(new PVector(8500,-2000,-2000));
  //añadir plataformas
  for(PVector p : pos){
    plat.add(new Platform(p.x, p.y, p.z, 10, 1, 10, 0, 0, 0,sizeL));
  }
  plat.add(new TeleportPlatform(-1000,500,0, 10, 1 , 10 ,0 ,0 ,0,sizeL));
  plat.add(new FastPlatform(6500,-2000,-2000, 10 , 1, 10 ,0 ,0 ,0,sizeX2));
  plat.add(new BouncingPlatform(1000,450,300, 10, 1, 10, 0, 0 , 0,sizeL));
  plat.add(new MovingPlatform(1000,700,1500, 10, 1, 10, 0, 0, 0,sizeL));
  plat.add(new WindPlatform(1000,700,-1500, 10, 1, 10, 0, 0, 0,sizeL));
  plat.add(new SlidingPlatform(3000,-2000,-2000, 10, 1, 10, 0, 0, 0,sizeH));
  plat.add(new BreakablePlatform(3000,-2000,2000, 10, 1, 10, 0, 0, 0,sizeH));
  plat.add(new GoalPlatform(7400,-1800,600,10,1,10,0,0,0,sizeL));
  
  for (int i = 0; i < 20; i++) {
    collectables.add(new Collectable(new PVector(2000 + 300*i, -2500, 0), 50, coinMaterial));
  }
  
  gravity = new PVector(0, 1, 0);

  fluid = new Fluid(5000, true);
}

void draw() {
  if (selectUI.shown) {
    selectUI.screenDraw();
  } else {
    pushMatrix();
    cam.update();
    
    background(backgroundColor.x*255, backgroundColor.y*255, backgroundColor.z*255);
    directionalLight(255,255,255, -1, 1, -1);
    
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
    fluid.update();
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
    image(coinIcon, width - 130, 15);
    textFont(numberFont);
    textSize(32);
    text(collectableCount, width - 50, 50);
    textFont(letterFont);
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
  musicVelocity = lerp(musicVelocity, map(speed, 0.0, player.maxSpeed, 0.75, 1.25), 0.1);
  if(musicVelocity > 1.25){
    musicVelocity = 1.25;
  }
  music.rate(musicVelocity);
}

void keyPressed() {
  controllerManager.keyPressed(key);
  player.onKeyPressedOnce();
}

void keyReleased() {
  controllerManager.keyReleased(key);
}
