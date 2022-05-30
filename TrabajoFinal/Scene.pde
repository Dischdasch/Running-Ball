class Scene  {
  Player pl;
  ArrayList<Platform> platforms;
  ArrayList<Collectable> collectablesScene;
  ArrayList<Collectable> toBeRemoved = new ArrayList<Collectable>();
  boolean acabado; //llega a la meta, pero no se va
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
    
    pl.controlling();
    pl.addForce(gravity);
    pl.update();
    pl.display();
    pl.updateCollision(platforms);
    for (Platform platform :platforms) {
      platform.display();
      platform.update();
      if(platform.isDown() && platform.getID() == 5 && acabado == false){
       
        acabado = true;
      }
    }
    playMusic(player.velocity.mag());
    handleCollectables();
    fluid.update();
    popMatrix();
    drawUI(0);
    if(acabado == true){
      drawUI(1);
    }
    if(key == ' ' && acabado){
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
