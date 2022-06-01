public class Player {
  // Physics
  PVector position, velocity, acceleration;
  float xAngle, zAngle, xAngleVelocity, zAngleVelocity;
  float dragIntensity = 1f;
  boolean grounded = false;
  float cameraAngle;
  int numcollisions = 0;

  // Geometry
  float radius = 50;
  float diameter = 2*radius;

  // Movement
  float movementForce = 2f;
  float maxSpeed = 25;
  float jumpForce = 30f;
  private PVector controlForce = new PVector(0, 0, 0);

  // Graphics
  PImage texture, heightMap;
  PShape model;
  Material material;

  // Standing platform
  int nPlat;

  Player(float x, float y, float z) {
    this.position = new PVector(x, y, z);
    this.velocity = new PVector(0, 0, 0);
    this.acceleration = new PVector(0, 0, 0);
    model = loadShape("Models/Bunny.obj");
    texture = loadImage("Textures/BunnyTexture.png");
    heightMap = loadImage("Textures/BunnyHeight.png");
    material = new Material(standardShader, 0.5f, 1.0, 0.0, backgroundColor, one, one, one, texture, 1.0, heightMap, 10.0);
  }

  void update() {
    controlForce.add(controllerManager.getMovement());
    move();
    
    PVector drag = velocity.copy();
    drag.y = 0;
    drag.mult(-1);
    drag.setMag(dragIntensity);
    addForce(drag);

    if (grounded) {
      xAngleVelocity = velocity.z*0.01;
      zAngleVelocity = velocity.x*0.01;
    }
    xAngle += xAngleVelocity;
    zAngle += zAngleVelocity;

    PVector horizontalVelocity = velocity.copy();
    horizontalVelocity.y = 0f;
    horizontalVelocity.limit(maxSpeed);
    velocity = new PVector(horizontalVelocity.x, velocity.y, horizontalVelocity.z);
    velocity.add(acceleration);
    position.add(velocity);

    acceleration.mult(0);
  }

  void updateCollision(ArrayList<Platform> pos) {
    int num = 0;
    for (Platform b : pos) {
      num++;
      collisionBoxDetection(b, num);
    }
  }

  void updateCollision(Platform b) {
    collisionBoxDetection(b, 11);
  }

  void addForce(PVector force) {
    acceleration.add(force.copy());
  }

  //colision box 2
  /* box = platform initial position
   size = platform size
   */
  void collisionBoxDetection(Platform plat, int num) {
    PVector box = plat.getXYZ();
    PVector size = plat.getSize();
    //Colision directa
    if (dist(position.x, 0, box.x, 0) < size.x + radius && dist(position.y+radius, 0, box.y, 0) < size.y + radius && dist(position.z, 0, box.z, 0) < size.z + radius) {
      //Collision below platform (usar plataforma de rebote)
      if (dist(0, position.y, 0, 0, box.y - size.y, 0) > radius*2) {

        //position.y = box.y + radius*2 + size.y;
        //Deteccion por ancho o por largo
        if (dist(position.z+radius/2, 0, box.z, 0) < size.z + radius) {
          player.addForce(new PVector(0, 0, -velocity.z*3));
        }
        if ((dist(position.x+radius/2, 0, box.x, 0) < size.x + radius)) {
          player.addForce(new PVector(-velocity.x*3, 0, 0));
        }

        player.addForce(new PVector(0, -velocity.y, 0));
      } else {
        position.y = box.y - radius*2 - size.y;
        //bouncingplatform
        if (!grounded) landSound.play();
        grounded = true;
      }
      if (grounded) {
        velocity.y = 0f;
      }
      plat.triggerDown();  
      plat.getEffect(this);
      nPlat = num;
    } else {
      //nPlataforma == numero que esta pisando el jugador.
      if (num == nPlat) {
        grounded = false;
      }
    }
    //Colision indirecta (above platform)
    if (position.y <= box.y - radius - size.y && position.x > box.x-size.x && position.x < box.x+size.x && position.z > box.z-size.z && position.z < box.z+size.z) {
      if (plat.getID() == 2) {
        if (position.y > box.y-1500) {
          velocity.y -= 4f;
        } else {
          velocity.y -= 0.25f;
        }
      }
    }
  }

  void controlling() {
    Control [] controls = controllerManager.getActions();
    controlForce = new PVector(0, 0, 0);

    for (Control control : controls) {
      processControl(control);
    }
    //move();
  }
  
  private void move() {
    controlForce.setMag(movementForce);
    if (abs(cam.angle - cameraAngle) > 0.01) controlForce = MatrixOperations.yRotate(controlForce, cam.angle - cameraAngle);
    player.addForce(controlForce);
  }

  private void processControl(Control control) {
    switch (control) {
    case FORWARD:
      controlForce.x += 1;
      break;
    case BACK:
      controlForce.x += -1;
      break;
    case LEFT:
      controlForce.z += -1;
      break;
    case RIGHT:
      controlForce.z += 1;
      break;
    default:
      break;
    }
  }

  // Necesitamos un evento para cuando una tecla se pusa una sola vez, como en el salto, y no continuamente
  void onKeyPressedOnce() {
    if (key == ' ') {
      jump();
    }
  }

  public void jump() {
    if (grounded) {
      player.addForce(new PVector(0, -jumpForce, 0));
      jumpSound.play();
    }
  }

  void checkDeath() {
    if (player.position.y >= fluidHeight) {
      dead = true;
      splashSound.play();
      music.pause();
    } else {
      dead = false;
    }
  }

  void display() {
    noStroke();
    pushMatrix();
    translate(position.x, position.y, position.z);
    pushMatrix();
    rotateX(PI + xAngle);
    rotateZ(zAngle);
    scale(750);
    material.setMaterial();
    shape(model);
    resetShader();
    popMatrix();
    fill(255, 255, 255, 50);
    // shader(material);
    sphere(diameter); // This could be a 3D model
    fill(255);
    popMatrix();
    fill(0);
    pushMatrix();
    translate(position.x, position.y);
    textSize(100);
    rotateZ(100);
    //text(position.x, 100,0);
    translate(0, 50);
    //text(position.y, 100,0);
    popMatrix();
    fill(255);
  }
}
