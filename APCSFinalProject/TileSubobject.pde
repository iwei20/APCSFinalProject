public class TileSubobject {
  private Tile parent;
  private int layer;
  private Sprite spr;
  
  public TileSubobject(Tile parent, int layer, Sprite spr) {
    this.parent = parent;
    this.layer = layer;
    this.spr = spr;
  }
  
  public TileSubobject(Tile parent, int layer, String imgPath) {
    this.parent = parent;
    this.layer = layer;
    this.spr = new Sprite(loadImage(imgPath));
  }
  
  public Tile getHoldingTile() {
    return this.parent;
  }
  
  public Tile setHoldingTile(Tile newTile) {
    Tile oldParent = this.parent;
    this.parent = newTile;
    //this.parent.addChild(this); 
    return oldParent;
  }
  public void render(int pos_x, int pos_y) {
      spr.draw(pos_x,pos_y,scale);  
  }
}
