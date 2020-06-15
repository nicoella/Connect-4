//Variable Declaration Section
//Images
PImage title; //image of the title
PImage tokenRed; //image of the red token
PImage tokenYellow; //image of the yellow token
PImage bg; //store the background image
PImage confetti; //store the confetti image 
//Fonts
PFont font1; //font variable
//State
String state = "title"; //store the current game state
//Grid
int[][] grid = new int[6][7]; //dynamically store the values in the game grid
//Player Information
String p1 = ""; //store the username of player 1
String p2 = ""; //store the username of player 2
int curPlayer = 1; //store which is the current player: can be 1 or 2
String gamemode = "mouse"; //store which is the current game mode: can be "mouse" or "keyboard"
int winner = 0; //store which player is the winner: can be 0, 1, or 2
//Coordinates and Display Variables
float y = 0; //used for y-translations
float x = 0; //used for x-translations
int transparency = 0; //used for transparency animations
boolean fadeIn = true; //used to fade in and fade out repetitively
boolean expand = true; //used to expand and shrink repetitively
float size = 0; //used to increase and decrease size of objects/text/images
int column = 0; //used to check which column(1-7) the token is in
int delay = 0; //used to create animation delays
int tokenX=188; //used to store the token's x-coordinate
boolean jumpUp=true; //used to move up and down something repetitively

void setup() {
  size(700, 500);
  font1 = loadFont("BOLD-100.vlw");
  title = loadImage("title.PNG");
  tokenRed = loadImage("redToken.PNG");
  tokenYellow = loadImage("yellowToken.PNG");
  bg = loadImage("bg.PNG");
  confetti = loadImage("confetti.png");
}

void draw() {
  if (state.equals("title")) { //if the state is title
    title();
  } else if (state.equals("intro")) { //if the state is intro
    intro();
  } else if (state.equals("mainMenu")||state.equals("mainMenuFirst")||state.equals("mainMenuDelay")) { //if the state is mainMenu, mainMenuFirst, or mainMenuDelay
    mainMenu();
  } else if (state.equals("game")||state.equals("tokenFall")||state.equals("winScreenDelay")) { //if state is game, tokenFall, or winScreenDelay
    game();
  } else if (state.equals("instructions")||state.equals("instructionsNext")||state.equals("move1")||state.equals("move2")||state.equals("move3")||state.equals("move4")||state.equals("move5")||state.equals("move6")||state.equals("move7")||state.equals("move8")||state.equals("move9")||state.equals("move10")||state.equals("move11")||state.equals("move12")||state.equals("move13")||state.equals("move14")||state.equals("move15")||state.equals("redWin")||state.equals("instructionsFade")||state.equals("redWinNext")) { //if state is instructions, instructionsNext, moves1-15 (animation), instructionsFade, or redWinNext
    instructions();
  } else if (state.equals("exit")) { //if state is exit
    goodbye();
  } else if (state.equals("winScreen")) { //if state is winScreen
    winScreen();
  } else if (state.equals("pause")||state.equals("warning")) { //if state is pause or state is warning
    pause();
  } else if (state.equals("userSettings")||state.equals("popUp")||state.equals("popUpError1")||state.equals("popUpError2")||state.equals("p2Equal")) { //if state is userSettings, popUpError1, popUpError2, or p2Equal
    userSettings();
  }
}

//Program Title
void title() {
  background(#CBF59E);
  if (transparency<=180) { //if transparency is less than 180, increase transparency by 5
    tint(255, transparency);
    transparency+=5;
  } else { 
    tint(255, 180);
  }
  image(bg, 65, 125, width*0.85, height); //background drawing
  image(title, 0-size/2, y-400-size/2, width+size, height+size); //game title
  if (y<370) //if y-value is less than 370, increase y by 5
    y+=5;
  else { //else if y-value is not less than 370
    if (expand==true) { //expand and shrink title image repetitively
      size+=1;
    } else if (expand==false) {
      size-=1;
    } 
    if (size==20) {
      expand=false;
    } else if (size==0) {
      expand=true;
    }
    if (transparency>440) { //fade in and fade out the begin game button repetitively
      fadeIn=false;
    } else if (transparency<255) {
      fadeIn=true;
    }
    if (fadeIn) {
      transparency+=5;
    } else {
      transparency-=5;
    }
    //Begin Game button
    textAlign(CENTER); 
    textFont(font1);
    textSize(30);
    rectMode(CENTER);
    strokeWeight(2.5);
    stroke(30, transparency-185);
    fill(#E52C45, transparency-185);
    rect(350, 214, 100, 40, 22);
    fill(255, transparency-185);
    textAlign(CENTER);
    textSize(25);
    text("Begin Game", 352, 220);
    noStroke();
    strokeWeight(1);
    if (mousePressed&&mouseX>=300&&mouseX<=400&&mouseY>=194&&mouseY<=224) { //if mouse pressed on button, reset transparency, set state to intro
      state="intro";
      transparency=0;
    }
  }
}

//Program Introduction
void intro() {
  background(#CBF59E);
  image(title, 0-size/2, y-400-size/2, width+size, height+size); //game title
  if (expand==true) { //expand and shrink title image repetitively
    size+=1;
  } else if (expand==false) {
    size-=1;
  } 
  if (size==20) {
    expand=false;
  } else if (size==0) {
    expand=true;
  }
  if (y>=335) //if y is more than or equal to 335, decrease y by 2
    y-=2;
  else y=334; //else set y to 334
  String displayText = "Welcome to Connect 4!\nTry playing this traditional\ntwo-player game. In this\ngame, you consecutively place\nyour game pieces in one of the\ncolumns on the game board, until one \nplayer gets four of their game\npieces in a row!"; //display message
  //display display message
  textFont(font1); 
  textAlign(CENTER);
  fill(20, transparency);
  stroke(20, transparency);
  textSize(35);
  text(displayText, 350, 190);
  //press any key or click to continue message
  textSize(30);
  text("PRESS ANY KEY OR CLICK TO CONTINUE.", 350, 450);
  line(155, 430, 155, 450); //lines to draw [ and ] brackets
  line(155, 450, 160, 450);
  line(155, 430, 160, 430);
  line(545, 430, 545, 450);
  line(545, 450, 540, 450);
  line(545, 430, 540, 430);
  if (transparency<255) //if transparency is less than 255, increase transparency
    transparency+=4;
}

//Program Main Menu
void mainMenu() {
  if (state.equals("mainMenuFirst")) { //if state is mainMenuFirst (only used when first running main menu - fading in from intro)
    intro(); //call intro in the background
  } else { 
    //game title
    background(#CBF59E);
    tint(255, 255-transparency);
    image(title, 0-size/2, -66-size/2, width+size, height+size);
    if (expand==true) { //expand and shrink title image repetitively
      size+=1;
    } else if (expand==false) {
      size-=1;
    } 
    if (size==20) {
      expand=false;
    } else if (size==0) {
      expand=true;
    }
  }
  if (transparency>0) //if transparency is more than 0, decrease by 30
    transparency-=30;
  //buttons
  rectMode(CENTER);
  textSize(30);
  fill(20, 255-transparency);
  stroke(20, 255-transparency);
  rect(350, 220, 150, 60, 15); //begin game button
  rect(350, 300, 150, 60, 15); //how to play button
  rect(350, 380, 150, 60, 15); //exit game button
  textSize(30);
  fill(255, 255-transparency);
  text("Begin Game\n(Two Players)", 350, 215); //begin game button
  text("How to Play", 350, 310); //how to play button
  text("Exit Game", 350, 385); //exit game button
  stroke(255);
  if (mouseY>=190&&mouseY<=250&&mouseX>=275&&mouseX<=425) { //if mouse is on begin game button, change button colours to white
    fill(255, 255-transparency);
    stroke(255, 255-transparency);
    rect(350, 220, 150, 60, 15);
    fill(20, 255-transparency);
    text("Begin Game\n(Two Players)", 350, 215);
  } else if (mouseY>=270&&mouseY<=330&&mouseX>=275&&mouseX<=425) { //if mouse is on exit game button, change button colours to white
    fill(255, 255-transparency);
    rect(350, 300, 150, 60, 15);
    fill(20, 255-transparency);
    text("How to Play", 350, 310);
  } else if (mouseY>=350&&mouseY<=410&&mouseX>=275&&mouseX<=425) { //if mouse is on begin game button, change button colours to white
    fill(255, 255-transparency);
    rect(350, 380, 150, 60, 15);
    fill(20, 255-transparency);
    text("Exit Game", 350, 385);
  }
  stroke(0);
}

void mouseReleased() {
  if (state.equals("game")&&!p1.equals("")&&!p2.equals("")&&delay>15&&mouseX<=539&&mouseX>=150) {
    state="tokenFall";
  } else if (state.equals("mainMenu")||state.equals("mainMenuFirst")) {
    if (mouseX>=275&&mouseX<=425) {
      if (mouseY>=190&&mouseY<=250) {
        state="game";
        delay=0;
      } else if (mouseY>=270&&mouseY<=330) {
        y=0;
        x=0;
        state="instructions";
      } else if (mouseY>=350&&mouseY<=410) {
        state="exit";
      }
    }
  } else if (state.equals("pause")) {
    if (mouseX>=207.5&&mouseX<=312.5&&mouseY>=255&&mouseY<=295) {
      gamemode="mouse";
    } else if (mouseX>=387.5&&mouseX<=490.5&&mouseY>=255&&mouseY<=295) {
      gamemode="keyboard";
    }
    if (mouseX>=207.5&&mouseX<=312.5&&mouseY>=345&&mouseY<=405) {
      delay=0;
      state="warning";
    } else if (mouseX>=387.5&&mouseX<=490.5&&mouseY>=345&&mouseY<=405) {
      delay=0;
      state="game";
    }
  } else if (state.equals("warning")) {
    if (mouseX>=207.5&&mouseX<=312.5&&mouseY>=345&&mouseY<=405) {
      delay=0;
      state="mainMenu";
    } else if (mouseX>=387.5&&mouseX<=492.5&&mouseY>=345&&mouseY<=405) {
      gameClear();
      delay=0;
      state="mainMenu";
    }
  } else if (state.equals("winScreen")) {
    if (mouseX>=305&&mouseX<=395&&mouseY>=277.5&&mouseY<=302.5) {
      gameClear();
      state="mainMenu";
    }
  } else if (state.equals("instructions")) {
    state="instructionsNext";
  } else if (state.equals("intro")&&transparency>200) {
    state="mainMenu";
  }
}

void game() { 
  if (p1.equals("")||p2.equals("")&&delay>5) {
    state = "userSettings";
  } else {
    delay++;
  }
  if (y<-100)
    y-=4;
  stroke(0);
  background(#CBF59E);
  fill(#4E35E3);
  rectMode(CORNER);
  rect(140, 425, 30, 60);
  rect(530, 425, 30, 60);
  rect(150, 129, 400, 346);
  fill(#ED94C5);
  rect(669, 14, 20, 20);
  fill(255);
  rect(673, 18, 5, 10);
  rect(681, 18, 5, 10);
  if (mousePressed&&state.equals("game")) {
    if (mouseX>=669&&mouseX<=689&&mouseY>=14&&mouseY<=34&&!state.equals("userSettings")) {
      state="pause";
    }
  }
  if (state.equals("game")) {
    if (gamemode.equals("mouse")) {
      tokenX = mouseX;
    }
  }
  if (curPlayer==1) {
    fill(#F2350F);
  } else if (curPlayer==2) {
    fill(#EDCE1D);
  }
  if (!state.equals("winScreen")) {
    if (tokenX>539) tokenX = 539;
    if (tokenX<150) tokenX = 150;
    if (tokenX>=150&&tokenX<=215) {
      tokenX=188;
      column=0;
    } else if (tokenX>215&&tokenX<=269) {
      tokenX=242;
      column=1;
    } else if (tokenX>269&&tokenX<=323) {
      tokenX=296;
      column=2;
    } else if (tokenX>323&&tokenX<=377) {
      tokenX=350;
      column=3;
    } else if (tokenX>377&&tokenX<=431) {
      tokenX=404;
      column=4;
    } else if (tokenX>431&&tokenX<=485) {
      tokenX=458;
      column=5;
    } else if (tokenX>485&&tokenX<=539) {
      tokenX=512;
      column=6;
    }
  }

  ellipse(tokenX, 100, 38, 38);
  for (int i=0; i<7; i++) {
    for (int j=0; j<6; j++) {
      fill(#9D8DFA);
      ellipse(150+11+i*54+54/2, 129+11+j*54+54/2, 44, 44);
      if (grid[j][i]==0) {
        fill(#CBF59E);
      } else if (grid[j][i]==1) {
        fill(#F2350F);
      } else if (grid[j][i]==2) {
        fill(#EDCE1D);
      }
      ellipse(150+11+i*54+54/2, 129+11+j*54+54/2, 38, 38);
    }
  }

  if (!p1.equals("")&&!p2.equals("")) {
    fill(20);
    textAlign(CENTER);
    text(p1, 90, 80);
    text(p2, 610, 80);
    if (curPlayer==1)
      text("Current Player: "+p1, 350, 50);
    else
      text("Current Player: "+p2, 350, 50);
    float enlarge = 0;
    if (delay%30<=14&&state.equals("game")) {
      enlarge = 15;
    }
    if (curPlayer==1) {
      image(tokenRed, 0-enlarge/2, 60-enlarge*0.75/2, width/4+enlarge, height/3+enlarge*0.75);
      image(tokenYellow, 530, 60, width/4, height/3);
    } else if (curPlayer==2) {
      image(tokenRed, 0, 60, width/4, height/3);
      image(tokenYellow, 530-enlarge/2, 60-enlarge*0.75/2, width/4+enlarge, height/3+enlarge*0.75);
    }
  }
  if (state.equals("tokenFall")) {
    for (int j=5; j>=0; j--) {
      if (grid[j][column]==0) {
        if (j!=0||grid[0][column]==0) {
          grid[j][column]=curPlayer;
          checkFour();
          if (winner!=0) {
            state="winScreenDelay";
            y=-700;
          } else {
            if (curPlayer==1) curPlayer=2;
            else if (curPlayer==2) curPlayer=1;
          }
        } 
        break;
      }
    }
    if (winner==0)
      state="game";
  }
  if (state.equals("winScreenDelay")||state.equals("winScreen")) {
    checkFour();
    if (delay<200) {
      delay++;
    } else {
      state="winScreen";
    }
  }
}

void userSettings() {
  game();
  if (transparency<=510)
    transparency+=80;
  stroke(0, transparency-255);
  fill(255, transparency-325);
  rect(130, 150, 440, 300);
  fill(0, transparency-255);
  textAlign(CENTER);
  text("Please enter the usernames of\nplayer 1 and 2.\n\n\nPRESS ANY KEY TO OR CLICK\nTO ENTER POP-UP MENU", 350, 240);
  line(205, 325, 205, 365);
  line(205, 365, 210, 365);
  line(205, 325, 210, 325);
  line(505, 325, 505, 365);
  line(500, 365, 505, 365);
  line(500, 325, 505, 325);
  if ((keyPressed||mousePressed)&&state.equals("userSettings")) {
    state="popUp";
  }
  if (state.equals("popUp")) {
    p1 = getString("Player 1: Username");
    if (p1.length()<3||p1.length()>13) {
      state="popUpError1";
    } else {
      p2 = getString("Player 2: Username");
      if (p2.length()<3||p2.length()>13)
        state="popUpError2";
      if (p2.equals(p1))
        state="p2Equal";
      else state="game";
    }
  }
  while (state.equals("popUpError1")) {
    p1 = getString("Usernames must be longer than 3\ncharacters and less than 13!\nPlease try again.\nPlayer 1: Username");
    if (p1.length()>=3&&p1.length()<13) {
      p2 = getString("Player 2: Username");
      if (p2.length()<=3||p2.length()>13)
        state="popUpError2";
      else {
        if (p2.equals(p1))
          state="p2Equal";
        else state="game";
      }
    }
  }
  while (state.equals("popUpError2")) {
    p2 = getString("Usernames must be longer than 3\ncharacters and less than 13!\nPlease try again.\nPlayer 2: Username");
    if (p2.length()>=3&&p2.length()<13) {
      if (p2.equals(p1))
        state="p2Equal";
      else state="game";
    }
  }
  while (state.equals("p2Equal")) {
    p2=getString("Usernames cannot be the same.\nPlease try again.\nPlayer 2: Username");
    if (p2.length()>=3&&p2.length()<13) {
      if (!p2.equals(p1)) 
        state="game";
    } else {
      state="popUpError2";
    }
  }
}

void checkFour() {
  //check horizontal
  for (int i=0; i<=3; i++) {
    for (int j=0; j<6; j++) {
      if (grid[j][i]==grid[j][i+1]&&grid[j][i+1]==grid[j][i+2]&&grid[j][i+2]==grid[j][i+3]) {
        if (grid[j][i]!=0) {
          winner=grid[j][i];
          noFill();
          strokeWeight(2);
          stroke(255);
          ellipse(150+11+i*54+54/2, 129+11+j*54+54/2, 44, 44);
          ellipse(150+11+(i+1)*54+54/2, 129+11+j*54+54/2, 44, 44);
          ellipse(150+11+(i+2)*54+54/2, 129+11+j*54+54/2, 44, 44);
          ellipse(150+11+(i+3)*54+54/2, 129+11+j*54+54/2, 44, 44);
          strokeWeight(1);
          stroke(0);
          noStroke();
        }
      }
    }
  }
  //check vertical
  for (int i=0; i<7; i++) {
    for (int j=0; j<=2; j++) {
      if (grid[j][i]==grid[j+1][i]&&grid[j+1][i]==grid[j+2][i]&&grid[j+2][i]==grid[j+3][i]) {
        if (grid[j][i]!=0) {
          winner=grid[j][i];
          noFill();
          strokeWeight(2);
          stroke(255);
          ellipse(150+11+i*54+54/2, 129+11+j*54+54/2, 44, 44);
          ellipse(150+11+i*54+54/2, 129+11+(j+1)*54+54/2, 44, 44);
          ellipse(150+11+i*54+54/2, 129+11+(j+2)*54+54/2, 44, 44);
          ellipse(150+11+i*54+54/2, 129+11+(j+3)*54+54/2, 44, 44);
          strokeWeight(1);
          stroke(0);
          noStroke();
        }
      }
    }
  }
  //check diagonal to right
  for (int i=0; i<4; i++) {
    for (int j=0; j<3; j++) {
      if (grid[j][i]==grid[j+1][i+1]&&grid[j+1][i+1]==grid[j+2][i+2]&&grid[j+2][i+2]==grid[j+3][i+3]) {
        if (grid[j][i]!=0) {
          winner=grid[j][i];
          winner=grid[j][i];
          noFill();
          strokeWeight(2);
          stroke(255);
          ellipse(150+11+i*54+54/2, 129+11+j*54+54/2, 44, 44);
          ellipse(150+11+(i+1)*54+54/2, 129+11+(j+1)*54+54/2, 44, 44);
          ellipse(150+11+(i+2)*54+54/2, 129+11+(j+2)*54+54/2, 44, 44);
          ellipse(150+11+(i+3)*54+54/2, 129+11+(j+3)*54+54/2, 44, 44);
          strokeWeight(1);
          stroke(0);
          noStroke();
        }
      }
    }
  }
  //check diagonal to left
  for (int i=3; i<7; i++) {
    for (int j=0; j<3; j++) {
      if (grid[j][i]==grid[j+1][i-1]&&grid[j+1][i-1]==grid[j+2][i-2]&&grid[j+2][i-2]==grid[j+3][i-3]) {
        if (grid[j][i]!=0) {
          winner=grid[j][i];
          noFill();
          strokeWeight(2);
          stroke(255);
          ellipse(150+11+i*54+54/2, 129+11+j*54+54/2, 44, 44);
          ellipse(150+11+(i-1)*54+54/2, 129+11+(j+1)*54+54/2, 44, 44);
          ellipse(150+11+(i-2)*54+54/2, 129+11+(j+2)*54+54/2, 44, 44);
          ellipse(150+11+(i-3)*54+54/2, 129+11+(j+3)*54+54/2, 44, 44);
          strokeWeight(1);
          stroke(0);
          noStroke();
        }
      }
    }
  }
}

void pause() {
  textSize(30);
  game();
  //box
  fill(255, 180);
  rect(130, 150, 440, 300, 5);
  if (state.equals("pause")) {
    //title
    textAlign(CENTER);
    textSize(40);
    fill(#E52C45);
    text("Game Paused", 348, 202);
    fill(0);
    text("Game Paused", 350, 200);
    //gamemode options
    rectMode(CENTER);
    textSize(30);
    if (mouseX>=207.5&&mouseX<=312.5&&mouseY>=255&&mouseY<=295) {
      fill(255, 100);
      rect(260, 275, 105, 40, 10);
      fill(20, 100);
      rect(440, 275, 105, 40, 10);
      fill(20);
      text("Mouse", 260, 283);
      fill(255);
      text("Keyboard", 440, 283);
    } else if (mouseX>=387.5&&mouseX<=492.5&&mouseY>=255&&mouseY<=295) {
      fill(255, 100);
      rect(440, 275, 105, 40, 10);
      fill(20, 100);
      rect(260, 275, 105, 40, 10);
      fill(20);
      text("Keyboard", 440, 283);
      fill(255);
      text("Mouse", 260, 283);
    } else {
      fill(20, 100);
      rect(260, 275, 105, 40, 10);
      rect(440, 275, 105, 40, 10);
      fill(255);
      text("Mouse", 260, 283);
      text("Keyboard", 440, 283);
    }
    noFill();
    strokeWeight(4);
    stroke(#C13131);
    if (gamemode.equals("mouse")) {
      rect(260, 275, 108, 43, 10);
    } else if (gamemode.equals("keyboard")) {
      rect(440, 275, 108, 43, 10);
    }
    strokeWeight(1);
    stroke(0);
    if (mouseY>=345&&mouseY<=405&&mouseX>=207.5&&mouseX<=312.5) {
      fill(255, 100);
      rect(260, 375, 105, 60, 10);
      fill(#BC3124, 100);
      rect(440, 375, 105, 60, 10);
      fill(#BC3124);
      text("Main Menu", 260, 380);
      fill(255);
      text("Back to\nGame", 440, 368);
    } else if (mouseY>=345&&mouseY<=405&&mouseX>=387.5&&mouseX<=490.5) {
      fill(255, 100);
      rect(440, 375, 105, 60, 10);
      fill(#BC3124, 100);
      rect(260, 375, 105, 60, 10);
      fill(#BC3124);
      text("Back to\nGame", 440, 368);
      fill(255);
      text("Main Menu", 260, 380);
    } else {
      fill(#BC3124, 100);
      rect(260, 375, 105, 60, 10);
      rect(440, 375, 105, 60, 10);
      fill(255);
      text("Main Menu", 260, 380);
      text("Back to\nGame", 440, 368);
    }
    fill(40);
    text("Gamemode Options:", 350, 238);
    text("Game Options:", 350, 330);
  } else if (state.equals("warning")) {
    rectMode(CENTER);
    textAlign(CENTER);
    textSize(40);
    fill(#E52C45);
    text("Would You Like to Keep\nYour Game Progress?", 348, 222);
    fill(0);
    text("Would You Like to Keep\nYour Game Progress?", 350, 220);
    if (mouseX>=207.5&&mouseX<=312.5&&mouseY>=345&&mouseY<=405) {
      fill(255, 100);
      rect(260, 375, 105, 60, 10);
      fill(#BC3124, 100);
      rect(440, 375, 105, 60, 10);
      fill(#BC3124);
      text("Yes", 260, 380);
      fill(255);
      text("No", 440, 380);
    } else if (mouseX>=387.5&&mouseX<=492.5&&mouseY>=345&&mouseY<=405) {
      fill(255, 100);
      rect(440, 375, 105, 60, 10);
      fill(#BC3124, 100);
      rect(260, 375, 105, 60, 10);
      fill(#BC3124);
      text("No", 440, 380);
      fill(255);
      text("Yes", 260, 380);
    } else {
      fill(#BC3124, 100);
      rect(260, 375, 105, 60, 10);
      rect(440, 375, 105, 60, 10);
      fill(255);
      text("Yes", 260, 380);
      text("No", 440, 380);
    }
  }
}

void winScreen() {
  curPlayer=1;
  game();
  rectMode(CORNER);
  if (y<0) {
    noStroke();
    fill(#CBF59E);
    rect(0, 0+y, 148, 200);
    rect(552, 0+y, 148, 220);
    rect(0, 0+y, 750, 127);
    stroke(1);
    y+=9;
    fill(255, 180);
    rect(130, 150+y, 440, 300, 5);
  } else if (y>=0) {
    noStroke();
    fill(#CBF59E);
    rect(0, 0, 148, 200);
    rect(552, 0, 148, 220);
    rect(0, 0, 750, 127);
    stroke(1);
    fill(255, 180);
    rect(130, 150, 440, 300, 5);
    textAlign(CENTER);
    textFont(font1);
    textSize(40);
    fill(#74D8B3);
    if (y<290)
      text("G", 245, y-85);
    else
      text("G", 245, 205);
    if (y<310)
      text("A", 270, y-105);
    else
      text("A", 270, 205);
    if (y<330)
      text("M", 300, y-125);
    else
      text("M", 300, 205);
    if (y<350)
      text("E ", 335, y-145);
    else
      text("E ", 335, 205);
    if (y<370)
      text("O", 365, y-165);
    else
      text("O", 365, 205);
    if (y<390)
      text("V", 385, y-185);
    else
      text("V", 385, 205);
    if (y<410)
      text("E", 405, y-205);
    else
      text("E", 405, 205);
    if (y<430)
      text("R", 425, y-225);
    else
      text("R", 425, 205);
    if (y<450)
      text("!", 445, y-245);
    else
      text("!", 445, 205);

    fill(0);
    if (y<290)
      text("G", 250, y-90);
    else
      text("G", 250, 200);
    if (y<310)
      text("A", 275, y-110);
    else
      text("A", 275, 200);
    if (y<330)
      text("M", 305, y-130);
    else
      text("M", 305, 200);
    if (y<350)
      text("E ", 340, y-150);
    else
      text("E ", 340, 200);
    if (y<370)
      text("O", 370, y-170);
    else
      text("O", 370, 200);
    if (y<390)
      text("V", 390, y-190);
    else
      text("V", 390, 200);
    if (y<410)
      text("E", 410, y-210);
    else
      text("E", 410, 200);
    if (y<430)
      text("R", 430, y-230);
    else
      text("R", 430, 200);
    if (y<450)
      text("!", 450, y-245);
    else
      text("!", 450, 200);
    if (y<500) {
      image(tokenRed, 180, y-200, width/4, height/3);
      image(tokenYellow, 350, y-200, width/4, height/3);
      tokenX=0;
    } else {
      if (tokenX<-30)
        jumpUp=false;
      else if (tokenX>0)
        jumpUp=true;
      if (jumpUp)
        tokenX-=2;
      else
        tokenX+=2; 
      if (winner==1) {
        image(tokenRed, 180, 295+tokenX, width/4, height/3);
        image(tokenYellow, 350, 295, width/4, height/3);
      } else if (winner==2) {
        image(tokenRed, 180, 295, width/4, height/3);
        image(tokenYellow, 350, 295+tokenX, width/4, height/3);
      }
    }
    if (y<500&&delay%3==0)
      y+=10;
    if (y>=430) {
      textSize(35);
      if (transparency<255)
        transparency+=3;
      tint(255, transparency);
      if (winner==1) {
        fill(#F0DF5C, transparency);
        text("Winner is: "+p1+"!", 346, 254);
        fill(255, transparency);
        text("Winner is: "+p1+"!", 350, 250);
        fill(#F0635C, transparency);
        text("Winner is: "+p1+"!", 352, 248);
        image(confetti, 190, 290, width/4, height/4);
      } else if (winner==2) {
        fill(#F0DF5C, transparency);
        text("Winner is: "+p2+"!", 346, 254);
        fill(255, transparency);
        text("Winner is: "+p2+"!", 350, 250);
        fill(#F0635C, transparency);
        text("Winner is: "+p2+"!", 352, 248);
        image(confetti, 360, 290, width/4, height/4);
      }
      rectMode(CENTER);
      textAlign(CENTER);
      textSize(25);
      stroke(0, transparency);
      if (mouseX>=305&&mouseX<=395&&mouseY>=277.5&&mouseY<=302.5) {
        fill(20, transparency-75);
        rect(350, 290, 90, 25, 20);
        fill(#B1EDD6);
        text("Main Menu", 350, 295);
      } else {
        fill(#B1EDD6, transparency-75);
        rect(350, 290, 90, 25, 20);
        fill(20, transparency);
        text("Main Menu", 350, 295);
      }
      stroke(0);
      tint(255);
    } else {
      transparency=0;
    }
  }
  textSize(35);
}

void instructions() {
  if (state.equals("instructions")) {
    if (transparency<255)
      transparency+=8;
    noStroke();
    fill(#CBF59E, transparency);
    rect(0, 0, 750, 500);
    strokeWeight(1);
    stroke(0, transparency);
    textAlign(CENTER);
    textSize(40);
    fill(20, transparency);
    text("How To Play", 350, 35);
    textSize(27);
    text("Press ENTER or CLICK to Continue.", 350, 60);
    rectMode(CORNER);
    fill(#4E35E3, transparency);
    rect(140, 425, 30, 60);
    rect(530, 425, 30, 60);
    rect(150, 129, 400, 346);
    rectMode(CENTER);
    for (int i=0; i<7; i++) {
      noStroke();
      fill(#81DCED, transparency);
      rect(188+i*54, 100, 30, 24);
      triangle(188+i*54-20, 110, 188+i*54+20, 110, 188+i*54, 125);
      strokeWeight(1);
      stroke(0, transparency);
      for (int j=0; j<6; j++) {
        fill(#9D8DFA, transparency);
        ellipse(150+11+i*54+54/2, 129+11+j*54+54/2, 44, 44);
        fill(#CBF59E, transparency);
        ellipse(150+11+i*54+54/2, 129+11+j*54+54/2, 38, 38);
      }
    }
    fill(#F2350F, transparency);
    ellipse(188, 60, 38, 38);
    textSize(25);
    fill(45, transparency);
    textLeading(25);
    text("Move your\nmouse or use\nkeyboard LEFT\nand RIGHT keys\nto choose one of\nthe 7 columns to\nplace your token\nin. Click your\nmouse or press\nENTER to drop\nthe token to the\nbottom of the\ncolumn.", 75, 120);
    text("You can choose\nwhich game\nmode you would\nlike to play in\n(keyboard/mouse)\nin the pause\nmenu (top right\ncorner). The\ndefault game\nmode is mouse.", 629, 120);
    rectMode(CORNER);
    fill(#ED94C5, transparency);
    rect(669, 14, 20, 20);
    fill(255, transparency);
    rect(673, 18, 5, 10);
    rect(681, 18, 5, 10);
    noFill();
    strokeWeight(3);
    stroke(#FF1A1A, transparency);
    ellipse(679, 24, 37, 37);
    strokeWeight(1);
    stroke(0, transparency);
    fill(#FF1A1A, transparency);
    quad(668, 65, 658, 65, 653, 98, 662, 100);
    triangle(668, 45, 674, 70, 652, 65);
  } else if (state.equals("instructionsNext")) {
    if (y<35) {
      y+=2;
    } else if (y==36&&transparency<=0) {
      state="move1";
    }
    if (transparency>0)
      transparency-=4;
    noStroke();
    fill(#CBF59E, 255-transparency);
    rectMode(CENTER);
    rect(75, 250, 130, 450);
    rect(630, 250, 140, 500);
    fill(#CBF59E);
    rect(350, 100, 750, 50);
    rect(188, 60, 40, 60);
    strokeWeight(1);
    fill(#F2350F);
    stroke(0);
    ellipse(188, 60+y, 38, 38);
    stroke(0, 255-transparency);
    fill(45, 255-transparency);
    textLeading(25);
    text("The goal of the\ngame is to get\nfour of your\ncolour game\npieces in a row.\nThe pieces can\nbe horizontal,\nvertical, or\ndiagonal. First to\nget four wins!", 75, 120);
    text("Here is a\nsmall example\nanimation of\nplayer 1 (red)\ngetting 4 in a\nrow.", 629, 120);
  } else if (!state.equals("instructionsFade")) {
    if (mousePressed||(keyPressed&&key==ENTER)) {
      transparency=255;
      state="instructionsFade";
    }
    if (curPlayer==1)
      fill(#F2350F);
    else if (curPlayer==2)
      fill(#EDCE1D);
    if (state.equals("move1")) {
      curPlayer=1;
      if (x<162) {
        x+=2;
      } else {
        ellipse(150+11+3*54+54/2, 129+11+5*54+54/2, 38, 38);
        curPlayer=2;
        state="move2";
      }
    } else if (state.equals("move2")) {
      if (x>108) {
        x-=0.5;
      } else {
        ellipse(150+11+2*54+54/2, 129+11+5*54+54/2, 38, 38);
        curPlayer=1;
        state="move3";
      }
    } else if (state.equals("move3")) {
      if (x<162) {
        x+=0.5;
      } else {
        ellipse(150+11+3*54+54/2, 129+11+4*54+54/2, 38, 38);
        curPlayer=2;
        state="move4";
      }
    } else if (state.equals("move4")) {
      if (x>108) {
        x-=0.5;
      } else {
        ellipse(150+11+2*54+54/2, 129+11+4*54+54/2, 38, 38);
        curPlayer=1;
        state="move5";
      }
    } else if (state.equals("move5")) {
      if (x<208) {
        x+=1.2;
      } else {
        ellipse(150+11+4*54+54/2, 129+11+5*54+54/2, 38, 38);
        curPlayer=2;
        state="move6";
      }
    } else if (state.equals("move6")) {
      if (x>162) {
        x-=0.5;
      } else {
        ellipse(150+11+3*54+54/2, 129+11+3*54+54/2, 38, 38);
        curPlayer=1;
        state="move7";
      }
    } else if (state.equals("move7")) {
      if (x>54) {
        x-=1.2;
      } else {
        ellipse(150+11+1*54+54/2, 129+11+5*54+54/2, 38, 38);
        curPlayer=2;
        state="move8";
      }
    } else if (state.equals("move8")) {
      if (x<208) {
        x+=1.5;
      } else {
        ellipse(150+11+4*54+54/2, 129+11+4*54+54/2, 38, 38);
        curPlayer=1;
        state="move9";
      }
    } else if (state.equals("move9")) {
      if (x>54) {
        x-=1.5;
      } else {
        ellipse(150+11+1*54+54/2, 129+11+4*54+54/2, 38, 38);
        curPlayer=2;
        state="move10";
      }
    } else if (state.equals("move10")) {
      if (x<208) {
        x+=1.5;
      } else {
        ellipse(150+11+4*54+54/2, 129+11+3*54+54/2, 38, 38);
        curPlayer=1;
        state="move11";
      }
    } else if (state.equals("move11")) {
      if (x>108) {
        x-=1.2;
      } else {
        ellipse(150+11+2*54+54/2, 129+11+3*54+54/2, 38, 38);
        curPlayer=2;
        state="move12";
      }
    } else if (state.equals("move12")) {
      if (x<208) {
        x+=1.2;
      } else {
        ellipse(150+11+4*54+54/2, 129+11+2*54+54/2, 38, 38);
        curPlayer=1;
        state="move13";
      }
    } else if (state.equals("move13")) {
      if (x<224) {
        x+=0.2;
      } else {
        ellipse(150+11+4*54+54/2, 129+11+1*54+54/2, 38, 38);
        curPlayer=2;
        state="move14";
      }
    } else if (state.equals("move14")) {
      if (x<272) {
        x+=0.35;
      } else {
        ellipse(150+11+5*54+54/2, 129+11+5*54+54/2, 38, 38);
        curPlayer=1;
        state="move15";
      }
    } else if (state.equals("move15")) {
      if (x>162) {
        x-=1.2;
      } else {
        ellipse(150+11+3*54+54/2, 129+11+2*54+54/2, 38, 38);
        state="redWin";
      }
    }
    x+=188;
    if (x>=150&&x<=215) {
      tokenX=188;
    } else if (x>215&&x<=269) {
      tokenX=242;
    } else if (x>269&&x<=323) {
      tokenX=296;
    } else if (x>323&&x<=377) {
      tokenX=350;
    } else if (x>377&&x<=431) {
      tokenX=404;
    } else if (x>431&&x<=485) {
      tokenX=458;
    } else if (x>485&&x<=539) {
      tokenX=512;
    }
    x-=188;
    tokenX-=188;
    noStroke();
    rectMode(CENTER);
    fill(#CBF59E);
    rect(350, 100, 420, 55);
    strokeWeight(1);
    stroke(0);
    if (curPlayer==1)
      fill(#F2350F);
    else if (curPlayer==2)
      fill(#EDCE1D);
    ellipse(188+tokenX, 94, 38, 38);
    if (state.equals("redWin")) {
      noFill();
      strokeWeight(2);
      stroke(255);
      ellipse(150+11+1*54+54/2, 129+11+4*54+54/2, 44, 44);
      ellipse(150+11+2*54+54/2, 129+11+3*54+54/2, 44, 44);
      ellipse(150+11+3*54+54/2, 129+11+2*54+54/2, 44, 44);
      ellipse(150+11+4*54+54/2, 129+11+1*54+54/2, 44, 44);
      strokeWeight(1);
      stroke(0);
      noStroke();
      rectMode(CENTER);
      fill(255, 150);
      rect(350, 240, 250, 60, 20);
      fill(20);
      textAlign(CENTER);
      textFont(font1);
      textSize(30);
      stroke(255);
      strokeWeight(2);
      text("WINNER IS: RED", 350, 250);
      strokeWeight(1);
      stroke(0);
      state="redWinNext";
    }
  } else if (state.equals("instructionsFade")) {
    mainMenu();
    transparency+=15;
    if (transparency<=0) {
      state="mainMenu";
    }
  }
}

void keyReleased() {
  if (state.equals("game")&&gamemode.equals("keyboard")) {
    if (key==CODED) {
      if (keyCode==LEFT) {
        tokenX-=54;
      } else if (keyCode==RIGHT) {
        tokenX+=54;
      }
    }
  }
  if (state.equals("game")&&!p1.equals("")&&!p2.equals("")&&delay>15&&((gamemode.equals("mouse")&&mouseX<=539&&mouseX>=150)||gamemode.equals("keyboard"))&&keyCode==ENTER) {
    state="tokenFall";
  } else if (state.equals("instructions")&&keyCode==ENTER) {
    y=0;
    x=0;
    state="instructionsNext";
  } else if (state.equals("intro")&&transparency>200) {
    state="mainMenu";
  }
}

void gameClear() {
  for (int i=0; i<7; i++) {
    for (int j=0; j<6; j++) {
      grid[j][i]=0;
    }
  }
  winner=0;
  p1="";
  p2="";
}

void goodbye() {
  transparency+=8;
  rectMode(CORNER);
  noStroke();
  fill(#CBF59E, transparency);
  rect(0, 0, 750, 500);
  strokeWeight(1);
  textSize(50);
  textAlign(CENTER);
  fill(20, transparency);
  text("Thank You for Playing Connect 4!", 350, 150);
  fill(255, transparency);
  text("Thank You for Playing Connect 4!", 353, 152);
  textSize(30);
  fill(#EA3232, transparency);
  text("This Program Was Written By: Nicole Han\nPress Any Key to Exit", 349, 258);
  fill(20, transparency);
  text("This Program Was Written By: Nicole Han\nPress Any Key to Exit.", 350, 260);
  if (keyPressed) {
    exit();
  }
  tint(255, transparency);
  image(tokenRed, -30, 210, width/2, height/1.5);
  image(tokenYellow, 390, 200, width/2, height/1.5);
}
