class DamagePreview {
  Unit attacker, target;
  int frame;
  int pos_x, pos_y_dam;
  Sprite heart;
  public DamagePreview(Unit attacker, Unit target) {
    this.attacker = attacker;
    this.target = target;
    pos_x = 10;
    pos_y_dam = height - 120;
    heart = new Sprite("icons/heart.png", color(255, 255, 255));
  }
  boolean hasUnits() {
    return attacker != null && target != null; 
  }
  void display() {
    frame++;
    if(frame == 5 || frame == 10) {
       pos_y_dam -= 3;  
    }
    if(frame == 15 || frame == 20) {
       pos_y_dam += 3;      
    }
    if(frame == 25) {
      frame = 0;
    }
    fill(180, 180, 180, 200);
    rect(10, height - 110, 170, 100);
    target.s.draw(110, height - 110, 4);
    m.board[target.x][target.y].getTerrain().s.draw(35, height - 90, 3);
    heart.draw(110, height - 40, 3);
    
    fill(255, 255, 255);
    textSize(16);
    textAlign(LEFT);
    text("DEF " + m.board[target.x][target.y].getTerrain().defense, 37, height - 30);
    textSize(20);
    text(round(target.health), 135, height - 26);
    rect(pos_x + 97, pos_y_dam - 40, 56, 47);
    triangle(pos_x + 122, pos_y_dam + 7, pos_x + 130, pos_y_dam + 7, pos_x + 126, pos_y_dam + 7 + 4 * sqrt(3));
    fill(255, 0, 0);
    rect(pos_x + 100, pos_y_dam - 20, 50, 25); 
    fill(255, 255, 255);
    textSize(24);
    textAlign(RIGHT);
    text("" + round(attacker.calcPower(attacker, target) * 10) + " %", pos_x + 150, pos_y_dam);
    textSize(20);
    fill(128, 128, 128);
    textAlign(CENTER);
    text("DAMAGE", pos_x + 127, pos_y_dam - 25);
  }
}
