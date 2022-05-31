class Scene  {
  Player pl;
  ArrayList<Platform> platforms;
  ArrayList<Collectable> collectablesScene;
  ArrayList<Collectable> toBeRemoved = new ArrayList<Collectable>();
  boolean prefin; //llega a la meta, pero no se va
  boolean fin; //cambio de escena
  int nivel;
  Scene(Player p, ArrayList<Platform> level, ArrayList<Collectable> collectable){
    pl = p;
    platforms = level;
    collectablesScene = collectable;
  }
  boolean isFinished(){
    return fin;  
  }
  int getNivel(){
    return nivel;  
  }
  void init(){
    pl.position.x = width/2;
    pl.position.y = height/2+100;
    pl.position.z = 0;
  }
  void update(){
    pushMatrix();
    cam.update();
    
    background(backgroundColor.x*255, backgroundColor.y*255, backgroundColor.z*255);
    directionalLight(255,255,255, -1, 1, -1);
    
    
    for (Platform platform :platforms) {
      platform.display();
      platform.update();
      if(platform.isDown() && platform.getID() == 5 && prefin == false){
       
        prefin = true;
      }
    }
    playMusic(player.velocity.mag());
    handleCollectables();
    fluid.update();
    if(!dead){
      pl.controlling();
      pl.addForce(gravity);
      pl.update();
    pl.display();
    pl.updateCollision(platforms);
    }
    popMatrix();
    drawUI(0);
    if(prefin == true){
      drawUI(1);
    }
    if(key == ' ' && prefin){
      fin = true;
    }
  }
  void handleCollectables() {
  for (Collectable collectable : collectablesScene) {
    collectable.display();
    if (collectable.collidesWith(player)) toBeRemoved.add(collectable);
  }
  for (Collectable collectable : toBeRemoved) {
    collectablesScene.remove(collectable);
  }
  toBeRemoved.clear();
  }
}
