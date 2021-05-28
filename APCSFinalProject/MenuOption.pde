class MenuOption {
  String[] options;
  MenuCursor cursor;
  int cursor_y;
  Sprite s;
  
  public MenuOption(boolean canFire, boolean canLoad, boolean canDrop) {
    cursor_y = 0;
    cursor = new MenuCursor();
    switch ((canFire ? 1 : 0) + (canLoad ? 2 : 0) + (canDrop ? 4 : 0)) {
      case 0:
        s = new Sprite("GUI/WaitMenu.png");
        options = new String[]{"Wait"};
        break;
      case 1:
        s = new Sprite("GUI/FireMenu.png");
        options = new String[]{"Fire","Wait"};
        break;
    }
  }
  
  public void moveCursorDown() {
    cursor_y = min(options.length-1,cursor_y+1);
  }
  public void moveCursorUp() {
    cursor_y = max(0,cursor_y-1);
  }
  public String getOption() {
    return options[cursor_y];  
  }
  public void render() {
    s.draw(width*5/8-10*scale,width/16,scale,false,false);
    cursor.render(width*5/8-20*scale,width/16+10*scale+cursor_y*scale*16);  
  }
}
