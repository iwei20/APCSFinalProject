void parseInput() {
  if (showRange != null) {keyCode = 'U';}
  
  if (keyCode == 'W') { 
    if (showRange == null) {
      if(m.getCursor().y == 0) {
        m.shift(0, 1);
      } else {
        m.getCursor().y--;
      }
    }
  }
  if (keyCode == 'A') { 
    if (showRange == null) {
      if(m.getCursor().x == 0) {
        m.shift(1, 0);
      } else {
        m.getCursor().x--;
      }
    }
  }
  if (keyCode == 'S') { 
    if (showRange == null) {
      if(m.getCursor().y == m.board.length - 1) {
        m.shift(0, -1);
      } else {
        m.getCursor().y++;
      }
    }
  }
  if (keyCode == 'D') { 
    if (showRange == null) {
        if(m.getCursor().y == m.board.length - 1) {
        m.shift(-1, 0);
      } else {
        m.getCursor().x++;
      }
    }
  }
  if (keyCode == 'I')  {
    if (m.getCursor().selected == null && m.getTile(m.getCursor().x,m.getCursor().y).occupying != null && !m.getTile(m.getCursor().x,m.getCursor().y).occupying.takenAction) {
      m.getCursor().selected = m.getTile(m.getCursor().x,m.getCursor().y).occupying;
      m.getCursor().storex = m.getCursor().x;
      m.getCursor().storey = m.getCursor().y;
    } else if (m.getCursor().selected != null) {
      if(m.getCursor().selected.move(m.getCursor().x,m.getCursor().y)) {
        m.getCursor().selected = null; 
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
