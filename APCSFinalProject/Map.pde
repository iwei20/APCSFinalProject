public class Map {
  int top_view, left_view;
  private Cursor c;
  MenuOption combatMenu;
  int turns;
  int whoseTurn;
  int framesSinceNewTurn;
  boolean gameOver;
  Tile[][] board;
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
  public Map(byte[] data) {
    c = new Cursor(false);
    whoseTurn = playerTeams[0];
    turns = 0;
    gameOver = false;
    pUnits = new ArrayList();
    eUnits = new ArrayList();
    board = new Tile[data[0]][data[1]];

    top_view = 0;left_view = 0;
    int l;
    for (l = 2; data[l] != -128; l += 3) {}
    l++;
    for (; data[l] != -128; l += 3) {}
    l++;
    for (int j = 0; j < board.length; j++) {
      for (int i = 0; i < board[j].length && l < data.length; i++) {
        board[j][i] = new Tile(data[l]);
        l++;
      }  
    }
    // Do map data first so that for Unit constructor board doesnt have any null values
    for (l = 2; data[l] != -128; l += 3) {
      pUnits.add(new Unit(this,data[l],data[l+1],data[l+2],0));
    }
    l++;
    for (; data[l] != -128; l += 3) {
      eUnits.add(new Unit(this,data[l],data[l+1],data[l+2],2));
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
    //background
    for (int layer = 0; layer <= 1; layer++) {
      for (int j = 0; j < board.length; j++) {
        for (int i = 0; i < board[0].length; i++) {
          board[j][i].render(i + left_view,j + top_view,layer);
        }  
      }
    }
    //"sprites"
    if (!unitExploding && !gameOver) {
      if (pUnits.size() == 0) {win(1);}
      if (eUnits.size() == 0) {win(0);}
      
      if (!inCombatMenu && c != null) {c.render(true, c.x, c.y);}
    }
    
    if (framesSinceNewTurn >= 0) {
      framesSinceNewTurn++;
      if (framesSinceNewTurn >= 90) {framesSinceNewTurn = -1;}
      teamIcons[whoseTurn].draw(width/32,height/32,scale);
      
      int xd = width/32+scale*51;
      for (char c : ((turns/2+1) + "").toCharArray()) {
        numberSprites[c-0x30].draw(xd,height/32+7*scale,scale);
        xd += 7*scale;
      }
    }
    
    // menu
    if (inCombatMenu && combatMenu != null) {combatMenu.render();}
    
  }
  
  public void win(int player) {
    gameOver = true;
    println("Player " + (player+1) + " wins!");
  }
}
