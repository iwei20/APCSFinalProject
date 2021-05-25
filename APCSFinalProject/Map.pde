public class Map {
  private int top_view, bot_view, left_view, right_view;
  private Cursor c;
  private Tile[][] board;
  
  public Map(int rows, int cols) {
    board = new Tile[cols][rows];
  }
  
  public Tile getTile(int x, int y) {
    return board[x][y];
  }
  
  public Cursor getCursor() {
    return c;
  }
  
  public void render() {
    
  }
}
