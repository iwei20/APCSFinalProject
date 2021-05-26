public class Unit {
  Sprite s,s_alt;
  int x,y;
  boolean alreadyMoved;
  boolean facing; // true = left, false = right
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
    this.facing = false; 
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
  private float calcPower(Unit a, Unit b) {
    if (!(a.index < 4) && b.airborne) {return 0;}
    if (!canAttack) {return 0;}
    int dist = abs(a.x - b.x) + abs(a.y - b.y);
    if (dist < attackRangeMin || dist > attackRangeMax) {return 0;}
    return 1;
  }
  public int attack(Unit other, Tile[][] map) {
    float thisDef = 2 + map[this.y][this.x].getTerrain().defense / 1.75;
    float othDef = 2 + map[other.y][other.x].getTerrain().defense /  1.75;
    
    float temp = other.health;
    other.health -= 1.75 * calcPower(this,other) * this.health / othDef;
    if (other.health > 0) {
      this.health -= calcPower(other,this) * temp / thisDef;
      if (this.health <= 0) {return -1;}
    } else {
      return 1; 
    }
    
    return 0;
  }
  public void render() {
    if (true) {
      s.draw(scale*x,scale*y,scale,facing);
    } else {
      s_alt.draw(scale*x,scale*y,scale,facing);
    }
  }
}
