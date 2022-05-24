
Player player;
ArrayList<Platform> platforms;
Camera cam;
PVector gravity;
ControllerManager controllerManager = new ControllerManager();
ArrayList<Platform> plat  = new ArrayList<Platform>();
SelectScreen selectUI;

void setup() {
  size(1280, 720, P3D);
  
  selectUI = new SelectScreen();
  
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

  player = new Player(width/2, height/2, 0);
  cam = new Camera(player.position, 500, 50, 5000);
  
  
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
  }
}

void mousePressed()
{
  selectUI.screenMousePressed();
}
