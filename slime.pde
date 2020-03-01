import fisica.*;


color black = #000000;
color green = color(34, 177, 76);
color pink = color (245, 109, 220);

PImage map;
int x = 0;
int y = 0;
int gridsize = 50;
boolean wkey, skey, akey, dkey, ekey, up, left, down, right, spacekey;
float vx, vy, zoomfactor, angle;
FWorld world;
FBox player1, player2;
FBomb bomb = null;
ArrayList<FBox> boxes = new ArrayList<FBox>();

void setup() {
  size(800, 600);
  Fisica.init(this);
  world = new FWorld(-1000000, -1000000, 1000000, 1000000);
  world.setGravity(0, 980);
  map = loadImage("map1.png");

  player1 = new FBox(50, 50);
  player1.setFillColor(green);
  player1.setNoStroke();
  player1.setPosition(200, 100);
  world.add(player1);

  while (y < map.height) {
    color c = map.get(x, y);


    if (c == black) {
      FBox b = new FBox(gridsize, gridsize);
      b.setFillColor(black);
      b.setPosition(x*gridsize, y*gridsize);
      b.setStatic(true);
      world.add(b);
      boxes.add(b);
    }
    if (c == green) {
      FBox b = new FBox(gridsize, gridsize);
      b.setFillColor(green);
      b.setStrokeColor(green);
      b.setPosition(x*gridsize, y*gridsize);
      b.setStatic(true);
      world.add(b);
    }

    println(c);
    x++;
    if (x == map.width) {
      x = 0;
      y++;
    }
  }
}

void draw() {
  background(255);
  pushMatrix();
  translate(-player1.getX()+width/2, -player1.getY()+height/2); 
  world.step();
  world.draw();
  popMatrix();

  vx = 0;
  if (akey) vx = -400;
  if (dkey) vx = 400;
  player1.setVelocity(vx, player1.getVelocityY());
  //jumping
  ArrayList<FContact> contacts = player1.getContacts();
  if (wkey && contacts.size() >0) player1.setVelocity(player1.getVelocityX(), -600);

  if (ekey && bomb == null) {
    bomb = new FBomb();
  }

  if (bomb != null) bomb.act();
}

void keyPressed() {
  if (key == 'w')  wkey = true;
  if (key == 's') skey = true;
  if (key == 'a') akey = true;
  if (key == 'd') dkey = true;
  if (key == ' ') spacekey = true;
  if (key == 'e') ekey = true;
  if (keyCode == UP) up = true;
  if (keyCode == DOWN) down = true;
  if (keyCode == LEFT) left = true;
  if (keyCode == RIGHT) right = true;
}

void keyReleased() {
  if (key == 'w')  wkey = false;
  if (key == 's') skey = false;
  if (key == 'a') akey = false;
  if (key == 'd') dkey = false;
  if (key == ' ') spacekey = false;
  if (key == 'e') ekey = false;
  if (keyCode == UP) up = false;
  if (keyCode == DOWN) down = false;
  if (keyCode == LEFT) left = false;
  if (keyCode == RIGHT) right = false;
}
