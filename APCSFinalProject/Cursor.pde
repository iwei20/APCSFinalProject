class Cursor {
  int x;
  int y;
  Sprite s;
  
  public Cursor() {
    x = 0;
    y = 0;
    s = new Sprite("Cursor.png");
  }
  void render() {
    s.draw((-3 * scale)+x*scale*16,(-4 * scale)+y*scale*16,scale,false);  
  }
}
