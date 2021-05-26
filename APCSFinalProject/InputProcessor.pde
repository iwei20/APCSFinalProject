void parseInput() {
  if (showRange != null) {keyCode = 'U';}
  
  if (keyCode == 'W') { 
    m.getCursor().y = max(0,m.getCursor().y - 1);
  }
  if (keyCode == 'A') { 
    m.getCursor().x = max(0,m.getCursor().x - 1);
  }
  if (keyCode == 'S') { 
    m.getCursor().y = min(m.getHeight()-1,m.getCursor().y + 1);
  }
  if (keyCode == 'D') { 
    if (showRange == null) {
      m.getCursor().x = min(m.getWidth()-1,m.getCursor().x + 1);
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
