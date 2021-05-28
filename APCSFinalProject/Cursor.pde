class Cursor {
  int x;
  int y;
  int storex,storey;
  Sprite[] s;
  int frame;
  Unit selected;
  
  public Cursor() {
    x = 0;
    y = 0;
    frame = 0;
    s = new Sprite[4];
    for (int i = 0; i < s.length; i++) {
      s[i] = new Sprite("Cursor" + i + ".png");
    }
    selected = null;
  }
  void render(boolean t, int pos_x, int pos_y) {
    if (selected != null) {selected.displayRange(false,false);}
    s[frame/15].draw((-3 * scale)+pos_x*scale*16,(-4 * scale)+pos_y*scale*16,scale,false);   
    if (t) {frame = (frame + 2) % 60;}
  }
}
