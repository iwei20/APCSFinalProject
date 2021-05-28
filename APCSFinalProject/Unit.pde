public class Unit {
  Sprite s,s_alt;
  int x,y;
  int lastX, lastY;
  int team;
  int index;
  
  // combat variables //
  float health;
  int mvmtRange;
  int attackRangeMin, attackRangeMax;
  boolean canAttack;
  boolean canAttackAndMove;
  boolean stationary;
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
    this.health = 10;
    this.index = type;
    this.team = team;
    this.mvmtRange = ((index >= 2 && index <= 3) ? (index == 2 ? 3 : 2) : 8);
    this.attackRangeMin = (index >= 12 && index <= 14) ? (index == 14 ? 2 : 3) : 0;
    this.attackRangeMax = (index >= 12 && index <= 14) ? (index == 14 ? 3 : 5) : 1;
    this.airborne = index >= 16 && index <= 19;
    this.isVehicle = index == 0 || (index >= 8 && index <= 14);
    this.stationary = index == 12;
    this.canAttack = !(index == 0 || index == 16);
    this.canAttackAndMove = !(index == 8 || index == 9 || (index >= 12 && index <= 14));
    this.navalOnly = index >= 24;
    
    int spriteIndex = type;
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
    m.board[y][x].occupying = null;
    x = lastX;
    lastX = -1;
    y = lastY;
    lastY = -1;
    m.board[y][x].occupying = this;
  }
  public boolean move(int newX, int newY) {
    if (stationary) {return false;}
    if ((newX != x || newY != y) && (takenAction || !checkMvmtRange_rec(newX,newY,0,mvmtRange,false,true,true) || m.board[newY][newX].occupying != null || (newX < 0 || newX >= m.board[0].length || newY < 0 || newY >= m.board.length))) {
      return false;
    } else {
      m.board[y][x].occupying = null;
      this.lastX = this.x;
      this.x = newX;
      this.lastY = this.y;
      this.y = newY;
      m.board[y][x].occupying = this;
      //this.takenAction = true;
      return true;
    }
  }
  public void setActionTaken() {
    takenAction = true;  
  }
  public float attack(Unit other) {
    float thisDef = 2 + m.getTile(this.x,this.y).getTerrain().defense / 1.75;
    float othDef = 2 + m.getTile(other.x,other.y).getTerrain().defense /  1.75;
    
    float temp = other.health;
    float thisPower = calcPower(this,other);
    other.health -= 1.75 * thisPower * this.health / othDef;
    if (other.health > 0) {
      this.health -= calcPower(other,this) * temp / thisDef;
    } 
    
    return thisPower;
  }
  public void displayRange(boolean tint, boolean attack) {
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
    for (int j = max(0,y-mvmtRange-attackRangeMax); j <= min(m.board.length-1,y+mvmtRange+attackRangeMax); j++) {
      for (int i = max(0,x-mvmtRange-attackRangeMax); i <= min(m.board[0].length-1,x+mvmtRange+attackRangeMax); i++) {
        if ((!attack && checkMvmtRange_rec(i,j,0,mvmtRange,false,true,true)) || (attack && canAttack && (canAttackAndMove ? checkMvmtRange_rec(i,j,0,mvmtRange+1,false,false,true) : 
        (!checkMvmtRange_rec(i,j,0,attackRangeMin-1,false,false,false) && checkMvmtRange_rec(i,j,0,attackRangeMax,false,false,false))))) {
            rect(scale*(i+m.left_view)*16,scale*(j+m.top_view)*16,scale*16,scale*16);
            if (i == x && y == j) {render();}
            //println("rect("+scale*i*16+"," +scale*j*16+"," +scale*16 +"," +scale*16+")");
        }
      }
    }
  }
  private boolean checkMvmtRange_rec(int tx, int ty, int steps, int maxSteps, boolean add, boolean checkTerrain, boolean checkAtAll) {
    if (!checkTerrain && tx == x && ty == y) {return true;}
    if (tx < 0 || tx >= m.board.length || ty < 0 || ty >= m.board[0].length) {return false;}
    Terrain t = m.board[ty][tx].getTerrain();
    if (checkAtAll) {
      if (navalOnly && t.wet == false) {return false;}
      if (t.ocean && !airborne && !navalOnly) {return false;}
      if (isVehicle && !airborne && !t.drivable) {return false;}
      if (tx == x && ty == y) {return true;}
      if (add) {steps += t.drivable ? 1 : 2;}
    } else {if (add) {steps++;}}
    if (steps >= maxSteps) {return false;}
    return checkMvmtRange_rec(tx+1,ty,steps,maxSteps,true,checkTerrain,checkAtAll) || checkMvmtRange_rec(tx-1,ty,steps,maxSteps,true,checkTerrain,checkAtAll) || 
    checkMvmtRange_rec(tx,ty-1,steps,maxSteps,true,checkTerrain,checkAtAll) || checkMvmtRange_rec(tx,ty+1,steps,maxSteps,true,checkTerrain,checkAtAll);
  }
  public ArrayList<Unit> checkUnitsInRange() {
    ArrayList<Unit> yesunits = new ArrayList();  
    if (!canAttackAndMove && (lastX != x || lastY != y)) {return yesunits;}
    for (int j = max(0,y-attackRangeMax); j <= min(m.board.length-1,y+attackRangeMax); j++) {
      for (int i = max(0,x-attackRangeMax); i <= min(m.board[0].length-1,x+attackRangeMax); i++) {
        if (m.board[j][i].occupying != null && m.board[j][i].occupying.team != this.team && !(attackRangeMin != 0 
        && checkMvmtRange_rec(i,j,0,attackRangeMin-1,false,false,false)) && checkMvmtRange_rec(i,j,0,attackRangeMax,false,false,false)) {
          if (calcPower(this,m.board[j][i].occupying) != 0) {yesunits.add(m.board[j][i].occupying);}
        }
      }
    }
    return yesunits;
  }
  public void render() {
    if (health > 0) {
      if (true) {
        s.draw(scale*x*16,scale*y*16,scale,team != 0,takenAction ? .8 : 1);
      } else {
        s_alt.draw(scale*x*16,scale*y*16,scale,team != 0,takenAction ? .8 : 1);
      }
      if (ceil(health) < 10) {
        healthIcons[ceil(health)-1].draw(scale*x*16+8*scale,scale*y*16+9*scale,scale);
      }
    } else {
      //destroy unit 
      m.board[y][x].occupying = null;
      (team == 0 ? m.pUnits : m.eUnits).remove(this);
    }
  }
}
