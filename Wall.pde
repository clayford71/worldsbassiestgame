class Wall{
  //class vars
  int x;
  int y;
  int w;
  int h;
  
  color wColor;
  
  int t;
  int b;
  int l;
  int r;
  
  boolean collision = false;
  
  
  //constructors
  Wall (int tempX, int tempY, int tempW, int tempH){
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    wColor = color(69);
  }
  
  //class functions
  void render(){
    stroke(wColor);
    fill(wColor);
    rect(x,y,w,h);
  }
  
  void hitbox(){
    t = y;
    b = y + h;
    l = x;
    r = x + w;
  }
  
  //void collide(){
  //  if (p1.l < r){
  //    collideLeft = true;
  //  }
  //  if (p1.r > l){
  //    collideRight = true;
  //  }
  //  if (p1.t < b){
  //    collideUp = true;
  //  }
  //  if (p1.b > t){
  //    collideDown = true;
  //  }
  //  else{
  //    collideLeft = false;
  //    collideRight = false;
  //    collideUp = false;
  //    collideDown = false;
  //  }
  //}
}
