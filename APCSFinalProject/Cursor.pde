class Cursor {
  int x;
  int y;
  int storex,storey;
  Sprite s;
  Unit selected;
  
  public Cursor() {
    x = 0;
    y = 0;
    s = new Sprite("Cursor.png");
    selected = null;
  }
  void render() {
    s.draw((-3 * scale)+x*scale*16,(-4 * scale)+y*scale*16,scale,false);
    if (selected != null) {selected.displayRange(false);}
  }
}
