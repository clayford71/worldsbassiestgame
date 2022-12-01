class Coin{
  //class vars
  int x;
  int y;
  int tall;
  int wide;
  color cColor;
  color cStroke;
  
  int t;
  int b;
  int l;
  int r;
  
  //constructor
  Coin (int tempX, int tempY){
    x = tempX;
    y = tempY;
    tall = 32;
    wide = 24;
    cColor = color(230,230,0);
    cStroke = color(125,125,0);
  }
  
  //class functions
  void render(){
    if (hasCoin == false){
    fill(cColor);
    stroke(cStroke);
    ellipse(x,y,wide,tall);
    }
  }
  
  void hitbox(){
    t = y - tall/2;
    b = y + tall/2;
    l = x - wide/2;
    r = x + wide/2;
  }
}
