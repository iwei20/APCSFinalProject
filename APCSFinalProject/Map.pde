public class Map {
  int top_view, left_view;
  private Cursor c;
  MenuOption combatMenu;
  int whoseTurn;
  Tile[][] board;
  private ArrayList<Unit> pUnits, eUnits;
  
  public Map(int rows, int cols) {
    c = new Cursor();
    pUnits = new ArrayList();
    eUnits = new ArrayList();
    whoseTurn = 0;
    board = new Tile[cols][rows];
    top_view = 0; left_view = 0; 
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
    c = new Cursor();
    whoseTurn = 0;
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
    whoseTurn = (whoseTurn == 0 ? 1 : 0);
    if (whoseTurn == 0) {
      for (int i = 0; i < pUnits.size(); i++) {
        pUnits.get(i).newTurn(); 
      }
    } else {
      for (int i = 0; i < eUnits.size(); i++) {
        eUnits.get(i).newTurn(); 
      }
    }
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
    if (!inCombatMenu && c != null) {c.render(true, c.x + left_view, c.y + top_view);}
    if (inCombatMenu && combatMenu != null) {combatMenu.render();}
  }
}
