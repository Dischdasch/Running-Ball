float a1=0;
float b1=0;
float c1=0;
float mousey=0;
float cam=0;
float camdist=200;
class Figur
{
  float xPos;
  float yPos;
  float zPos;
  float xCam;
  float yCam;
  float zCam;
  Figur(float x,float y,float z,float v,float b,float n)
  {
    xPos=x;
    yPos=y;
    zPos=z;
    xCam=v;
    yCam=b;
    zCam=n;
  }
  void drawFigur()
  {
    pushMatrix();
    fill(#000000);
    translate(xPos,yPos,zPos);
    rotateY(mousey);
    sphere(20);
    popMatrix();
    pushMatrix();
    translate(xPos,yPos+50,zPos);
    rotateY(mousey);
    box(15,60,15);
    popMatrix();
  }
  void pressedkeys()
  {
    if(key=='a')
    {c1=-5;}
    if(key=='d')
    {c1=5;}
    if(key=='c')
    {cam=5;}
    if(key=='w')
    {b1=-5;}
    if(key=='s')
    {b1=5;}
  }
  void releasedkeys()
  {
    if(key=='a')
    {c1=0;}
    if(key=='d')
    {c1=0;}
    if(key=='c')
    {cam=0;}
    if(key=='w')
    {b1=0;}
    if(key=='s')
    {b1=0;}
  }
  void movedmouse()
  {
    if(mouseX<650)
    {mousey=-(-mouseX+650)*0.01;}
    if(mouseX>650)
    {mousey=(mouseX-650)*0.01;}
   
  }
  void moveFigur()
  {
    if(c1>0)
    { 
      xPos=sin(mousey)*c1+xPos;
      zPos=cos(mousey)*c1+zPos;
    }
    if(c1<0)
    { 
      xPos=sin(mousey)*c1+xPos;
      zPos=cos(mousey)*c1+zPos;
    }
    if(b1>0)
    {
      xPos=cos(mousey)*b1+xPos;
      zPos=sin(mousey)*b1+zPos;
    }
    if(b1<0)
    {
      xPos=cos(mousey)*b1+xPos;
      zPos=sin(mousey)*b1+zPos;
    }
  }
  void kamera()
  {
    translate(xPos,zPos);
    xCam=(cos(mousey)*camdist)+xPos;
    yCam=yPos;
    zCam=(sin(mousey)*camdist)+zPos;
    camera(xCam,yCam,zCam,xPos,yPos,zPos,0,1,0);
  if(cam>0)
    {
     camdist=10;
    }
    if(cam==0)
    {
      camdist=200;
    }
  }
}
