class SelectScreen{
  //General
  color baseColor = color(#DCFAF7);
  color currentColor;
  boolean shown = true;
  PImage background;

  //Level Buttons
  int buttonSize = 250;
  LevelButton level1;
  LevelButton level2;
  LevelButton level3;
  LevelButton level4;
  LevelButton[] buttons;

  //Sound and Music Buttons
  int soundButtonX = 1220;
  int soundButtonY = 580;
  int musicButtonX = 1220;
  int musicButtonY = 660;
  int musicButtonSize = 70;
  int r;
  boolean music = true;
  PImage noteImg;
  int noteOffset = 30;
  boolean sound = true;
  PImage speakerImg;
  int speakerOffset = 40;

  //Error Messages
  boolean showErrorMessage = false;
  String errorMessage;
  int startErrorMessage;
  
  SelectScreen() {
    
  background = loadImage("background3.jpg");
  //Instaciate Level Buttons
  level1 = new LevelButton(width/2 - buttonSize - 10, height/2 - buttonSize -10, buttonSize, color(0), color(50), true, "1");
  level2 = new LevelButton(width/2 + 10, height/2 - buttonSize -10, buttonSize, color(0), color(50), false, "2");
  level3 = new LevelButton(width/2 - buttonSize -10, height/2 + 10, buttonSize, color(0), color(50), false, "3");
  level4 = new LevelButton(width/2 + 10, height/2 + 10, buttonSize, color(0), color(50), false, "4");

  buttons = new LevelButton[]{level1, level2, level3, level4};
  
  currentColor = baseColor;
  
  //Load Sound Icons
  noteImg = loadImage("Note.png");
  speakerImg = loadImage("Speaker.png");

  r = musicButtonSize/2;
}

void screenDraw() {
  background(color(#DCFAF7));
  background.resize(1280, 780);
  image(background, 0, 0);
  strokeWeight(2);
  
  //User Instruction
  fill(0);
  textSize(50);
  text("Click on a level to play", 410, 60);
  
  //Buttons for each level
  level1.drawButton();
  level2.drawButton();
  level3.drawButton();
  level4.drawButton();

  //Button to turn music on/off
  drawCircleButton(musicButtonX, musicButtonY, musicButtonSize, noteImg, noteOffset, music);
  
  //Button to turn sound on/off
  drawCircleButton(soundButtonX, soundButtonY, musicButtonSize, speakerImg, speakerOffset, sound);
  
  //Display Error Message if error true
  if (showErrorMessage) {
    if (frameCount - startErrorMessage < 200)
    {
      showErrorMessage(errorMessage);
    } else
    {
      showErrorMessage = false;
    }
  }
  
  //Display Unavailable Level Message on Hover
  for (LevelButton button : buttons)
  {
    if (mouseOverLevel(button) && !button.buttonFree && !showErrorMessage)
    {
      fill(0);
      textSize(30);
      text("Level " + button.levelName + " is not Available yet", 470, 680);
    }
  }
}

void screenMousePressed() {
  //Turn music on/off
  if (overCircle(musicButtonX, musicButtonY, musicButtonSize))
  {
    music = !music;
  } 
  //turn sound on/off
  else if (overCircle(soundButtonX, soundButtonY, musicButtonSize))
  {
   sound = !sound;
  } 
  //Start level or show error
  else {
    for (LevelButton button : buttons)
    {
      if (mouseOverLevel(button))
      {
        levelOrError(button);
      }
    }
  }
}

boolean mouseOverLevel(LevelButton button)
{
  return button.overRect(button.rectX, button.rectY, button.rectSize, button.rectSize);
}

void levelOrError(LevelButton button) //opens the level or shows error
{
  if (button.buttonFree)
  {
    shown = false;
  } else
  {
    //prepare error
    int levelOfButton = Integer.parseInt(button.levelName);
    int levelBefore = levelOfButton-1;
    errorMessage = "Finish Level "+ levelBefore + " Before Playing Level "+levelOfButton;
    startErrorMessage = frameCount;
    showErrorMessage = true;
  }
}

void showErrorMessage(String message)
{
  fill(0);
  textSize(30);
  text(message, 425, 680);
}
}
