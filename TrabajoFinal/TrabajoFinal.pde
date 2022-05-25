import processing.sound.*;
Player player;
ArrayList<Platform> platforms;
Camera cam;
PVector gravity;
ControllerManager controllerManager = new ControllerManager();

ArrayList<Platform> plat  = new ArrayList<Platform>();
SelectScreen selectUI;
SoundFile music;
float speed = 1.0;

void setup() {
  size(1280, 720, P3D);
  
  selectUI = new SelectScreen();
  
  /* Tamaños de plataforma
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
  
  /* Insertar posiciones de plataformas comunes (id 0)
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
  
  /* Insertar posiciones de plataformas especiales (id > 0)
     plat.add(new FastPlatform(6500,-2000,-2000,0 ,0 ,0,sizeX2));
     
     (x,y,z,rotacionx,rotaciony,rotacionz,PVector tamaño)
     *para PVector tamaño usar los tamaños de arriba
  */
  
  plat.add(new FastPlatform(6500,-2000,-2000,0 ,0 ,0,sizeX2));
  plat.add(new BouncingPlatform(1000,800,-700, 0, 0 , 0,sizeS));
  plat.add(new MovingPlatform(1000,700,1500, 0, 0, 0,sizeL));
  plat.add(new WindPlatform(1000,700,-1500, 0, 0, 0,sizeS));
  plat.add(new SlidingPlatform(3000,-2000,-2000, 0, 0, 0,sizeH));
  plat.add(new BreakablePlatform(3000,-2000,2000, 0, 0, 0,sizeH));
  plat.add(new GoalPlatform(7400,-1800,600,0,0,0,sizeL));

  player = new Player(width/2, height/2, 0);
  cam = new Camera(player.position, 500, 50, 5000);
  
  music = new SoundFile(this, "music.mp3");
  music.loop();
  
  gravity = new PVector(0, 1, 0);
}

void draw() {
  
  if(selectUI.shown)
  {
  selectUI.screenDraw();
  } else {
  cam.update();
  
  background(255);
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
  }
}

void mousePressed()
{
  selectUI.screenMousePressed();
}

void mouseReleased()
{
  if (selectUI.changeMusic && !music.isPlaying())
  {
    music.loop();
    selectUI.changeMusic = false;
  }
  else if (selectUI.changeMusic)
  {    
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
