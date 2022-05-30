PVector sizeS = new PVector(1000,400,1000);
PVector sizeL = new PVector(3000,400,1000);
PVector sizeH = new PVector(3000,100,3000);
PVector sizeX2 = new PVector(3000,100,1000);
PVector sizeL2 = new PVector(1000,10000,1000);

/* Platform Size
    size = new PVector(x,y,z)
    x = largo*
    y = alto
    z = ancho*
  */
  
/* Insert common platform positions (id 0)
    pos.add(new PVector(2000,-2000,0));
    (x,y,z)
  */
  
Scene getLevel1(){
  //almacenar array acon posiciones
  ArrayList<Platform> plat  = new ArrayList<Platform>();
  ArrayList<PVector> pos = new ArrayList<PVector>();
  ArrayList<Collectable> collectables = new ArrayList<Collectable>();
  
  pos.add(new PVector(width/2,height,0));
  pos.add(new PVector(2000,-2000,0));
  pos.add(new PVector(2800,-2000,0));
  pos.add(new PVector(4400,-2000,0));
  pos.add(new PVector(6000,-2000,0));
  pos.add(new PVector(8500,-2000,-2000));
  for(PVector p : pos){
    plat.add(new Platform(p.x, p.y, p.z, 0, 0, 0,sizeL));
  }
  
  plat.add(new Platform(10400,-1800,600, 0, 0, 0,sizeL2));
  plat.add(new FastPlatform(6500,-2000,-1900,0 ,0 ,0,sizeX2));
  plat.add(new BouncingPlatform(1000,800,-700, 0, 0 , 0,sizeS));
  plat.add(new MovingPlatform(1000,700,1500, 0, 0, 0,sizeL));
  plat.add(new WindPlatform(1000,700,-1500, 0, 0, 0,sizeS));
  plat.add(new SlidingPlatform(3000,-2000,-2000, 0, 0, 0,sizeH));
  plat.add(new BreakablePlatform(3000,-2000,2000, 0, 0, 0,sizeH));
  plat.add(new GoalPlatform(7400,-1800,600,0,0,0,sizeL));
  
  for (int i = 0; i < 20; i++) {
    collectables.add(new Collectable(new PVector(2000 + 300*i, -2500, 0), 50, coinMaterial));
  }
  return new Scene(player,plat,collectables);
}

Scene getLevel2(){
  //almacenar array acon posiciones
  ArrayList<Platform> plat  = new ArrayList<Platform>();
  ArrayList<PVector> pos = new ArrayList<PVector>();
  ArrayList<PVector> pos2 = new ArrayList<PVector>();
  ArrayList<Collectable> collectables = new ArrayList<Collectable>();
  pos.add(new PVector(width/2,height,0));
  for(PVector p : pos){
    plat.add(new Platform(p.x, p.y, p.z, 0, 0, 0,sizeL));
  }
  pos2.add(new PVector(4000,height+3000,-1000));
  pos2.add(new PVector(5000,height+2000,1000));
  pos2.add(new PVector(8000,height+1700,700));
  pos2.add(new PVector(9000,height+1500,1000));
  pos2.add(new PVector(12000,height+1300,-1000));
  pos2.add(new PVector(14000,height+800,1000));
  for(PVector p : pos2){
    plat.add(new Platform(p.x, p.y, p.z, 0, 0, 0,sizeL2));
  }
  for(int i = 0; i < 5; i++){
    plat.add(new WindPlatform(4000+i*2000,height-1000,sin(90*i)*500, 0, 0, 0,sizeS));
  }
  
  
  for (int i = 0; i < 5; i++) {
    collectables.add(new Collectable(new PVector(8000 + 200*i, height-4000, 0), 50, coinMaterial));
  }
  
  for (int i = 0; i < 5; i++) {
    collectables.add(new Collectable(new PVector(12000 + 200*i, height-4000, 0), 50, coinMaterial));
  }
  
  for (int i = 0; i < 5; i++) {
    collectables.add(new Collectable(new PVector(14000 + 200*i, height-4000, 0), 50, coinMaterial));
  }
  plat.add(new BouncingPlatform(1000,height,-1000, 0, 0 , 0,sizeS));
  plat.add(new GoalPlatform(15000,height-2000,600,0,0,0,sizeS));
  return new Scene(player,plat,collectables);
}
