public class Unit {
  Sprite s,s_alt;
  int x,y;
  boolean alreadyMoved;
  int team;
  int index;
  
  // combat variables //
  float health;
  int mvmtRange;
  int attackRangeMin, attackRangeMax;
  boolean canAttack;
  boolean airborne;
  boolean isVehicle;
  boolean navalOnly;
  
  public Unit(int init_x, int init_y, int type, int team) {
    this.x = init_x;
    this.y = init_y;
    this.health = 10;
    this.index = type;
    this.team = team;
    int spriteIndex = type;
    if (spriteIndex >= 4) {spriteIndex += 4;}
    spriteIndex += 4 * (max(0,spriteIndex - 16) / 4); 
    s = new Sprite(loadImage("units/t" + team + "_" + spriteIndex + ".png"));
    if (spriteIndex < 4 || spriteIndex >= 16) {
    s_alt = new Sprite(loadImage("units/t" + team + "_" + (spriteIndex+4) + ".png"));
    } else {
    s_alt = null;  
    }
  }
}
