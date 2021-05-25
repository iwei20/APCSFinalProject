public class Tile {
  private Terrain t;
  private ArrayList<Tile> adjacents;
  private ArrayList<TileSubobject> subobjects;
  boolean occupied;
  
  public Tile(type t) {
    t = new Terrain(t);
  }
  
  public Terrain getTerrain() {
    return t; 
  }
  
  public List<Tile> getAdjacents() {
    return adjacents;
  }
  
  public List<TileSubobject> getSubobjects() {
    return subobjects;
  }
  
  public void render(int pos_x, int pos_y,int scale) {
    
  }
}
