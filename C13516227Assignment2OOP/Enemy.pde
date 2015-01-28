class Enemy {
  color c;
  int x, y;   //Enemy base variables
  String name;
  boolean fighting;
  
  Enemy(String name) {
    this.name = name;
    c = color(102,102,102);  //Grey 
  }
  
  void draw() {
    fill(c);
    ellipse(x + tileSize/2, y + tileSize/2, tileSize, tileSize);
    arc(x + tileSize/2, y + tileSize/2 , 10, 10, 0, PI,CHORD);
    ellipse(x + tileSize/4, y + tileSize/4, 2, 2);  //Drawing shark body, eyes and mouth
    ellipse(x + tileSize/1.5, y + tileSize/4, 2, 2);
    
    
    fill(0);
    textAlign(CENTER, TOP);
    textSize(12);
    text(name, x + tileSize/2, y + tileSize + 2); //Displays sharks name
  }
  
  void hunt() {
    int dx = signum(px - x) * tileSize-1;
    int dy = signum(py - y) * tileSize-1; //Shark movement calc
    
    x += dx;
    y += dy;
  }
  
  boolean closeTo(int tx, int ty) {
    int dx = abs(x - tx) / tileSize;
    int dy = abs(y - ty) / tileSize;
    println(name+" dx="+dx+" dy="+dy);
    return dx <= 1 && dy <= 1;
  }
}
