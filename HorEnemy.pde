class HorEnemy{
  //class vars
  int x;
  int y;
  int size;
  
  color eColor;
  
  int xSpeed;
  int minX;
  int maxX;
  
  int t;
  int b;
  int l;
  int r;
  
  //constructor
  HorEnemy (int tempX, int tempY,int tempMinX, int tempMaxX, int tempS){
    x = tempX;
    y = tempY;
    minX = tempMinX;
    maxX = tempMaxX;
    size = 30;
    xSpeed = tempS;
    eColor = color(200,0,200);
  }
  
  //class functions
  void render(){
    fill(eColor);
    stroke(eColor);
    rect(x, y, size/5, size/5);
    rect(x, y + 2*size/5, size/5, size/5);
    rect(x, y + 4*size/5, size/5, size/5);
    
    rect(x + size/5, y + size/5, size/5, size/5);
    rect(x + size/5, y + 2*size/5, size/5, size/5);
    rect(x + size/5, y + 3*size/5, size/5, size/5);
    
    rect(x + 2*size/5, y, size/5, size/5);
    rect(x + 2*size/5, y + size/5, size/5, size/5);
    rect(x + 2*size/5, y + 2*size/5, size/5, size/5);
    rect(x + 2*size/5, y + 3*size/5, size/5, size/5);
    rect(x + 2*size/5, y + 4*size/5, size/5, size/5);
    
    rect(x + 3*size/5, y + size/5, size/5, size/5);
    rect(x + 3*size/5, y + 2*size/5, size/5, size/5);
    rect(x + 3*size/5, y + 3*size/5, size/5, size/5);
    
    rect(x + 4*size/5, y, size/5, size/5);
    rect(x + 4*size/5, y + 2*size/5, size/5, size/5);
    rect(x + 4*size/5, y + 4*size/5, size/5, size/5);
  }
  
  void patrol(){
    
    //outlines patrol route with lines
    //line(minX, y + size/2, maxX, y + size/2); 
    
      x += xSpeed;
    
      if (x + size > maxX){
        xSpeed = -xSpeed;
       }
      if (x < minX){
        xSpeed = -xSpeed;
      }
  }
  
  void hitbox(){
    t = y;
    b = y + size;
    l = x;
    r = x + size;
  }
}
