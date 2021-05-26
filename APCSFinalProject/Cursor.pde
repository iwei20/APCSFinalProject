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
  void render() {
    s[frame/15].draw((-3 * scale)+x*scale*16,(-4 * scale)+y*scale*16,scale,false);
    frame = (frame + 2) % 60;
    if (selected != null) {selected.displayRange(false);}
  }
}
