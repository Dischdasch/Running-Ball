import processing.sound.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

ControlIO control;
ArrayList<Platform> platforms;
Player player;
Camera cam;
PVector gravity;
ControllerManager controllerManager;
ArrayList<Platform> plat  = new ArrayList<Platform>();
ArrayList<Collectable> collectables = new ArrayList<Collectable>();
ArrayList<Collectable> toBeRemoved = new ArrayList<Collectable>();
SelectScreen selectUI;
SoundFile music;
SoundFile collectableSound, jumpSound, bounceSound, landSound, fanfareSound, splashSound;
PShape coinModel, flagModel, blockModel, windPlatformModel;
PShader standardShader, flagShader;
PImage coinTexture, coinHeight, whiteTexture, grayTexture, flagTexture, 
  platformTexture, iceTexture, iceHeight, stoneTexture, stoneHeight, bouncyTexture,
  finishGoal;
PImage coinIcon;
Material coinMaterial, flagMaterial, platformMaterial, metalMaterial, iceMaterial, bouncyMaterial, breakableMaterial;
float speed = 1.0;
int collectableCount = 0;
Scene level1, level2, level3, level4, currentScene;

float fogIntensity = 100;
PVector backgroundColor;
PVector one = new PVector(1, 1, 1);
PFont letterFont, numberFont;
float musicVelocity = 1.0;

//deadui
float movementForce = 2f;

boolean dead = false;
CircleButton deadButton;

Fluid fluid;
int fluidHeight = 2000;



void setup() {
  size(1280, 720, P3D);
  control = ControlIO.getInstance(this);
  
  
  backgroundColor = new PVector(35f/255f, 161f/255f, 235f/255f);
  letterFont = createFont("Fonts/SportypoRegular.ttf", 128);
  numberFont = createFont("Fonts/Chopsic.otf", 128);
  textFont(letterFont);

  ((PGraphics3D)g).textureWrap(Texture.REPEAT); // Textures repeat when scaled down


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
  stoneTexture = loadImage("Textures/StoneTexture.jpg");
  bouncyTexture = loadImage("Textures/BouncyTexture.jpg");
  stoneHeight = loadImage("Textures/StoneHeight.png");
  coinMaterial = new Material(standardShader, 0.5f, 1.0, 1.0, backgroundColor, one, one, one, coinTexture, 1.0, coinHeight, 1.0);
  flagMaterial = new Material(flagShader, 0.5f, 1.0, 0.0, backgroundColor, one, one, one, flagTexture, 1.0, grayTexture, 1.0);
  platformMaterial = new Material(standardShader, 0.5f, 1.0, 0.0, backgroundColor, one, one, one, stoneTexture, 1.0, stoneHeight, 1.0);
  metalMaterial = new Material(standardShader, 0.5f, 1.0, 1.0, backgroundColor, one, one, one, grayTexture, 1.0, whiteTexture, 1.0);
  iceMaterial = new Material(standardShader, 0.5f, 1.0, 1.0, backgroundColor, one, one, one, iceTexture, 1.0, iceHeight, 1.0);
  bouncyMaterial = new Material(standardShader, 0.5f, 1.0, 0.0, backgroundColor, one, one, one, bouncyTexture, 1.0, grayTexture, 1.0);
  breakableMaterial = new Material(standardShader, 0.5f, 1.0, 0.0, backgroundColor, one, new PVector(0f, 1f, 0f), one, whiteTexture, 1.0, grayTexture, 1.0);

  finishGoal = loadImage("UI/FinishGoal.png");
  finishGoal.resize(720, 150);
  coinIcon = loadImage("UI/CoinIcon.png");
  coinIcon.resize(50, 50);

  collectableSound = new SoundFile(this, "Audio/collect.wav");
  bounceSound = new SoundFile(this, "Audio/boing.wav");
  jumpSound = new SoundFile(this, "Audio/jump.wav");
  landSound = new SoundFile(this, "Audio/land.wav");
  fanfareSound = new SoundFile(this, "Audio/fanfare.wav");
  splashSound = new SoundFile(this, "Audio/splash.wav");
  music = new SoundFile(this, "Audio/music2.mp3");
  music.amp(0.5);
  music.loop();

  player = new Player(640, 360, 0);
  cam = new Camera(player.position, 750, 250, 2000);
  controllerManager = new ControllerManager();

  loadLevels();

  gravity = new PVector(0, 1, 0);
  //deadui
  deadButton = new CircleButton(width/2, height/2, 50, color(200), color(255));
  fluid = new Fluid(fluidHeight, true);
  
  selectUI = new SelectScreen();
}

void draw() {
  if (selectUI.shown) {
    selectUI.screenDraw();
  } else {
    currentScene.update();
  }
}

void returnToMenu() {
  loadLevels();
  selectUI.loadButtons();
  selectUI.shown = true;
  music.rate(1.0);
  music.loop();
}

//ya sea por reinicio o por finalizar, se reinicia
void loadLevels() {
  level4 = getLevel4(null);
  level3 = getLevel3(level4);
  level2 = getLevel2(level3);
  level1 = getLevel1(level2);
}

void mouseWheel(MouseEvent event) {
  float amount = event.getCount();
  cam.zoom(amount);
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
  musicVelocity = lerp(musicVelocity, map(speed, 0.0, player.maxSpeed, 0.75, 1.25), 0.9);
  if (musicVelocity > 1.25) {
    musicVelocity = 1.25;
  } 
  music.rate(musicVelocity);
}

void keyPressed() {
  controllerManager.keyPressed(key);
  player.onKeyPressedOnce();
  if (key == 'R') {
    // preEscena hace que cuando se reinicia, vuelve a la escena en la que estaba antes, no usar
    // si se puede usar la ui.
    selectUI.shown = true;
    loadLevels();
  }
  if (key == ' ' && currentScene != null) {
    onButtonPressed();
  }
}

void keyReleased() {
  controllerManager.keyReleased(key);
}

public void onButtonPressed() {
  if (dead) {
    //Restart level and player position
    loadLevels();
    currentScene.init();
  
    cam.reset(player.position);
    dead = false;
  } else if (currentScene.finished) {
    currentScene.next();
  }
}
