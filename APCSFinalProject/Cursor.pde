class Cursor {
  int x;
  int y;
  int storex,storey;
  Sprite[] s;
  int frame;
  boolean AttackCursor;
  Unit selected;
  
  public Cursor(boolean targetCursor) {
    x = 0;
    y = 0;
    frame = 0;
    AttackCursor = targetCursor;
    s = new Sprite[4];
    for (int i = 0; i < s.length; i++) {
      s[i] = new Sprite((targetCursor ? "TargetCursor" : "Cursor") + i + ".png");
    }   
    selected = null;  
  }
  void render(boolean t, int pos_x, int pos_y) {
    render(t,pos_x,pos_y,null);
  }
  void render(boolean t, int pos_x, int pos_y, Unit AttackUnit) {
    if (AttackCursor && AttackUnit != null) {
      noStroke();
      switch(AttackUnit.team) {
        case 0:
          fill(255,0,0,75);
          break;
        case 1:
          fill(0,120,0,75);
          break;
        case 2:
          fill(0,0,255,75);
          break;
        case 3:
          fill(255,255,0,75);
          break;
        case 4:
          fill(128,128,128,75);
          break;
      }
      rect((pos_x+m.left_view)*scale*16,(pos_y+m.top_view)*scale*16,scale*16,scale*16);
    }
    
    if (selected != null) {selected.displayRange(false,false);}
    s[frame/15].draw(((AttackCursor ? -5 : -3) * scale)+(pos_x+m.left_view)*scale*16,((AttackCursor ? -5 : -4) * scale)+(pos_y+m.top_view)*scale*16,scale,false);   
    if (t) {frame = (frame + (AttackCursor ? 3 : 2)) % 60;}
  }
}
