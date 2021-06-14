import java.util.*;

ArrayList<Unit> possibleAttacks = null;
String selectedAction = null; 
Unit tu;
Tile tt;

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
          if (tu != null && tt != null) {tt.occupying = tu;}
        }
        tu = null;
        tt = null;
        inCombatMenu = false;
      }
      if (keyCode == 'I') {
        selectedAction = m.combatMenu.getOption();
        switch(selectedAction) {
          case "Wait":
            possibleAttacks = null;
            break;
          case "Load":
            tu.loadUnit(m.getCursor().selected);
            tt.occupying = tu;
            tt = null;
            tu = null;
            selectedAction = "Wait";
            possibleAttacks = null;
            break;
          case "Fire": //<>//
            m.combatMenu.initSelection(m.getCursor().selected, possibleAttacks);
            break;
          case "Drop":
            m.combatMenu.initSelection(m.getCursor().selected, possibleAttacks);
            break;
          case "Capt":
            if (m.getTile(m.getCursor().selected.x,m.getCursor().selected.y).enactCapt()) {selectedAction = "Wait";}
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
            break; //<>// //<>//
            
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
          case "Drop":
            m.getCursor().selected.dropUnit(m.combatMenu.getSelectedUnit().x,m.combatMenu.getSelectedUnit().y);
            selectedAction = "Fire";
            break;
            
        }
        if (selectedAction.equals("Fire")) {
          m.combatMenu.destSelection();  
          m.getCursor().selected.setActionTaken();
          m.getCursor().selected = null; 
          inCombatMenu = false;
        }
      }
    }
  } else if(m.pMenu != null && m.pMenu.active) {
    if (keyCode == 'I') {
      m.getTile(m.pMenu.target_x, m.pMenu.target_y).base.hasProduced = m.pMenu.createUnit();
      m.pMenu.active = false;
    }
    if (keyCode == 'U') {
      m.pMenu.active = false;
    }
    if (keyCode == 'W') {
      if(m.pMenu.curr_mc_index > 0) {
        m.pMenu.curr_mc_index--;
        if(m.pMenu.curr_mc_index < m.pMenu.top_index) {
          m.pMenu.top_index--;
        }
      }
    }
    if (keyCode == 'S') {
      if(m.pMenu.curr_mc_index < m.pMenu.options.size() - 1) {
        m.pMenu.curr_mc_index++;
        if(m.pMenu.curr_mc_index > m.pMenu.top_index + 4) {
          m.pMenu.top_index++;
        }
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
        if (m.getTile(m.getCursor().x,m.getCursor().y).occupying == null) {
          if(m.getTile(m.getCursor().x, m.getCursor().y).base != null && 
             m.getTile(m.getCursor().x, m.getCursor().y).base.canProduce &&
             !m.getTile(m.getCursor().x, m.getCursor().y).base.hasProduced &&
             m.getTile(m.getCursor().x, m.getCursor().y).base.team == m.whoseTurn) {
            m.getTile(m.getCursor().x, m.getCursor().y).base.openProduction(m.getCursor().x, m.getCursor().y);
          } else {
            inCombatMenu = true;
            m.combatMenu = new MenuOption(new String[]{"Unit","Save","Options","End"},"GUI/MainMenu.png");
          }
        } else if (!m.getTile(m.getCursor().x,m.getCursor().y).occupying.takenAction && 
                    m.getTile(m.getCursor().x,m.getCursor().y).occupying.exploding == -1 /*&& 
                    m.getTile(m.getCursor().x,m.getCursor().y).occupying.team == m.whoseTurn*/) {
          m.getCursor().selected = m.getTile(m.getCursor().x,m.getCursor().y).occupying;
          m.getCursor().storex = m.getCursor().x;
          m.getCursor().storey = m.getCursor().y;
        }
      } else if (/*m.getCursor().selected != null && */m.getCursor().selected.team == m.whoseTurn) {
        if(m.getCursor().selected.move(m.getCursor().x,m.getCursor().y)) {
          inCombatMenu = true;
          if (m.getCursor().selected.carrying == null) {
            possibleAttacks = m.getCursor().selected.checkUnitsInRange();
            m.combatMenu = new MenuOption(possibleAttacks.size() > 0,m.getTile(m.getCursor().selected.x,m.getCursor().selected.y).baseCanCapt(),false,false);
            //m.getCursor().selected = null; 
            //m.getCursor().Iactive = false;
          } else {
            possibleAttacks = new ArrayList(4);
            if (m.getCursor().selected.x < m.board[0].length - 1 && m.getCursor().selected.canDropUnit(m.getCursor().selected.x+1,m.getCursor().selected.y)) {
              possibleAttacks.add(new Unit(m.getCursor().selected.x+1,m.getCursor().selected.y,m.getCursor().selected.team+1));
            }
            if (m.getCursor().selected.x >= 1 && m.getCursor().selected.canDropUnit(m.getCursor().selected.x-1,m.getCursor().selected.y)) {
              possibleAttacks.add(new Unit(m.getCursor().selected.x-1,m.getCursor().selected.y,m.getCursor().selected.team+1));
            }
            if (m.getCursor().selected.y >= 1 && m.getCursor().selected.canDropUnit(m.getCursor().selected.x,m.getCursor().selected.y-1)) {
              possibleAttacks.add(new Unit(m.getCursor().selected.x,m.getCursor().selected.y-1,m.getCursor().selected.team+1));
            }
            if (m.getCursor().selected.y < m.board.length - 1 && m.getCursor().selected.canDropUnit(m.getCursor().selected.x,m.getCursor().selected.y+1)) {
              possibleAttacks.add(new Unit(m.getCursor().selected.x,m.getCursor().selected.y+1,m.getCursor().selected.team+1));
            }
            if (possibleAttacks.size() > 0) {
              m.combatMenu = new MenuOption(new String[]{"Drop","Wait"},"GUI/DropWaitMenu.png");
            } else {
              m.combatMenu = new MenuOption(false,false,false,false);
            }
          }
        } else if ((m.getCursorY() >= 0 && m.getCursorX() >= 0 && m.getCursorY() < m.board.length && m.getCursorX() < m.board[0].length) && m.board[m.getCursor().y][m.getCursor().x].occupying != null && m.board[m.getCursor().y][m.getCursor().x].occupying.canLoadUnit(m.c.selected)){
          if (m.getCursor().selected.move(m.getCursor().x,m.getCursor().y,true)) {
            inCombatMenu = true;
            m.combatMenu = new MenuOption(new String[]{"Load"},"GUI/LoadMenu.png");
            //tu.loadUnit(m.getCursor().selected);
            //m.getTile(m.getCursorX(),m.getCursorY()).occupying = tu;
          }
        }
      }
    }
    if (keyCode == 'U') {
      if (m.getCursor().selected != null) {
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
