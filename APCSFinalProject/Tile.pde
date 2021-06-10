public class Tile {
  Terrain t;
  Unit occupying;
  Captureable base;
  
  public Tile(int type, int subtype) {
    if(type == 6) type = 8;
    t = new Terrain(type, subtype);
    occupying = null;
    base = null;
    if (type >= 8 && type <= 12) {
      base = new Captureable(type == 8 ? -1 : playerTeams[(type - 9) % 2],type >= 11,false);    
    }
    if (type >= 13 && type <= 15) {
      base = new Captureable(type == 13 ? -1 : playerTeams[type-14],false,true);  
    }
  }
  
  public Terrain getTerrain() {
    return t; 
  }
  public void render(int pos_x, int pos_y,int layer) {
    switch (layer) {
      case 0:
        t.s.draw(pos_x*scale*16,pos_y*scale*16,scale);
        if (base != null) {base.render(pos_x,pos_y);}
        break;
      case 1: 
        if (occupying != null) {occupying.render();}
        break;
    }
  }
  
  public boolean baseCanCapt() {
    return base != null && occupying != null && (occupying.index == 2 || occupying.index == 3) && base.canBeCaptured(occupying); 
  }
  public boolean enactCapt() {
    if (baseCanCapt()) {
      base.capt(occupying);
      return true;  
    } else {
      return false;
    }
  }
}
