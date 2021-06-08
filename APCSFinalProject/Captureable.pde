public class Captureable {
  int hp;
  int team; 
  boolean critical;
  boolean canProduce;
  boolean hasProduced;
  Unit capturing;
  Sprite s;
  
  public Captureable(int t, boolean ishq, boolean canProduce) {
    hp = 20;
    team = t;
    capturing = null;
    critical = ishq;
    String c = t == -1 ? "Neutral" : getTeamColor(t);
    s = new Sprite("tiles/" + c + (ishq ? "HQ.png" : (canProduce ? "Base.png" : "City.png")));
    this.canProduce = canProduce;
    hasProduced = false;
  }
  public void shallowCopy(Captureable a, Captureable b) {
    b.hp = a.hp;
    b.team = a.team;
    b.capturing = a.capturing;
    b.s = a.s;
    b.canProduce = a.canProduce;
  }
  
  void openProduction(int x, int y) {
    // Open production menu
    if(canProduce && !hasProduced) {
      try {
        m.pMenu = new ProductionMenu("ProductionChart.dat");
      } catch(Exception e) {
        e.printStackTrace();
      }
      m.pMenu.setTarget(x, y);
      m.pMenu.active = true;
    }
  }
  
  boolean canBeCaptured(Unit u) {
    return (u.index == 2 || u.index == 3) && this.team != u.team;
  }
  int capt(Unit u) {
    u.capturing = this;
    if (u != capturing) {hp = 20;}
    capturing = u;
    hp -= ceil(u.health);
    if (hp <= 0) {
      Captureable c = new Captureable(u.team,critical, canProduce);
      if (critical) {m.win(u.team == playerTeams[0] ? 0 : 1);}
      shallowCopy(c,this);
      u.capturing = null;
    }
    return team;  
  }
  public String getTeamColor(int team) {
    return team < 2 ? (team == 0 ? "Red" : "Green") : (team == 2 ? "Blue" : "Yellow");
  }
  public void render(int pos_x, int pos_y) {
    s.draw(pos_x*scale*16,(pos_y-1)*scale*16,scale);
  }
}
