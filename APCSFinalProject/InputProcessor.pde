void parseInput() {
  if (inCombatMenu) {
    if (keyCode == 'W') {
      m.combatMenu.moveCursorUp();
    }
    if (keyCode == 'S') {
      m.combatMenu.moveCursorDown();
    }
    /* doesnt work fully */
    if (keyCode == 'U') {
      m.getCursor().selected.undoMove();
      inCombatMenu = false;
    }
    if (keyCode == 'I') {
      switch(m.combatMenu.getOption()) {
        case "Wait":
          break;
        case "Fire":
          break;
      }
      m.getCursor().selected.setActionTaken();
      m.getCursor().selected = null; 
      inCombatMenu = false;
    }
  } else {
    if (showRange != null) {keyCode = 'U';}
    
    if (keyCode == 'W') { 
      if (showRange == null) {
        if(m.getCursor().y + m.top_view <= 0) {
          //m.getCursor().y = 0;
          m.shift(0, 1);
        } else {
          m.moveCursor(0, -1);
        }
      }
    }
    if (keyCode == 'A') { 
      if (showRange == null) {
        if(m.getCursor().x + m.left_view <= 0) {
          //m.getCursor().x = 0;
          m.shift(1, 0);
        } else {
          m.moveCursor(-1, 0);
        }
      }
    }
    if (keyCode == 'S') { 
      if (showRange == null) {
        if(m.getCursor().y >= m.board.length - 1) {
          m.getCursor().y = m.board.length-1;
          m.shift(0, -1);
        } else {
          m.moveCursor(0, 1);
        }
      }
    }
    if (keyCode == 'D') { 
      if (showRange == null) {
        if(m.getCursor().x >= m.board[0].length - 1) {
          m.getCursor().x = m.board[0].length-1;
          m.shift(-1, 0);
        } else {
          m.moveCursor(1, 0);
        }
      }
    }
    if (keyCode == 'I')  {
      if (m.getCursor().selected == null && m.getTile(m.getCursor().x,m.getCursor().y).occupying != null  && !m.getTile(m.getCursor().x,m.getCursor().y).occupying.takenAction) {
        m.getCursor().selected = m.getTile(m.getCursor().x,m.getCursor().y).occupying;
        m.getCursor().storex = m.getCursor().x;
        m.getCursor().storey = m.getCursor().y;
      } else if (m.getCursor().selected != null && m.getCursor().selected.team == m.whoseTurn) {
        if(m.getCursor().selected.move(m.getCursor().x,m.getCursor().y)) {
          inCombatMenu = true;
          m.combatMenu = new MenuOption(/* this one should be a check for units in range */true,false,false); //<>//
          //m.getCursor().selected = null; 
          //m.getCursor().Iactive = false;
        }
      }
    }
    if (keyCode == 'U') {
      if (m.getCursor().selected != null) { //<>//
        m.getCursor().selected = null;
        m.getCursor().x = m.getCursor().storex;
        m.getCursor().y = m.getCursor().storey;
      } else {
        if (m.getTile(m.getCursor().x,m.getCursor().y).occupying != null) {
          showRange = m.getTile(m.getCursor().x,m.getCursor().y).occupying;
        }
      }
    } else {
      showRange = null; 
    }
  }
}
