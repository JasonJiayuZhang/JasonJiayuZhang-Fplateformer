class FBomb extends FBox {

  int timer;
  FBomb() {
    super(gridsize, gridsize); //FBox constructor
    timer = 60;
    this.setFillColor(pink);
    this.setPosition(player1.getX()+gridsize, player1.getY()-gridsize);
    world.add(this);
  }

  void act() {
    timer--;
    if (timer == 0) {
      explode();
      world.remove(this);
      bomb = null;
    }
  }


  void explode() {
    for (int i = 0; i < boxes.size(); i++) {
      FBox b = boxes.get(i);
      if (dist(this.getX(), this.getY(), b.getX(), b.getY()) < 200) {
        float vx = this.getX() - b.getX();
        float vy = this.getY() - b.getY();
        b.setVelocity(vx, vy);
        b.setStatic(false);
      }
    }
  }
}
