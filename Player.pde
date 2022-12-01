class Player {
  //class vars
  int x;
  int y;
  int size;
  color pColor;
  color pStroke = color(0, 200, 0);
  int xSpeed;
  int ySpeed;

  int t;
  int b;
  int l;
  int r;

  int startX;
  int startY;

  int startTime;
  int endTime;
  int interval = 2000;


  //constructor
  Player (int tempX, int tempY) {
    x = tempX;
    y = tempY;
    startX = tempX;
    startY = tempY;
    size = 30;
    pColor = color(0, 255, 0);
    xSpeed = 4;
    ySpeed = 4;
  }

  //class functions
  void render() {

    strokeWeight(3);
    stroke(pStroke);
    fill(pColor);
    rect(x, y, size, size, 3);
  }

  void move() {
    if (isMovingUp == true) {
      y -= ySpeed;
    }
    if (isMovingDown == true) {
      y += ySpeed;
    }
    if (isMovingLeft == true) {
      x -= xSpeed;
    }
    if (isMovingRight == true) {
      x += xSpeed;
    }
  }

  void wallDetect(Wall aWall) {
    // if you are colliding with aWall
    if (t < aWall.b && l < aWall.r && r > aWall.l && b > aWall.t) {
      // if you are coming from bottom
      if (b > aWall.b && isMovingUp == true) {
        isMovingUp = false;
        y = aWall.b;
      } else if (t < aWall.t && isMovingDown == true) {
        isMovingDown = false;
        y = aWall.t - size;
      } else if (r > aWall.r && isMovingLeft == true) {
        isMovingLeft = false;
        x = aWall.r;
      } else if (l < aWall.l && isMovingRight == true) {
        isMovingRight = false;
        x = aWall.l - size;
      }
    }
  }

  void HorEnemyDetect(HorEnemy anHEnemy) {
    if (p1.l <= anHEnemy.r && p1.r >= anHEnemy.l && p1.t <= anHEnemy.b && p1.b >= anHEnemy.t) {
      isDead = true;
      deathNoise.play();
    }

    if (isDead == true) {
      isDead = false;
      hasCoin = false;
      x = startX;
      y = startY;
    }
  }

  void VertEnemyDetect(VertEnemy aVEnemy) {
    if (p1.l <= aVEnemy.r && p1.r >= aVEnemy.l && p1.t <= aVEnemy.b && p1.b >= aVEnemy.t) {
      isDead = true;
      deathNoise.play();
    }

    if (isDead == true) {
      isDead = false;
      hasCoin = false;
      x = startX;
      y = startY;
    }
  }

  void hitbox() {
    t = y;
    b = y + size;
    l = x;
    r = x + size;
  }

  void coinCollect(Coin c1) {
    if (p1.l <= c1.r && p1.r >= c1.l && p1.t <= c1.b && p1.b >= c1.t) {
      hasCoin = true;
    }
  }


  void win(Goal goal) {
    if (p1.l <= goal.r && p1.r >= goal.l && p1.t <= goal.b && p1.b >= goal.t && hasCoin == true) {
      if (state == 3) {
        state = 4;
      } else {
        levelCompleted = true;
        winNoise.play();
      }
    }
  }
}
