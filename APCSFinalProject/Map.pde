public class Map {
  int top_view, left_view;
  private Cursor c;
  MenuOption combatMenu;
  ProductionMenu pMenu;
  int turns;
  int whoseTurn;
  int framesSinceNewTurn;
  Tile[][] board;
  int[] money;
  private ArrayList<Unit> pUnits, eUnits;
  
  public Map(int rows, int cols) {
    c = new Cursor(false);
    pUnits = new ArrayList();
    eUnits = new ArrayList();
    whoseTurn = playerTeams[0];
    turns = 0;
    board = new Tile[cols][rows];
    top_view = 0; left_view = 0; 
    gameOver = false;
  }
  /* 
  Map data format: 
  first 2 bytes = width & length
  all bytes until first FF byte = unit data
  3 bytes per, which are the x,y,unit type;
  after which is enemy unit data until the second FF byte, same format
  afterwards is map data according to the size given;
  */
  public Map(byte[] data) throws IOException {
    c = new Cursor(false);
    whoseTurn = playerTeams[0];
    turns = 0;
    gameOver = false;
    pUnits = new ArrayList();
    eUnits = new ArrayList();
    board = new Tile[data[0]][data[1]];
    money = new int[4];
    for (int i = 0; i < money.length; i++) {money[i] = 8000;}
    
    top_view = 0;left_view = 0;
    int l;
    for (l = 2; data[l] != -128; l += 3) {}
    l++;
    for (; data[l] != -128; l += 3) {}
    l++;
    for (int j = 0; j < board.length; j++) {
      for (int i = 0; i < board[j].length && l < data.length; i++) {
        board[j][i] = new Tile(data[l], l + 1 + board.length * board[j].length < data.length ? data[l + 1 + board.length * board[j].length] : 0);
        l++;
      }  
    }
    
    // Do map data first so that for Unit constructor board doesnt have any null values
    for (l = 2; data[l] != -128; l += 3) {
      pUnits.add(new Unit(this,data[l],data[l+1],data[l+2],playerTeams[0]));
    }
    l++;
    for (; data[l] != -128; l += 3) {
      eUnits.add(new Unit(this,data[l],data[l+1],data[l+2],playerTeams[1]));
    }
    l++;
  }
  public void nextTurn() {
    whoseTurn = playerTeams[(whoseTurn == playerTeams[0] ? 1 : 0)];
    for (int i = 0; i < pUnits.size(); i++) {
      pUnits.get(i).newTurn(whoseTurn == playerTeams[0]); 
    }
    for (int i = 0; i < eUnits.size(); i++) {
      eUnits.get(i).newTurn(whoseTurn == playerTeams[1]); 
    }
    for (int i = 0; i < board.length; ++i) {
      for (int j = 0; j < board[0].length; ++j) {
        if(getTile(j, i).base != null) {
          getTile(j, i).base.hasProduced = false;
          if (getTile(j,i).base.team == whoseTurn && turns != 0) {
            money[whoseTurn] = min(99000,money[whoseTurn]+1000);
          }
        }
      }
    }
    turns++;
    newTurn();
  }
  public void newTurn() {
    framesSinceNewTurn = 0;  
  }
  public Tile getTile(int x, int y) {
    return board[y][x];
  }
  public int getHeight() {
    return board.length;  
  }
  public int getWidth() {
    return board[0].length;  
  }
  
  public Cursor getCursor() {
    return c;
  }
  public int getCursorX() {
    return c.x + left_view;
  }
  public int getCursorY() {
    return c.y + top_view;
  }
  
  public void moveCursor(int dx, int dy) {
    c.y += dy;
    c.x += dx;
  }
  
  public void shift(int dx, int dy) {
    top_view = min(top_view+dy,0);
    left_view = min(left_view+dx,0);
  }
  
  public void render() {
    boolean[] checkUnits = new boolean[5];
    boolean checkBase = false;
    for (int i = 0; i < checkUnits.length; i++) {checkUnits[i] = false;}
    
    if (!gameOver || gameOverTime < 75) { 
      //background
      for (int layer = 0; layer <= 1; layer++) {
        for (int j = 0; j < board.length; j++) {
          for (int i = 0; i < board[0].length; i++) {
            board[j][i].render(i + left_view,j + top_view,layer);
            if (board[j][i].base != null && board[j][i].base.canProduce) {
              checkUnits[board[j][i].base.team] = true;  
              checkBase = true;
            }
          }  
        }
      }
      //"sprites"
      if (!gameOver) {
        if (!unitExploding) {
          if (checkUnits[playerTeams[0]] == false && pUnits.size() == 0) {win(1);}
          if (checkUnits[playerTeams[1]] == false && eUnits.size() == 0) {win(0);}
          
          if (!gameOver && !inCombatMenu && c != null && (pMenu == null || (pMenu != null && !pMenu.active))) {c.render(true, c.x, c.y);}
        }
        int turn_x = width/64; 
        if(getCursorX() <= width / 64) {
          turn_x = width - teamIcons[whoseTurn].dat.width * scale - width / 64;
        }
        (checkBase ? teamMoneyIcons[whoseTurn] : teamIcons[whoseTurn]).draw(turn_x, height/64,scale);
          
        int xd = turn_x+scale*(checkBase ? 30 : 51);
        for (char c : ((checkBase ? money[whoseTurn] : (turns/2+1)) + "").toCharArray()) {
          numberSprites[c-0x30].draw(xd,height/64+7*scale,scale);
          xd += 7*scale;
        }
        // menu
        if (inCombatMenu && combatMenu != null) {combatMenu.render();}
        if(pMenu != null && pMenu.active) pMenu.render();
      }
    }
  }
  
  public void win(int player) {
    if (gameOver) {return;}
    gameOver = true;
    winningPlayer = playerTeams[player];
    gameOverTime = 0;
    println("Player " + (player+1) + " wins!");
  }
}
