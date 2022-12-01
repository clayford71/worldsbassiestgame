class Goal{
  //class vars
  int x;
  int y;
  int w;
  int h;
  
  int t;
  int b;
  int l;
  int r;
  
  
  //constructor
  Goal (int tempX, int tempY, int tempW, int tempH){
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
  }
  
  //class functions
  void render(){
    if(hasCoin == true){
      stroke(color(230,230,0));
    }
    else{
      stroke(color(0,0,200));
    }
    fill(color(0,0,200,127));
    rect(x,y,w,h);
  }
  
  void hitbox(){
    t = y;
    b = y + h;
    l = x;
    r = x + w;
  }
}
