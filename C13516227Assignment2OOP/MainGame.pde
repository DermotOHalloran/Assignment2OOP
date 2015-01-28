/* 
    Dermot O' Halloran
    C13516227
    
    DT228/2 Assignment 2 Arcade Game
    
    Bumper Sharks */


int px = 320, py = 240;
int tileSize = 20;
int score = 0;
Button[] menuButtons;
static int nummenu = 3;    //Declaring various variables
boolean drawBoxes;
int gamescreen = 0;
int highscore;
int lastscore;
int difficulty = 2;
PImage img;
PImage img1;
int speed = 1;

import ddf.minim.*;

AudioPlayer player;
Minim minim;  //audio context

 
int signum(float value) { //enemy movement variable
  return value < 0 ? -1 : value > 0 ? 1 : 0;  
}
 

 
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
void addEnemy(int x, int y, String name) {
  Enemy enemy = new Enemy(name);    //Creating array of shark enemies
  enemy.x = x;       
  enemy.y = y;
  enemies.add(enemy);
}
 
void drawEnemies() {
 for(Enemy e: enemies) {
    e.draw();   //Calls draw in enemy class
  }
}
 

 
void setup() {
   
  size(800, 600); 
   
   img = loadImage("shark.jpeg");   //Loading image files used
   img1 = loadImage("shark1.png");
  
    menuButtons = new Button[6]; //Creating menu buttons
    menuButtons[0] = new Button("Play Game", new PVector(150, 250), 32, color(0), color(255, 0, 0));
    menuButtons[1] = new Button("Select Difficulty", new PVector(150, 350), 32, color(0), color(255, 0, 0));
    menuButtons[2] = new Button("Exit", new PVector(150, 450), 32, color(0), color(255, 0, 0));
    menuButtons[3] = new Button("2 Sharks", new PVector(150, 250), 32, color(0), color(255, 0, 0)); 
    menuButtons[4] = new Button("3 Sharks", new PVector(150, 350), 32, color(0), color(255, 0, 0));
    menuButtons[5] = new Button("4 Sharks", new PVector(150, 450), 32, color(0), color(255, 0, 0));
    drawBoxes = false;
  
    addEnemy(20, 20, "Kenny"); //Adding basic shark team
    addEnemy(700, 20, "Benny");
    
    minim = new Minim(this);
    player = minim.loadFile("jaws.mp3"); //loading Jaws theme music
    player.play();
    
      
}
 
void drawPlayer() {
  
  fill(235,220,160);
  rect(px, py, tileSize, tileSize);
  
  fill(0);
  textSize(tileSize-2);
  textAlign(CENTER, CENTER); //Drawing player block
  text("P", px+tileSize/2, py+tileSize/2-2);
}
 
void drawBackground() {
  
  fill(0, 105, 148);
  rect(0, 0, width, height);  //Blue Sea Background
    
  fill(0);
  textAlign(LEFT, BOTTOM);
  textSize(20);
  text("Points: "+score, 2, 2); //Score update
}
 
void draw() {
  
  if(gamescreen == 0)
  {
      background(255);
      image(img, 250, 350);  //Main menu
      image(img1, 140, 100);
      displayMenu();
  }
  
  if(gamescreen == 1)
  {
    drawBackground();
    drawPlayer();  //Start Game
    drawEnemies();
  }
  
   if(gamescreen == 3)
  {
      background(255);  //Shark difficulty menu
      displayMenu2();
   }
  
   if(gamescreen == 4)
  {
    exit();  
  }
}

void moveEnemies() {
  
  for(Enemy e: enemies) {
    e.hunt();  //Calls Enemy movement from class
  }
}

void displayMenu() 
{
  for (int i = 0; i < nummenu; i++) 
  {
      menuButtons[i].draw1(drawBoxes); //Displays main menu
  }
}

void displayMenu2() 
{
  for (int i = 3; i < 6; i++) 
  {
      menuButtons[i].draw1(drawBoxes); //Displays difficulty menu
  }
}
 
 
void checkCollisions() {
  ArrayList<Enemy> enemiesToCheck = new ArrayList<Enemy>(); //Loading enemy list
  
  for(Enemy e: enemies) {
    if(e.closeTo(px, py)) {
      gameOver(e); //Collision with player
      return;
    }
    
    for(Enemy e2: enemiesToCheck) {
      if(e.closeTo(e2.x, e2.y)) {
        e.fighting = true;
        e2.fighting = true; //Collision with sharks
      }
    }
    
    enemiesToCheck.add(e);
  }
  
  int notFighting = 0;
  for(Enemy e: enemies) {
    if(!e.fighting) {
      notFighting ++;  
    }
  }
  
  score ++;
  if(notFighting == 0) { //Win detection
    youWon();
  }
}
 
void youWon() {
  draw();
  noLoop(); //Game ends
  
  textAlign(CENTER, TOP);
  textSize(40);
  color outline = color(255,255,255);
  color fill = color(255,0,0);
  textWithOutline("WINNER WINNER CHICKEN DINNER!", width/2, 200, outline, fill); //Displaying winning message
  
  textSize(20);
  textWithOutline("The player outsmarted "+enemies.size()+" sharks!", width/2, 240, outline, fill); //Number of sharks beaten
  
 
  
  
}
  
void gameOver(Enemy e) {
  draw();
  noLoop(); //Game ends
  
  textAlign(CENTER, TOP);
  textSize(40);
  color outline = color(255,255,255);
  color fill = color(255,0,0);
  textWithOutline("DINNER TIME", width/2, 200, outline, fill); //Display losing message
  
  textSize(20);
  textWithOutline("The player was eaten by "+e.name+"!", width/2, 240, outline, fill); //Which shark ate the player
}
 
void textWithOutline(String message, int x, int y, color outline, color fill) {
  fill(outline);
  text(message, x-1, y);
  text(message, x+1, y);
  text(message, x, y-1);  //text setup
  text(message, x, y+1);
  
  fill(fill);
  text(message, x, y);
}
 
void movePlayer(int dx, int dy) {
  dx *= tileSize;
  dy *= tileSize;
  
  int newX = px + dx;
  int newY = py + dy;
  if(newX >= 0
    && newX < width
    && newY >= 0
    && newY < height  //function for player movements, calls collision check and enemy movement
  ) {
    px = newX;
    py = newY;
  }
 
  moveEnemies();
  checkCollisions();
}
 
void keyPressed() {
   if(key == CODED) {
    if(keyCode == UP) {
      movePlayer(0, -speed);
    } else if(keyCode == DOWN) {
      movePlayer(0, speed);
    } else if(keyCode == LEFT) {  // assigning arrows as movements keys
      movePlayer(-speed, 0);
    } else if(keyCode == RIGHT) {
      movePlayer(speed, 0);
    }
  } else if(key == ' ') {
    movePlayer(0, 0);
  }  
}

void mousePressed() 
{
  
  if (menuButtons[0].containsMouse()) 
  {
      gamescreen = 1;
  }
  
  if (menuButtons[1].containsMouse()) 
  {
      gamescreen = 3;
  }
  
  if (menuButtons[2].containsMouse()) //various stage calls for 2 menus
  {
      gamescreen = 4;
  }
  
   if (menuButtons[3].containsMouse()) 
  {
      difficulty = 2;
      gamescreen = 1;
  }
  
   if (menuButtons[4].containsMouse()) 
  {
      difficulty = 3;
      gamescreen = 1;
      speed = 2;
      addEnemy(20, 500, "Spenny");  //Adds 3rd shark, increments player speed
  }
  
   if (menuButtons[5].containsMouse()) 
  {
      difficulty = 4;
      gamescreen = 1;
      speed = 3;
      addEnemy(20, 500, "Spenny");
      addEnemy(700, 500, "Lenny"); //Adds 4th shark, increments player speed by 2
  }


}


  
