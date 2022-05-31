class LevelButton{
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
  
   
  LevelButton(int posX, int posY, int size, color buttonColor, color buttonHighlight, boolean levelFree, String name, Scene level){
    this.level = level;
    rectX = posX;
    rectY = posY;
    rectSize = size;
    rectColor = buttonColor;
    rectHighlight = buttonHighlight;
    buttonFree = levelFree;
    levelName = name;
    if(!levelFree)
    {
      rectColor = color(125);
      rectHighlight = color(125);
    }
    screenshot = loadImage("Screenshot"+name+"1.png");
    screenshot.resize(rectSize, rectSize);
  }
  
  void drawButton(){
   if(overRect(rectX, rectY, rectSize, rectSize) && buttonFree) 
   {
      //Slideshow
      rect(rectX, rectY, rectSize, rectSize);
      showSlides();
   }
   else{
     //image
     rect(rectX, rectY, rectSize, rectSize);
     if(!buttonFree)
     {
       screenshot.filter(GRAY);
     }
     image(screenshot, rectX, rectY);
     
     //reset hover count if hovering interrupted within interval
     count = 0;
   }
  }
  
  boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void openLevel(LevelButton button){
  button.buttonFree = true;
}

void showSlides(){
  //loadImages for level
  PImage image1 = loadImage("Screenshot"+levelName+"1.png");
  PImage image2 = loadImage("Screenshot"+levelName+"2.png");
  image1.resize(rectSize, rectSize);
  image2.resize(rectSize, rectSize);
  
  if(firstImage) //switch images on hover
  {//change to second
    image(image2, rectX, rectY);
  }
  else{
    image(image1, rectX, rectY);
  }
  count++;
  
  if(count % 30 == 0)
  {
    firstImage = !firstImage;
    count = 0;
  }
}
}
