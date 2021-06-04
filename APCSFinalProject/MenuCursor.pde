class MenuCursor {
  Sprite s;
  int frame;
  int intermed;
  
  public MenuCursor() {  
    s = new Sprite(loadImage("MenuCursor.png"));
  }
  
  public void render(int baseX, int baseY) {
    if (inCombatMenu || m.pMenu.active) {
      s.draw((int)(-3 * scale * pow(cos(frame*24/180.0),2))+baseX,baseY,scale,false,false);   
    }
    intermed++;
    if(intermed >= 4) {
      frame+= 4;
      intermed = 0;
    }
  }
}
