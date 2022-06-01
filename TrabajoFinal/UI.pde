class SelectScreen {
  //General
  color baseColor = color(#DCFAF7);
  color currentColor;
  boolean shown = true;
  PImage title; 
  PImage background;

  //Level Buttons
  int buttonSize = 250;
  LevelButton level1Button;
  LevelButton level2Button;
  LevelButton level3Button;
  LevelButton level4Button;
  LevelButton[] buttons;

  //Sound and Music Buttons
  int soundButtonX = 50;
  int soundButtonY = 660;
  int musicButtonX = 120;
  int musicButtonY = 660;
  int musicButtonSize = 50;
  int r;
  boolean music = true;
  boolean changeMusic = false;
  PImage noteImg;
  int noteOffset = 20;
  boolean sound = true;
  boolean changeSound = false;
  PImage speakerImg;
  int speakerOffset = 25;

  //Error Messages
  boolean showErrorMessage = false;
  String errorMessage;
  int startErrorMessage;
  String level1string;
  String level2string;

  SelectScreen() {

    //Instaciate Level Buttons
    
    loadButtons();

    currentColor = baseColor;

    //Load Sound Icons
    noteImg = loadImage("Note.png");
    speakerImg = loadImage("Speaker.png");

    //Load layout images
    title = loadImage("title.png");
    background = loadImage("background.jpg");

    r = musicButtonSize/2;
  }
  
  void loadButtons() {
    level1Button = new LevelButton(width/2 - 2*buttonSize - 45, height/2 - 100, buttonSize, color(0), color(50), unlocked[0], "1", level1);
    level2Button = new LevelButton(width/2 - buttonSize - 15, height/2 - 50, buttonSize, color(0), color(50), unlocked[1], "2", level2);
    level3Button = new LevelButton(width/2 +15, height/2, buttonSize, color(0), color(50), unlocked[2], "3", level3);
    level4Button = new LevelButton(width/2 + buttonSize + 45, height/2 +50, buttonSize, color(0), color(50), unlocked[3], "4", level4);
    
    buttons = new LevelButton[]{level1Button, level2Button, level3Button, level4Button};
  }

  void screenDraw() {
    background(color(240));
    strokeWeight(2);

    background.resize(1360, 780);
    image(background, 0, 0);

    title.resize(1200, 100);
    image(title, 40, 50);
    //User Instruction
    fill(240);
    textSize(32);
    text("Choose a Level to Start", 320, 220);

    //Buttons for each level
    level1Button.drawButton();
    level2Button.drawButton();
    level3Button.drawButton();
    level4Button.drawButton();

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
        fill(200);
        textFont(numberFont);
        textSize(40);
        text(button.levelName, 450, 700);
        textFont(letterFont);
        textSize(30);
        text("Level    is not Available yet", 300, 700);
      }
    }
  }

  void screenMousePressed() {
    //Turn music on/off
    if (overCircle(musicButtonX, musicButtonY, musicButtonSize))
    {
      music = !music;
      changeMusic = true;
    } 
    //turn sound on/off
    else if (overCircle(soundButtonX, soundButtonY, musicButtonSize))
    {
      sound = !sound;
      changeSound = true;
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
    return button.overButton(button.rectX, button.rectY, button.rectSize);
  }

  void levelOrError(LevelButton button) //opens the level or shows error
  {
    if (button.buttonFree)
    {
      button.level.init();
      currentScene = button.level;
      shown = false;
    } else
    {
      //prepare error
      int levelOfButton = Integer.parseInt(button.levelName);
      int levelBefore = levelOfButton-1;
      level1string = button.levelName;
      level2string = Integer.toString(levelBefore);
      errorMessage = "Finish Level    Before Playing Level   ";
      startErrorMessage = frameCount;
      showErrorMessage = true;
    }
  }

  void showErrorMessage(String message)
  {
    fill(200);
    textFont(numberFont);
      textSize(40);
      text(level2string, 500, 700);
      text(level1string, 1070, 700);
      textFont(letterFont);
      textSize(30);
    text(message, 190, 700);
  }
}
