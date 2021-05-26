class TileSprite {
  private Sprite s;
  
  public TileSprite(PImage img) {
    s = new Sprite(img);
  }
  public TileSprite(String path) {
    s = new Sprite(path); 
  }
  public TileSprite copy() {
     return new TileSprite(s.dat);
  }
  public void draw(int x, int y, int scale, boolean hFlip) {
    s.draw(x,y,scale,hFlip);
  }
}
