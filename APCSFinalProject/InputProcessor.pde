ArrayList<Unit> possibleAttacks = null;
String selectedAction = null; 

void parseInput() {
  if (inCombatMenu) {
    if (m.combatMenu.unitTargets == null) {
      if (keyCode == 'W') {
        m.combatMenu.moveCursorUp();
      }
      if (keyCode == 'S') {
        m.combatMenu.moveCursorDown();
      }
      /* doesnt work fully */
      if (keyCode == 'U') {
        if (m.getCursor().selected != null) {
          m.getCursor().selected.undoMove();
        }
        inCombatMenu = false;
      }
      if (keyCode == 'I') {
        selectedAction = m.combatMenu.getOption();
        switch(selectedAction) {
          case "Wait":
            possibleAttacks = null;
            break;
          case "Fire":
            m.combatMenu.initSelection(m.getCursor().selected, possibleAttacks);
            break;
          case "Unit":
          case "Save":
          case "Options":
            break;
          case "End":
            //selectedAction = null;
            //m.getCursor().selected = null; 
            inCombatMenu = false;
            m.nextTurn();
            break; //<>//
            
        }
        if (selectedAction.equals("Wait")) {
          selectedAction = null;
          if (m.getCursor().selected != null) {m.getCursor().selected.setActionTaken();}
          m.getCursor().selected = null; 
          inCombatMenu = false;
        }
      }
    } else {
      if (keyCode == 'A') {
        m.combatMenu.prevUnit();
      }
      if (keyCode == 'D') {
        m.combatMenu.nextUnit();
      }
      if (keyCode == 'U') {
        m.combatMenu.destSelection();  
      }
      if (keyCode == 'I') {
        switch (selectedAction) {
          case "Fire":
            m.getCursor().selected.attack(m.combatMenu.getSelectedUnit());
            break;
        }
        m.combatMenu.destSelection();  
        m.getCursor().selected.setActionTaken();
        m.getCursor().selected = null; 
        inCombatMenu = false;
      }
    }
  } else if (!unitExploding){
    if (showRange != null) {keyCode = 'U';}
    
    if (keyCode == 'W') { 
      if (showRange == null) {
        if(m.getCursor().y <= 0) {
          m.getCursor().y = 0;
        } else {
          if(m.getCursor().y + m.top_view <= 0) m.shift(0, 1); 
          m.moveCursor(0, -1);
        }
      }
    }
    if (keyCode == 'A') { 
      if (showRange == null) {
        if(m.getCursor().x <= 0) {
          m.getCursor().x = 0;
        } else {
          if(m.getCursor().x + m.left_view <= 0) m.shift(1, 0);
          m.moveCursor(-1, 0);
        }
      }
    }
    if (keyCode == 'S') { 
      if (showRange == null) {
        if(m.getCursor().y >= m.board.length - 1) {
          m.getCursor().y = m.board.length-1;
        } else {
          if(m.getCursor().y + m.top_view >= height / 32 - 1) m.shift(0, -1); 
          m.moveCursor(0, 1);
        }
      }
    }
    if (keyCode == 'D') { 
      if (showRange == null) {
        if(m.getCursor().x >= m.board[0].length - 1) {
          m.getCursor().x = m.board[0].length-1;
        } else {
          if(m.getCursor().x + m.left_view >= width / 32 - 1) m.shift(-1, 0); 
          m.moveCursor(1, 0);
        }
      }
    }
    if (keyCode == 'I')  {
      if (m.getCursor().selected == null) {
        if (m.getTile(m.getCursorX(),m.getCursorY()).occupying == null) {
          inCombatMenu = true;
          m.combatMenu = new MenuOption(new String[]{"Unit","Save","Options","End"},"GUI/MainMenu.png");
        } else if (!m.getTile(m.getCursorX(),m.getCursorY()).occupying.takenAction && 
                    m.getTile(m.getCursorX(),m.getCursorY()).occupying.exploding == -1 && 
                    m.getTile(m.getCursorX(),m.getCursorY()).occupying.team == m.whoseTurn) {
          m.getCursor().selected = m.getTile(m.getCursorX(),m.getCursorY()).occupying;
          m.getCursor().storex = m.getCursor().x;
          m.getCursor().storey = m.getCursor().y;
        }
      } else if (/*m.getCursor().selected != null && */m.getCursor().selected.team == m.whoseTurn) {
        if(m.getCursor().selected.move(m.getCursorX(),m.getCursorY())) {
          inCombatMenu = true;
          possibleAttacks = m.getCursor().selected.checkUnitsInRange();
          m.combatMenu = new MenuOption(possibleAttacks.size() > 0,false,false);
          //m.getCursor().selected = null; 
          //m.getCursor().Iactive = false;
        }
      }
    }
    if (keyCode == 'U') {
      if (m.getCursor().selected != null) {
        m.getCursor().selected = null;
        m.getCursor().x = m.getCursor().storex;
        m.getCursor().y = m.getCursor().storey;
      } else {
        if (m.getTile(m.getCursorX(),m.getCursorY()).occupying != null) {
          showRange = m.getTile(m.getCursorX(),m.getCursorY()).occupying;
        }
      }
    } else {
      showRange = null; 
    }
  }
}
