class CircleButton{
  int x, y;  
  int size = 30;   
  color circleColor;
  color circleHighlight;
  boolean circleOver = false;
  boolean active = true;
  boolean highlight;
  
  CircleButton(int posX, int posY, int circleSize, color buttonColor, color buttonHighlight){
    x = posX;
    y = posY;
    size = circleSize;
    circleColor = buttonColor;
    circleHighlight = buttonHighlight;
    highlight = false;
  }
}

void crossCircleButtonOut(int posX, int posY, int r) {
  //cross out the button
  stroke(178, 34, 34); //<>//
  strokeWeight(2);
  line(posX + r*cos(45)-1, posY + r*sin(45)-1, posX - r*cos(45)+1, posY - r*sin(45)+1);
  stroke(0);
}

void drawCircleButton(int posX, int posY, int buttonSize, PImage image, int imageOffset, boolean currentlyOn)
{
  image.resize(buttonSize+4 - imageOffset, buttonSize+4 - imageOffset);
  fill(#EAFAF7);
  if (overCircle(posX, posY, buttonSize)) {
    //make Button bigger on hover
    buttonSize += 4; //<>//
    circle(posX, posY, buttonSize);
    image(image, posX - buttonSize/2 +imageOffset/2 , posY - buttonSize/2 + imageOffset/2 );
  }
  else{
    //Show image smaller by scaling
    circle(posX, posY, buttonSize);
    pushMatrix();
    float imgposx = posX - buttonSize/2 +imageOffset/2 + 0.11111*(posX - buttonSize/2 +imageOffset/2);
    float imgposy = posY - buttonSize/2 + imageOffset/2 + 0.11111*(posY - buttonSize/2 + imageOffset/2);
    scale(0.9);
    image(image, imgposx, imgposy);
    popMatrix();
  }
 
  if (!currentlyOn)//alrady covered??
  {
    crossCircleButtonOut(posX, posY, buttonSize/2);
  }
  
  if (overCircle(posX, posY, buttonSize)) 
  {
    //make Button smaller again
    buttonSize -= 4;
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
