public class Unit {
  Sprite s,s_alt;
  int x,y;
  int lastX, lastY;
  int team;
  int index;
  int exploding; // for explode animation when units are destroyed
  
  // combat variables //
  float health;
  int mvmtType; // 0 = on foot, 1 = treads, 2 = tires
  int mvmtRange;
  int attackRangeMin, attackRangeMax;
  int unitsCanTransport;
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
    this.exploding = -1;
    m.board[y][x].occupying = this;
    this.health = 10;
    this.index = type;
    this.team = team;
    this.mvmtType = (index >= 24) ? 3 : ((index == 2 || index == 3) ? 0 : (index == 1) ? 2 : 1);
    this.mvmtRange = ((index >= 2 && index <= 3) ? (index == 2 ? 2 : 3) : 5);
    this.attackRangeMin = (index >= 12 && index <= 14) ? (index == 14 ? 2 : 3) : 0;
    this.attackRangeMax = (index >= 12 && index <= 14) ? (index == 14 ? 3 : 5) : 1;
    this.airborne = index >= 16 && index <= 19;
    this.isVehicle = index == 0 || (index >= 8 && index <= 14);
    this.stationary = index == 12;
    this.canAttack = !(index == 0 || index == 16);
    this.canAttackAndMove = !(index == 8 || index == 9 || (index >= 12 && index <= 14));
    this.unitsCanTransport = (index == 0 || index == 16 || index == 24) ? (index == 24 ? 2 : 1) : 0;   
    this.navalOnly = index >= 24; 
    
    int spriteIndex = type;
    s = new Sprite(loadImage("units/t" + team + "_" + spriteIndex + ".png"));
    if (spriteIndex < 4 || spriteIndex >= 16) {
    s_alt = new Sprite(loadImage("units/t" + team + "_" + (spriteIndex+4) + ".png"));
    } else {
    s_alt = null;  
    }
  }
  public void newTurn(boolean restore) {
    this.lastX = -1;
    this.lastY = -1;
    this.takenAction = false;
    if (restore && false) {health = min(10,health+2);}
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
  public float calcPower(Unit a, Unit b) {
    if (!(a.attackRangeMin != 0 && a.checkMvmtRange_rec(b.x,b.y,0,a.attackRangeMin-1,false,false,false)) && a.checkMvmtRange_rec(b.x,b.y,0,a.attackRangeMax,false,false,false)) {   
      /* this should do calculations */
      float t = damageChart[b.index][a.index] * a.health * .1;
      if (t <= 0) {return 0;}
      return .1 * (t - (b.airborne ? 0 : m.board[b.y][b.x].getTerrain().defense) * ((t * .1) - (t * .01 * (10 - b.health))));
    } else {
      return 0;
    }
  }
  public float attack(Unit other) {
    float thisPower = calcPower(this,other) * 1.1;
    float otherPower = calcPower(other,this) * .9;
    println(thisPower);
    println(otherPower);
    
    /* deal 3/4's the damage, then 1/4 */
    other.health -= thisPower * (3.0/4.0);
    if (other.health > 0) {
      this.health -= otherPower * (3.0/4.0);
    }
    other.health -= thisPower / 4.0;
    if (other.health > 0) {
      this.health -= otherPower / 4.0;
    }
    
    return thisPower;
  }
  public void displayRange(boolean tint, boolean attack) {
    stroke(255);
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
    int yMin = max(0,y-mvmtRange-attackRangeMax-1); int yMax = min(m.board.length-1,y+mvmtRange+attackRangeMax+1);
    int xMin = max(0,x-mvmtRange-attackRangeMax-1); int xMax = min(m.board[0].length-1,x+mvmtRange+attackRangeMax+1);
    boolean[][] drawnYet = new boolean[yMax-yMin+1][xMax-xMin+1];
    for (int j = 0; j < drawnYet.length; j++) {for (int i = 0; i < drawnYet[j].length; i++) {drawnYet[j][i] = false;}}
    for (int j = yMin; j <= yMax; j++) {
      for (int i = xMin; i <= xMax; i++) {
        if (!attack) {
          if (checkMvmtRange_rec(i,j,0,mvmtRange,false,true,true)) {
            rect(scale*(i+m.left_view)*16,scale*(j+m.top_view)*16,scale*16,scale*16);
            if (i == x && y == j) {render();} else {
              //textSize(20);
              //text("" + m.getTile(i,j).getTerrain().movementCosts[mvmtType],scale*(i+m.left_view)*16+8*scale,scale*(j+m.top_view)*16+8*scale);
              //println((scale*(j+m.left_view)*16+8*scale) + " " + (scale*(j+m.top_view)*16+8*scale) + " " + m.getTile(i,j).getTerrain().movementCosts[mvmtType]);
            }
          }
        }
        else if (canAttack) {
          if (canAttackAndMove ? checkMvmtRange_rec(i,j,0,mvmtRange,false,false,true) : 
          (abs(j-y) + abs(i-x) >= attackRangeMin && abs(j-y) + abs(i-x) <= attackRangeMax)) {
            if (!drawnYet[j-yMin][i-xMin]) {
              rect(scale*(i+m.left_view)*16,scale*(j+m.top_view)*16,scale*16,scale*16);
              drawnYet[j-yMin][i-xMin] = true;
              if (i == x && y == j) {render();}  
            }
            if (canAttackAndMove) {
              if (i+1-xMin < drawnYet[0].length && !drawnYet[j-yMin][i+1-xMin]) {
                rect(scale*(i+1+m.left_view)*16,scale*(j+m.top_view)*16,scale*16,scale*16);
                drawnYet[j-yMin][i+1-xMin] = true;
                if (i+1 == x && y == j) {render();}  
              }
              if (i-1-xMin >= 0 && !drawnYet[j-yMin][i-1-xMin]) {
                rect(scale*(i-1+m.left_view)*16,scale*(j+m.top_view)*16,scale*16,scale*16);
                drawnYet[j-yMin][i-1-xMin] = true;
                if (i-1 == x && y == j) {render();}  
              }
              if (j+1-yMin < drawnYet.length && !drawnYet[j+1-yMin][i-xMin]) {
                rect(scale*(i+m.left_view)*16,scale*(j+1+m.top_view)*16,scale*16,scale*16);
                drawnYet[j+1-yMin][i-xMin] = true;
                if (i == x && y == j+1) {render();}  
              }
              if (j-1-yMin >= 0 && !drawnYet[j-1-yMin][i-xMin]) {
                rect(scale*(i+m.left_view)*16,scale*(j-1+m.top_view)*16,scale*16,scale*16);
                drawnYet[j-1-yMin][i-xMin] = true;
                if (i == x && y == j-1) {render();}  
              }
            }
          }
        }
      }
    }
  }
  private boolean checkMvmtRange_rec(int tx, int ty, int steps, int maxSteps, boolean add, boolean checkFlag, boolean checkAtAll) {
    if (ty < 0 || ty >= m.board.length || tx < 0 || tx >= m.board[0].length) {return false;}
    if (tx == x && ty == y) {return true;}
    Terrain t = m.board[ty][tx].getTerrain();
    if (checkAtAll) {
      if (!airborne && t.movementCosts[mvmtType] == -1) {return false;}
      if (add) {steps += (airborne ?  1 : t.movementCosts[mvmtType]);}
    } else {if (add) {steps++;}}
    if (steps >= maxSteps) {
      return false;
    }
    return checkMvmtRange_rec(tx+1,ty,steps,maxSteps,true,checkFlag,checkAtAll) || checkMvmtRange_rec(tx-1,ty,steps,maxSteps,true,checkFlag,checkAtAll) || 
    checkMvmtRange_rec(tx,ty-1,steps,maxSteps,true,checkFlag,checkAtAll) || checkMvmtRange_rec(tx,ty+1,steps,maxSteps,true,checkFlag,checkAtAll);
  }
  public ArrayList<Unit> checkUnitsInRange() {
    ArrayList<Unit> yesunits = new ArrayList();  
    if (!canAttack) {return yesunits;}
    if (!canAttackAndMove && (lastX != x || lastY != y)) {return yesunits;}
    for (int j = max(0,y-attackRangeMax); j <= min(m.board.length-1,y+attackRangeMax); j++) {
      for (int i = max(0,x-attackRangeMax); i <= min(m.board[0].length-1,x+attackRangeMax); i++) {
        if (m.board[j][i].occupying != null && m.board[j][i].occupying.team != this.team && (abs(i-x) + abs(j-y) >= attackRangeMin && abs(i-x) + abs(j-y) <= attackRangeMax)) {
          if (calcPower(this,m.board[j][i].occupying) != 0) {yesunits.add(m.board[j][i].occupying);}
        }
      }
    }
    return yesunits;
  }
  public void render() {
    if (exploding == -1) {
      if (health > 0) {
        if (true) {
          s.draw(scale*x*16,scale*y*16,scale,team != 0,takenAction ? .8 : 1);
        } else {
          s_alt.draw(scale*x*16,scale*y*16,scale,team != 0,takenAction ? .8 : 1);
        }
        if (ceil(health) < 10) {
          healthIcons[ceil(health)-1].draw(scale*x*16+8*scale,scale*y*16+9*scale,scale,false,true);
        }
      } else {
        unitExploding = true;
        exploding = 0;
        render();
      }
    } else {
      if (exploding >= 45) {
        //destroy unit 
        m.board[y][x].occupying = null;
        (team == 0 ? m.pUnits : m.eUnits).remove(this);
        unitExploding = false;
      } else {
        explosionFrames[exploding/5].draw(scale*(x-1)*16,scale*(y-2)*16+6*scale,scale,false,true);
        exploding++;  
      }
    }
  }
}
