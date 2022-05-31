class Scene {
  ArrayList<Platform> platforms;
  ArrayList<Collectable> collectablesScene;
  ArrayList<Collectable> toBeRemoved = new ArrayList<Collectable>();
  boolean finished;
  Scene nextScene;
  String name;

  Scene(ArrayList<Platform> level, ArrayList<Collectable> collectable, Scene nextScene, String name) {
    platforms = level;
    collectablesScene = collectable;
    this.nextScene = nextScene;
    this.name = name;
  }

  void init() {
    player.position.x = width/2;
    player.position.y = height/2+100;
    player.position.z = 0;
    music.loop();
  }

  void update() {
    pushMatrix();
    cam.update();

    background(backgroundColor.x*255, backgroundColor.y*255, backgroundColor.z*255);
    directionalLight(255, 255, 255, -1, 1, -1);

    for (Platform platform : platforms) {
      platform.display();
      platform.update();
      if (platform.isDown() && platform.getID() == 5 && finished == false) {
        music.pause();
        finished = true;
        fanfareSound.play();
      }
    }

    playMusic(player.velocity.mag());
    handleCollectables();
    fluid.update();
    if (!dead) {
      player.controlling();
      player.addForce(gravity);
      player.update();
      player.display();
      player.updateCollision(platforms);
      player.checkDeath();
    }
    popMatrix();

    hint(DISABLE_DEPTH_TEST);
    coinUI();
    if (dead) dieUI();
    if (finished == true) {
      goalUI();
    }
    hint(ENABLE_DEPTH_TEST);

    if (key == ' ' && finished) {
      next();
    }
  }

  //coinui
  void coinUI() {
    stroke(255);
    fill(255);
    noLights();
    image(coinIcon, width - 130, 15);
    textFont(numberFont);
    textSize(32);
    text(collectableCount, width - 50, 50);
    textFont(letterFont);
  }

  //goalUI
  void goalUI() {
    stroke(255);
    fill(255);
    noLights();
    imageMode(CENTER);
    image(finishGoal, width/2, height/2);
    imageMode(CORNER);
    fill(0);
    textSize(15);
    text("Level " + name + " completed", width/2-130, height/2);
    textSize(10);
    text("Press SPACE to continue", width/2-110, height/2+20);
    fill(255);
  }

  //deadui
  void dieUI() {
    text("dead", width/2, height/2);
    textSize(16);
    text("press any key to retry", width/2, height/2 + 32);
    if (controllerManager.getActions().length > 0) {
      //Restart level and player position
      loadLevels();
      currentScene.init();

      cam.reset(player.position);
      dead = false;
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

  void next() {
    if (nextScene == null) {
      returnToMenu();
    } else {
      nextScene.init();
      currentScene = nextScene;
    }
  }
}
