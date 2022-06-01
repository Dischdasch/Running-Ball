class LevelButton {
  int rectX, rectY;
  int rectSize = 90;
  color rectColor;
  color rectHighlight;
  boolean rectOver = false;
  boolean buttonFree;
  String levelName;
  boolean firstImage = true;
  PImage screenshot;
  int count = frameCount;
  Scene level;
  PGraphics pg;


  LevelButton(int posX, int posY, int size, color buttonColor, color buttonHighlight, boolean levelFree, String name, Scene level) {
    this.level = level;
    rectX = posX;
    rectY = posY;
    rectSize = size;
    rectColor = buttonColor;
    rectHighlight = buttonHighlight;
    buttonFree = levelFree;
    levelName = name;
    if (!levelFree)
    {
      rectColor = color(125);
      rectHighlight = color(125);
    }
    screenshot = loadImage("Screenshot"+name+"1.png");
    screenshot.resize(rectSize, rectSize);

    //mask screenshot to cirlce
    maskImage(screenshot);
  }

  void drawButton() {
    if (overButton(rectX, rectY, rectSize) && buttonFree)
    {
      //Slideshow
      circle(rectX+rectSize/2, rectY+rectSize/2, rectSize);
      showSlides();
    } else {
      //image
      circle(rectX+rectSize/2, rectY+rectSize/2, rectSize);
      if (!buttonFree)
      {
        screenshot.filter(GRAY);
      }
      //image(screenshot, rectX, rectY);
      image( screenshot, rectX, rectY);

      //reset hover count if hovering interrupted within interval
      count = 0;
    }
  }

  boolean overButton(int x, int y, int diameter) {
    float disX = x + diameter/2 - mouseX;
    float disY = y + diameter/2- mouseY;
    if (sqrt(sq(disX) + sq(disY)) > diameter/2 ) {
      return false;
    } else {
      return true;
    }
  }

  void openLevel(LevelButton button) {
    button.buttonFree = true;
  }

  void showSlides() {
    //loadImages for level
    PImage image1 = loadImage("Screenshot"+levelName+"1.png");
    PImage image2 = loadImage("Screenshot"+levelName+"2.png");
    image1.resize(rectSize, rectSize);
    image2.resize(rectSize, rectSize);

    if (firstImage) //switch images on hover
    {//change to second
      maskImage(image2);
      image(image2, rectX, rectY);
    } else {
      maskImage(image1);
      image(image1, rectX, rectY);
    }
    count++;

    if (count % 30 == 0)
    {
      firstImage = !firstImage;
      count = 0;
    }
  }

  void maskImage(PImage image) {
    pg = createGraphics( rectSize, rectSize);
    pg.beginDraw();
    pg.smooth();
    pg.ellipse(rectSize/2, rectSize/2, rectSize, rectSize);
    pg.endDraw();
    image.mask( pg.get() ); // This is the magic.
  }
}
