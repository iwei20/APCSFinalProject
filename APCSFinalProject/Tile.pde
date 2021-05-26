public class Tile {
  Terrain t;
  Unit occupying;
  boolean occupied;
  
  public Tile(int type) {
    t = new Terrain(type);
    occupying = null;
  }
  
  public Terrain getTerrain() {
    return t; 
  }
  public void render(int pos_x, int pos_y) {
    t.s.draw(pos_x*scale*16,pos_y*scale*16,scale);
  }
}
