Figur figur1;
PImage img;
void setup()
{
  size(1300,750,P3D);
  figur1=new Figur(0,0,0,0,0,0);
  img = loadImage("image.png");
}
void draw()
{
  //println(mousey);
  background(#FFFFFF);
  lights();
  translate(0,-100,-100);
  image(img, 0,0);
  translate(0,100,+100);
  figur1.drawFigur();
  figur1.moveFigur();
  figur1.kamera();
}
void keyPressed()
{
  figur1.pressedkeys();
}
void keyReleased()
{
  figur1.releasedkeys();
}
void mouseMoved()
{
  figur1.movedmouse();
}
