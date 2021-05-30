class DamagePreview {
  Unit attacker, target;
  int frame;
  float pos_x, pos_y_dam;
  int base_x, base_y;
  float indicatorscale;

  Sprite heart;
  public DamagePreview(Unit attacker, Unit target) {
    this.attacker = attacker;
    this.target = target;
    base_x = 0;
    base_y = 0;
    indicatorscale = .8;
    pos_x = -23 + (int)(122 * (1 - indicatorscale));
    pos_y_dam = height - 100;
    heart = new Sprite("icons/heart.png", color(255, 255, 255));
  }
  boolean hasUnits() {
    return attacker != null && target != null;
  }
  void display() {
    frame++;
    if(frame == 5 || frame == 10) {
       pos_y_dam -= 3 * indicatorscale;
    }
    if(frame == 15 || frame == 20) {
       pos_y_dam += 3 * indicatorscale;
    }
    if(frame == 25) {
      frame = 0;
    }
    noStroke();
    fill(180, 180, 180, 200);
    rect(10, height - 90, 130, 80);
    target.s.draw(85, height - 90, 3);
    m.board[target.x][target.y].getTerrain().s.draw(25, height - 80, 2);
    heart.draw(85, height - 38, 2);

    fill(255, 255, 255);
    textSize(16);
    textAlign(LEFT);
    text("DEF " + m.board[target.y][target.x].getTerrain().defense, 27, height - 30);
    textSize(20);
    text(ceil(target.health), 102, height - 26);

    rect(pos_x + indicatorscale * 97, pos_y_dam - indicatorscale * 40, indicatorscale * 56, indicatorscale * 47);
    triangle(pos_x + indicatorscale * 122, pos_y_dam + indicatorscale * 7, pos_x + indicatorscale * 130, pos_y_dam + indicatorscale * 7, pos_x + indicatorscale * 126, pos_y_dam + indicatorscale * 7 + indicatorscale * 4 * sqrt(3));
    fill(255, 0, 0);
    rect(pos_x + indicatorscale * 100, pos_y_dam - indicatorscale * 20, indicatorscale * 50, indicatorscale * 25);
    fill(255, 255, 255);
    textSize(indicatorscale * 24);
    textAlign(RIGHT);
    text("" + round(attacker.calcPower(attacker, target) * 11 /*(1.1 attack damage)*/) + " %", pos_x + indicatorscale * 150, pos_y_dam);
    textSize(indicatorscale * 20);
    fill(128, 128, 128);
    textAlign(CENTER);
    text("DAMAGE", pos_x + indicatorscale * 127,pos_y_dam - indicatorscale * 25);
  }
}
