class VertEnemy{
  //class vars
  int x;
  int y;
  int size;
  
  color eColor;
  
  int ySpeed;
  int minY;
  int maxY;
  
  int t;
  int b;
  int l;
  int r;
  
  
  //constructorz
  VertEnemy (int tempX, int tempY,int tempMinY, int tempMaxY, int tempS){
    x = tempX;
    y = tempY;
    minY = tempMinY;
    maxY = tempMaxY;
    size = 30;
    ySpeed = tempS;
    eColor = color(240,0,0);
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
    //line(x + size/2, minY, x + size/2, maxY);
    
    
      y += ySpeed;
    
      if (y + size > maxY){
        ySpeed = -ySpeed;
       }
      if (y < minY){
        ySpeed = -ySpeed;
      }
  }
  
  void hitbox(){
    t = y;
    b = y + size;
    l = x;
    r = x + size;
  }
}
