class Button {

  //class vars
  int x;
  int y;
  int d;
  color aColor;
  String direction;

  //Constructor
  Button (int tempX, int tempY, int tempColor, String tempDir) {
    x = tempX;
    y = tempY;
    aColor = tempColor;
    direction = tempDir;
    d = 30;
  }

  //class functions
  void render() {
    fill(aColor);
    stroke(0);

    circle(x, y, d);
    if (direction == "Down") {
      line(x, y-10, x, y + 10);
      line(x - 10, y, x, y + 10);
      line(x + 10, y, x, y + 10);
    }
    if (direction == "Up") {
      line(x, y-10, x, y + 10);
      line(x - 10, y, x, y - 10);
      line(x + 10, y, x, y - 10);
    }
    if (direction == "Right") {
      line(x - 10, y, x + 10, y);
      line(x, y - 10, x + 10, y);
      line(x, y + 10, x + 10, y);
    }
    if (direction == "Left") {
      line(x - 10, y, x + 10, y);
      line(x, y - 10, x - 10, y);
      line(x, y + 10, x - 10, y);
    }
  }
}
