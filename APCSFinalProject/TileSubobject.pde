public class TileSubobject {
  private Tile parent;
  private int layer;
  private TileSprite spr;
  
  public TileSubobject(Tile parent, int layer, TileSprite spr) {
    this.parent = parent;
    this.layer = layer;
    this.spr = spr;
  }
  
  public TileSubobject(Tile parent, int layer, String imgPath) {
    this.parent = parent;
    this.layer = layer;
    this.spr = new TileSprite(imgPath);
  }
  
  public Tile getHoldingTile() {
    
  }
  
  public Tile setHoldingTile(Tile newTile) {
    
  }
  
  public void render(int pos_x, int pos_y) {
        
  }
}
