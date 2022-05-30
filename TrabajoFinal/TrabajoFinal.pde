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
  platformTexture, iceTexture, iceHeight, stoneTexture, stoneHeight, finishGoal;
PImage coinIcon;
Material coinMaterial, flagMaterial, platformMaterial, metalMaterial, iceMaterial;
float speed = 1.0;
int collectableCount = 0;
//Fin escena
boolean fin;
int escena = 0;
int preEscena = 1;
Scene level1;
Scene level2;
Scene level3;
Scene level4;

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
  
  ((PGraphics3D)g).textureWrap(Texture.REPEAT); // Textures repeat when scaled down
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
  
  finishGoal = loadImage("UI/FinishGoal.png");
  finishGoal.resize(300,100);
  coinIcon = loadImage("UI/CoinIcon.png");
  coinIcon.resize(50,50);
  
  collectableSound = new SoundFile(this, "Audio/collect.wav");
  music = new SoundFile(this, "Audio/music2.mp3");
  music.loop();
  

  
  level1 = getLevel1();
  level2 = getLevel2();
  level3 = getLevel2();
  level4 = getLevel2();
  
  gravity = new PVector(0, 1, 0);

  fluid = new Fluid(5000, true);
}

void draw() {
  
  if (!selectUI.shown && escena == 0) {
    escena = preEscena;
  } 
  switch (escena){
    case 0:
      selectUI.screenDraw();
      break;
    case 1:
      level1.update();
      if(level1.isFinished()) nextScene();
      break;
    case 2:
      level2.update();
      if(level2.isFinished()) nextScene();
      break;
    case 3:
      level3.update();
      if(level3.isFinished()) nextScene();
      break;
    case 4:
      level4.update();
      if(level4.isFinished()){
        nextScene();
        preEscena = 1;
        selectUI.shown = true;
        reloadLevels();
      }
      break;
  }
  
}



void drawUI(int id) {
    hint(DISABLE_DEPTH_TEST);
    switch (id){
      case 0:
        stroke(255);
        fill(255);
        noLights();
        image(coinIcon, width - 130, 15);
        textFont(numberFont);
        textSize(32);
        text(collectableCount, width - 50, 50);
        textFont(letterFont);
        
        break;
      case 1:
        stroke(255);
        fill(255);
        noLights();
        image(finishGoal, width/2-150, height/2-50);
        fill(0);
        textSize(15);
        text("Level (lvl) completed",width/2-130, height/2);
        textSize(10);
        text("Press SPACE to continue",width/2-110, height/2+20);
        fill(255);
        break;
    }
    
    hint(ENABLE_DEPTH_TEST);
}
//ya sea por reinicio o por finalizar, se reinicia
void reloadLevels(){
  level1 = getLevel1();
  level2 = getLevel2();
  level3 = getLevel2();
  level4 = getLevel2();
}
void nextScene(){
  escena += 1;
  level1.init();
  if(escena > 4){
    escena = 0;
  }
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
  if (key == 'R' && escena != 0){
    // preEscena hace que cuando se reinicia, vuelve a la escena en la que estaba antes, no usar
    // si se puede usar la ui.
     preEscena = escena;
     escena = 0;
     selectUI.shown = true;
     reloadLevels();
     level1.init();
  }
}

void keyReleased() {
  controllerManager.keyReleased(key);
}
