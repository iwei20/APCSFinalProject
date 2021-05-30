public class Tile {
  Terrain t;
  Unit occupying;
  Captureable base;
  
  public Tile(int type) {
    t = new Terrain(type);
    occupying = null;
    base = null;
    if (type >= 8 && type <= 10) {
        
    }
  }
  
  public Terrain getTerrain() {
    return t; 
  }
  public void render(int pos_x, int pos_y,int layer) {
    switch (layer) {
      case 0:
        t.s.draw(pos_x*scale*16,pos_y*scale*16,scale);
        break;
      case 1: 
        if (occupying != null) {occupying.render();}
        break;
    }
  }
}
