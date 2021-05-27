public class Tile {
  Terrain t;
  Unit occupying;
  
  public Tile(int type) {
    t = new Terrain(type);
    occupying = null;
  }
  
  public Terrain getTerrain() {
    return t; 
  }
  public void render(int pos_x, int pos_y) {
    t.s.draw(pos_x*scale*16,pos_y*scale*16,scale);
    if (occupying != null) {occupying.render(pos_x,pos_y);}
  }
}
