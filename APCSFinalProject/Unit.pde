public class Unit {
  Sprite s,s_alt;
  int x,y;
  int lastX, lastY;
  boolean alreadyMoved;
  boolean facing; // true = left, false = right
  int team;
  int index;
  
  // combat variables //
  float health;
  int mvmtRange;
  int attackRangeMin, attackRangeMax;
  boolean canAttack;
  boolean takenAction;
  boolean airborne;
  boolean isVehicle;
  boolean navalOnly;
  
  public Unit(Map m, int init_x, int init_y, int type, int team) {
    this.x = init_x;
    this.y = init_y;
    this.lastX = -1;
    this.lastY = -1;
    m.board[y][x].occupying = this;
    this.facing = false; 
    this.health = 10;
    this.index = type;
    this.team = team;
    this.mvmtRange = ((index >= 2 && index <= 3) ? (index == 2 ? 3 : 2) : 8);
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
  public void newTurn() {
    this.lastX = -1;
    this.lastY = -1;
    this.takenAction = false;
    if (false) {health = min(10,health+2);}
  }
  public void undoMove() {
    x = lastX;
    lastX = -1;
    y = lastY;
    lastY = -1;
    this.takenAction = false;
  }
  public boolean move(int newX, int newY) {
    if (takenAction || abs(this.x - newX) + abs(this.y - newY) > mvmtRange || m.board[newY][newX].occupying != null || (newX < 0 || newX >= m.board[0].length || newY < 0 || newY >= m.board.length)) {
      return false;
    } else {
      m.board[y][x].occupying = null;
      this.facing = newX < this.x;
      this.lastX = this.x;
      this.x = newX;
      this.lastY = this.y;
      this.y = newY;
      m.board[y][x].occupying = this;
      this.takenAction = true;
      return true;
    }
  }
  public int attack(Unit other) {
    float thisDef = 2 + m.getTile(this.x,this.y).getTerrain().defense / 1.75;
    float othDef = 2 + m.getTile(other.x,other.y).getTerrain().defense /  1.75;
    
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
  public void displayRange(boolean tint) {
    noStroke();
    if (tint) {
      switch(team) {
        case 0:
          fill(255,0,0,75);
          break;
        case 1:
          fill(0,120,0,75);
          break;
        case 2:
          fill(0,0,255,75);
          break;
        case 3:
          fill(255,255,0,75);
          break;
        case 4:
          fill(128,128,128,75);
          break;
      }
    } else {
      fill(0,180,0,75);  
    }
    for (int j = max(0,y-mvmtRange); j <= min(m.board.length-1,y+mvmtRange); j++) {
      for (int i = max(0,x-mvmtRange); i <= min(m.board[0].length-1,x+mvmtRange); i++) {
        if(checkMvmtRange_rec(i,j,0,false)) {
            rect(scale*i*16,scale*j*16,scale*16,scale*16);
            if (i == x && y == j) {render(x,y);}
            //println("rect("+scale*i*16+"," +scale*j*16+"," +scale*16 +"," +scale*16+")");
        }
      }
    }
  }
  private boolean checkMvmtRange_rec(int tx, int ty, int steps, boolean add) {
    if (tx == x && ty == y) {return true;}
    if (tx < 0 || tx >= m.board.length || ty < 0 || ty >= m.board[0].length) {return false;}
    Terrain t = m.board[ty][tx].getTerrain();
    if (navalOnly && t.wet == false) {return false;}
    if (t.ocean && !airborne && !navalOnly) {return false;}
    if (isVehicle && !airborne && !t.drivable) {return false;}
    if (add) {steps += t.drivable ? 1 : 2;}
    if (steps >= mvmtRange) {return false;}
    return checkMvmtRange_rec(tx+1,ty,steps,true) || checkMvmtRange_rec(tx-1,ty,steps,true) || checkMvmtRange_rec(tx,ty-1,steps,true) || checkMvmtRange_rec(tx,ty+1,steps,true);
  }
  public void render(int x, int y) {
    if (true) {
      s.draw(scale*x*16,scale*y*16,scale,facing,takenAction ? .8 : 1);
    } else {
      s_alt.draw(scale*x*16,scale*y*16,scale,facing,takenAction ? .8 : 1);
    }
    if (round(health) < 10) {
      healthIcons[round(health)-1].draw(scale*x+8*scale,scale*y+9*scale,scale);
    }
  }
}
