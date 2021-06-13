class MenuOption {
  int render_x, render_y;
  int c_render_x, c_render_y;
  String[] options;
  MenuCursor cursor;
  int cursor_y;
  Sprite s;
  DamagePreview dp;
  
  ArrayList<Unit> unitTargets;
  Cursor unit_cursor;
  int selectedUnit;
  
  public MenuOption(boolean canFire, boolean canCapt, boolean canLoad, boolean canDrop) {
    unit_cursor = null;
    unitTargets = null;
    
    render_x = width*5/8-10*scale;   render_y = width/16;
    c_render_x = width*5/8-20*scale; c_render_y = width/16+10*scale; 
    
    cursor_y = 0;
    cursor = new MenuCursor();
    switch ((canFire ? 1 : 0) + (canCapt ? 2 : 0) + (canLoad ? 4 : 0) + (canDrop ? 8 : 0)) {
      case 0:
        s = new Sprite("GUI/WaitMenu.png");
        options = new String[]{"Wait"};
        break;
      case 1:
        s = new Sprite("GUI/FireMenu.png");
        options = new String[]{"Fire","Wait"};
        break;
      case 2:
        s = new Sprite("GUI/CaptWaitMenu.png");
        options = new String[]{"Capt","Wait"};
        break;
      case 3:
        s = new Sprite("GUI/FireCaptMenu.png");
        options = new String[]{"Fire","Capt","Wait"};
        break;
    }
    dp = new DamagePreview(null, null);
  }
  public MenuOption(String[] mOptions, String filepath) {
    unit_cursor = null;
    unitTargets = null;
    
    render_x = width/32;   render_y = width/24;
    c_render_x = width/32-7*scale; c_render_y = width/24+10*scale;
    cursor_y = 0;
    cursor = new MenuCursor();
    s = new Sprite(filepath);
    options = new String[mOptions.length];
    arrayCopy(mOptions,options);
  }
  
  public void moveCursorDown() {
    cursor_y++;
    if(cursor_y >= options.length) cursor_y = 0;
  }
  public void moveCursorUp() {
    cursor_y--;
    if(cursor_y <= -1) cursor_y = options.length - 1;
  }
  public String getOption() {
    return options[cursor_y];  
  }
  
  public void initSelection(Unit attacker, ArrayList<Unit> targets) {
    unitTargets = targets;
    unit_cursor = new Cursor(attacker.carrying == null);
    selectedUnit = 0;
    unit_cursor.x = targets.get(selectedUnit).x;
    unit_cursor.y = targets.get(selectedUnit).y;
    dp = new DamagePreview(attacker,targets.get(0));
    dp.attacker = attacker;
    dp.target = targets.get(selectedUnit);
  }
  public void destSelection() {
    unitTargets = null;
    unit_cursor = null;
  }
  public void nextUnit() {
    selectedUnit = (selectedUnit + 1) % unitTargets.size();
    unit_cursor.x = unitTargets.get(selectedUnit).x;
    unit_cursor.y = unitTargets.get(selectedUnit).y;  
    dp.target = unitTargets.get(selectedUnit);
  }
  public void prevUnit() {
    selectedUnit--;
    if (selectedUnit < 0) {selectedUnit = unitTargets.size() - 1;}
    unit_cursor.x = unitTargets.get(selectedUnit).x;
    unit_cursor.y = unitTargets.get(selectedUnit).y; 
    dp.target = unitTargets.get(selectedUnit);
  }
  public Unit getSelectedUnit() {
    return unitTargets.get(selectedUnit);  
  }
  
  public void render() {
    if (unitTargets == null) {
      s.draw(render_x,render_y,scale,false,false);
      cursor.render(c_render_x,c_render_y+cursor_y*scale*16);  
    } else {
      unit_cursor.render(true,unit_cursor.x,unit_cursor.y,unitTargets.get(selectedUnit));  
      if(dp.hasUnits() && dp.attacker.carrying == null) dp.display();
    }
  }
}
