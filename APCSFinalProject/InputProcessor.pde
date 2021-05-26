void parseInput() {
  if (key == 'w') { 
    m.getCursor().y = max(0,m.getCursor().y - 1);
  }
  if (key == 'a') { 
    m.getCursor().x = max(0,m.getCursor().x - 1);
  }
  if (key == 's') { 
    m.getCursor().y = min(m.getHeight()-1,m.getCursor().y + 1);
  }
  if (key == 'd') { 
    m.getCursor().x = min(m.getWidth()-1,m.getCursor().x + 1);
  }
}
