class CircleButton{
  int x, y;  
  int size = 90;   
  color circleColor;
  color circleHighlight;
  boolean circleOver = false;
  boolean active = true;
  
  CircleButton(int posX, int posY, int circleSize, color buttonColor, color buttonHighlight){
    x = posX;
    y = posY;
    size = circleSize;
    circleColor = buttonColor;
    circleHighlight = buttonHighlight;
  }
}

void crossCircleButtonOut(int posX, int posY, int r) {
  //cross out the button
  stroke(178, 34, 34);
  strokeWeight(2);
  line(posX + r*cos(45)-1, posY + r*sin(45)-1, posX - r*cos(45)+1, posY - r*sin(45)+1);
  stroke(0);
}

void drawCircleButton(int posX, int posY, int buttonSize, PImage image, int imageOffset, boolean currentlyOn)
{
  fill(#EAFAF7);
  if (overCircle(posX, posY, buttonSize)) {
    //hover and highlight
    fill(#BFFAF7);
  }
  circle(posX, posY, buttonSize);
  image.resize(buttonSize - imageOffset, buttonSize - imageOffset);
  image(image, posX - buttonSize/2 +imageOffset/2, posY - buttonSize/2 + imageOffset/2);
  if (!currentlyOn)//alrady covered??
  {
    crossCircleButtonOut(posX, posY, buttonSize/2);
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
