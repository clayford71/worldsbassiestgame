//libraries
import processing.sound.*;
import processing.serial.*;


//global vars
SoundFile deathNoise;
SoundFile winNoise;
SoundFile backgroundNoise;

boolean isMovingUp = false;
boolean isMovingDown = false;
boolean isMovingLeft = false;
boolean isMovingRight = false;
boolean collideUp = false;
boolean collideDown = false;
boolean collideLeft = false;
boolean collideRight = false;
int state = 0;

Player p1;
int xStart;
int yStart;

VertEnemy[] vertEnemyArraylvl1 = new VertEnemy[2];

VertEnemy[] vertEnemyArraylvl2 = new VertEnemy[2];
HorEnemy[] horEnemyArraylvl2 = new HorEnemy[2];

VertEnemy[] vertEnemyArraylvl3 = new VertEnemy[3];

boolean isDead = false;

Coin coinlvl1;
Coin coinlvl2;
Coin coinlvl3;
boolean hasCoin = false;

Goal goal;
Goal goal2;
boolean hasWon = false;
boolean levelCompleted = false;

ArrayList<Wall> wallList = new ArrayList<Wall>();

int startTime;
int endTime;
int interval = 2000;

Button b1;
Button b2;
Button b3;
Button b4;

//arduino reception section
String message;
//Serial port;
String portname = "/dev/cu.usbmodem11301";

boolean firstContact = false;

int frequency;

//setup function
void setup() {
  size(800, 600);
  xStart = 35;
  yStart = 285;
  background(240, 240, 255);

  //port = new Serial(this, portname, 9600);

  p1 = new Player(xStart, yStart);

  deathNoise = new SoundFile(this, "R2.wav");
  winNoise = new SoundFile(this, "Boom.wav");
  backgroundNoise = new SoundFile(this, "Crazy.wav");

  // level 1 enemies
  for (int i = 0; i < vertEnemyArraylvl1.length; i++) {
    vertEnemyArraylvl1[0] = new VertEnemy(300, 230, 200, 400, 5);
    vertEnemyArraylvl1[1] = new VertEnemy(475, 370, 200, 400, 5);
  }

  // level 2 enemies
  for (int i = 0; i < vertEnemyArraylvl2.length; i++) {
    vertEnemyArraylvl2[0] = new VertEnemy(300, 285, 200, 400, -5);
    vertEnemyArraylvl2[1] = new VertEnemy(475, 285, 200, 400, 5);
  }
  for (int i = 0; i < horEnemyArraylvl2.length; i++) {
    horEnemyArraylvl2[0] = new HorEnemy(385, 120, 120, 650, -7);
    horEnemyArraylvl2[1] = new HorEnemy(385, 450, 120, 650, 7);
  }

  // level 3 enemies
  for (int i = 0; i < vertEnemyArraylvl3.length; i++) {
    vertEnemyArraylvl3[0] = new VertEnemy(235, 180, 115, 450, 8);
    vertEnemyArraylvl3[1] = new VertEnemy(385, 420, 150, 485, -8);
    vertEnemyArraylvl3[2] = new VertEnemy(535, 180, 115, 450, 8);
  }

  coinlvl1 = new Coin(width/2, height/2);
  coinlvl2 = new Coin(width/2, height/2);
  coinlvl3 = new Coin(750, height/2);

  goal = new Goal(7*width/8, 2*height/5, width/8, height/5);
  goal2 = new Goal(0, 2*height/5, width/8, height/5);

  Wall wall0 = new Wall(0, 0, width, height/6);
  Wall wall1 = new Wall(0, 5*height/6, width, height/6);
  Wall wall2 = new Wall(0, 0, width/8, 2*height/5);
  Wall wall3 = new Wall(0, 3*height/5, width/8, 2*height/5);
  Wall wall4 = new Wall(7*width/8, 0, width/8, 2*height/5);
  Wall wall5 = new Wall(7*width/8, 3*height/5, width/8, 2*height/5);

  wallList.add(wall0);
  wallList.add(wall1);
  wallList.add(wall2);
  wallList.add(wall3);
  wallList.add(wall4);
  wallList.add(wall5);
}

//draw function
void draw() {
  background(230, 230, 255);

  if (!backgroundNoise.isPlaying()) {
    backgroundNoise.amp(.2);
    backgroundNoise.play();
  }
  

  switch(state) {
  case 0:

    fill(0);
    textSize(30);
    text("World's Averagest Game I Guess.", width/4, 2*height/5);
    textSize(20);
    text("Hit any note to Play or Whatever.", width/3, height/2);

    hasWon = false;
    hasCoin = false;
    
    delay(3000);
      if (frequency != 0){
        state += 1;
      }

    break;
  case 1:
    if (levelCompleted == true) {
      fill(0);
      textSize(50);
      text("Level Completed. Yipee.", width/5 - 10, 2*height/5);
      textSize(30);
      text("Hit any note for next level.", width/3 - 25, 2*height/3);
      delay(3000);
      if (frequency != 0){
        state += 1;
      }
    } else {

      p1.render();
      p1.move();
      p1.hitbox();
      p1.win(goal);
      p1.coinCollect(coinlvl1);

      for (Wall aWall : wallList) {
        aWall.render();
        aWall.hitbox();
        p1.wallDetect(aWall);
      }

      for (int i = 0; i< vertEnemyArraylvl1.length; i++) {
        vertEnemyArraylvl1[i].render();
        vertEnemyArraylvl1[i].patrol();
        vertEnemyArraylvl1[i].hitbox();
        p1.VertEnemyDetect(vertEnemyArraylvl1[i]);
      }

      coinlvl1.render();
      coinlvl1.hitbox();

      goal.render();
      goal.hitbox();
    }

    break;


  case 2:
    if (levelCompleted == true) {
      fill(0);
      textSize(50);
      text("Level Completed. Yipee.", width/5 - 10, 2*height/5);
      textSize(30);
      text("Hit any note for next level.", width/3 - 25, 2*height/3);
      delay(3000);
      if (frequency != 0){
        state += 1;
      }
    } else {
      p1.render();
      p1.move();
      p1.hitbox();
      p1.win(goal);
      p1.coinCollect(coinlvl2);

      for (Wall aWall : wallList) {
        aWall.render();
        aWall.hitbox();
        p1.wallDetect(aWall);
      }

      for (int i = 0; i< vertEnemyArraylvl2.length; i++) {
        vertEnemyArraylvl2[i].render();
        vertEnemyArraylvl2[i].patrol();
        vertEnemyArraylvl2[i].hitbox();
        p1.VertEnemyDetect(vertEnemyArraylvl2[i]);
      }
      for (int i = 0; i< horEnemyArraylvl2.length; i++) {
        horEnemyArraylvl2[i].render();
        horEnemyArraylvl2[i].patrol();
        horEnemyArraylvl2[i].hitbox();
        p1.HorEnemyDetect(horEnemyArraylvl2[i]);
      }

      coinlvl2.render();
      coinlvl2.hitbox();

      goal.render();
      goal.hitbox();
    }

    break;

  case 3:
    p1.render();
    p1.move();
    p1.hitbox();
    p1.win(goal2);
    p1.coinCollect(coinlvl3);

    for (Wall aWall : wallList) {
      aWall.render();
      aWall.hitbox();
      p1.wallDetect(aWall);
    }

    for (int i = 0; i< vertEnemyArraylvl3.length; i++) {
      vertEnemyArraylvl3[i].render();
      vertEnemyArraylvl3[i].patrol();
      vertEnemyArraylvl3[i].hitbox();
      p1.VertEnemyDetect(vertEnemyArraylvl3[i]);
    }

    coinlvl3.render();
    coinlvl3.hitbox();

    goal2.render();
    goal2.hitbox();

    break;

  case 4:

    backgroundNoise.amp(1);

    for (Wall aWall : wallList) {
      aWall.render();
      aWall.hitbox();
      p1.wallDetect(aWall);
    }
    fill(0);
    textSize(80);
    text("You Win.", width/4 + 40, height/2 - 75);
    textSize(30);
    text("Hit a note to Replay.", width/3, height/2);
    textSize(20);
    text("Or don't. I don't care.", width/3 + 30, 3*height/5);
    delay(3000);
      if (frequency != 0){
        state += 1;
      }

    break;
  }

  displayButtons(50,50);
  //receive();
  checkNotes();
}

//DO NOT DELETE

//keyPressed function
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      isMovingUp = true;
    }
    if (keyCode == DOWN) {
      isMovingDown = true;
    }
    if (keyCode == LEFT) {
      isMovingLeft = true;
    }
    if (keyCode == RIGHT) {
      isMovingRight = true;
    }
  }
}


//keyReleased function
void keyReleased() {

  if (key == CODED) {
    if (keyCode == UP) {
      isMovingUp = false;
    }
    if (keyCode == DOWN) {
      isMovingDown = false;
    }
    if (keyCode == LEFT) {
      isMovingLeft = false;
    }
    if (keyCode == RIGHT) {
      isMovingRight = false;
    }
  }


  if (key == ' ') {
    if (state == 0) {
      state += 1;
    }
    if (levelCompleted == true) {
      state += 1;
      levelCompleted = false;
      hasCoin = false;
      p1.x = xStart;
      p1.y = yStart;
    }
  }
  if (key == 'r') {
    if (state == 4) {
      state = 0;
      p1.x = xStart;
      p1.y = yStart;
    }
    if (state < 4 && levelCompleted == true) {
      levelCompleted = false;
      hasCoin = false;
      p1.x = xStart;
      p1.y = yStart;
    }
  }
}

/*
void receive() {

  char startMarker = '<';
  char endMarker = '>';

  //  println("frame");
  // checks to see if anything has been sent over the serial line
  while (port.available() > 0) {

    // println("wow");
    String reception;
    //reception = port.read();//StringUntil('\n');//.substring(0,-1);
    //println(reception);
    frequency = int(port.readString());//int(reception);
    println(frequency);

    //  char aChar = port.readChar();

    //  if (aChar == startMarker) {

    //    message = port.readStringUntil(endMarker);

    //    if (message != null) {
    //      parseMessage(message);
    //    }
    //  }
    //}
  }
}
*/





/*
//parse function
 void parseMessage(String aMessage) {
 
 int startIndex = 0;//aMessage.indexOf('<') + 1;
 int endIndex = aMessage.indexOf('>');
 
 frequency = float(aMessage.substring(startIndex, endIndex));
 
 //println("TEST");
 println(frequency);
 }
 
 void serialEvent(Serial myPort) {
 if (!firstContact) {
 
 //put the incoming data into a String -
 //the '\n' is our end delimiter indicating the end of a complete packet
 String val = myPort.readStringUntil('\n');
 //make sure our data isn't empty before continuing
 if (val != null) {
 //trim whitespace and formatting characters (like carriage return)
 val = trim(val);
 //println(val);
 
 //look for our 'A' string to start the handshake
 //if it's there, clear the buffer, and send a request for data
 if (firstContact == false) {
 if (val.equals("A")) {
 myPort.clear();
 firstContact = true;
 myPort.write("A");
 println("contact");
 }
 }
 }
 }
 }
 */
void checkNotes() {
  if (frequency == 1) {
    println("UP");
    //p1.y -= p1.ySpeed;
    isMovingUp = true;
  } else {
    isMovingUp = false;
  }



  if (frequency == 2) {
    isMovingLeft = true;
  } else {
    isMovingLeft = false;
  }



  if (frequency == 3) {
    isMovingRight = true;
  } else {
    isMovingRight = false;
  }



  if (frequency == 4) {
    isMovingDown = true;
  } else {
    isMovingDown = false;
  }
}


void displayButtons (int tempX, int tempY){
  b1 = new Button(tempX, tempY - 30, color(255, 255, 0), "Up");
  b2 = new Button(tempX, tempY + 30, color(0, 255, 0), "Down");
  b3 = new Button(tempX - 30, tempY, color(50, 50, 255), "Left");
  b4 = new Button(tempX + 30, tempY, color(255, 0, 0), "Right");
  
  b1.render();
  b2.render();
  b3.render();
  b4.render();
}
