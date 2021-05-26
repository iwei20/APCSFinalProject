public class Tile {
  private Terrain t;
  private ArrayList<Tile> adjacents;
  private ArrayList<TileSubobject> subobjects;
  boolean occupied;
  
  public Tile(int type) {
    t = new Terrain(type);
  }
  
  public Terrain getTerrain() {
    return t; 
  }
  
  public ArrayList<Tile> getAdjacents() {
    return adjacents;
  }
  
  public ArrayList<TileSubobject> getSubobjects() {
    return subobjects;
  }
  public void render(int pos_x, int pos_y) {
    t.s.draw(pos_x*scale*16,pos_y*scale*16,scale);
  }
}
