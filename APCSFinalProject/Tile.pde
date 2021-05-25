public class Tile {
  private Terrain t;
  private List<Tile> adjacents;
  private List<TileSubobject> subobjects;
  
  public Tile() {
    
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
  
  public void render(int pos_x, int pos_y) {
    
  }
}
