class MenuOption {
  String[] options;
  MenuCursor cursor;
  int cursor_y;
  Sprite s;
  
  ArrayList<Unit> unitTargets;
  Cursor unit_cursor;
  int selectedUnit;
  
  public MenuOption(boolean canFire, boolean canLoad, boolean canDrop) {
    unit_cursor = null;
    unitTargets = null;
    
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
  
  public void initSelection(ArrayList<Unit> targets) {
    unitTargets = targets;
    unit_cursor = new Cursor();
    selectedUnit = 0;
    unit_cursor.x = targets.get(selectedUnit).x;
    unit_cursor.y = targets.get(selectedUnit).y;
  }
  public void destSelection() {
    unitTargets = null;
    unit_cursor = null;
  }
  public void nextUnit() {
    selectedUnit = (selectedUnit + 1) % unitTargets.size();
    unit_cursor.x = unitTargets.get(selectedUnit).x;
    unit_cursor.y = unitTargets.get(selectedUnit).y;  
  }
  public void prevUnit() {
    selectedUnit--;
    if (selectedUnit < 0) {selectedUnit = unitTargets.size() - 1;}
    unit_cursor.x = unitTargets.get(selectedUnit).x;
    unit_cursor.y = unitTargets.get(selectedUnit).y; 
  }
  public Unit getSelectedUnit() {
    return unitTargets.get(selectedUnit);  
  }
  
  public void render() {
    if (unitTargets == null) {
      s.draw(width*5/8-10*scale,width/16,scale,false,false);
      cursor.render(width*5/8-20*scale,width/16+10*scale+cursor_y*scale*16);  
    } else {
      unit_cursor.render(true,unit_cursor.x,unit_cursor.y);  
    }
  }
}
