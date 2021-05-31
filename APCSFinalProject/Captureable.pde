public class Captureable {
  int hp;
  int team; 
  Unit capturing;
  Sprite s;
  
  public Captureable(int t) {
    hp = 20;
    team = t;
    capturing = null;
    String c = "";
    switch(t) {
      case -1:
        c = "Neutral";
        break;
      case 0:
        c = "Red";
        break;
      case 2:
        c = "Blue";
        break;
    }
    s = new Sprite("tiles/" + c + "Base.png");
  }
  public void shallowCopy(Captureable a, Captureable b) {
    b.hp = a.hp;
    b.team = a.team;
    b.capturing = a.capturing;
    b.s = a.s;
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
      Captureable c = new Captureable(u.team);
      shallowCopy(c,this);
      u.capturing = null;
    }
    return team;  
  }
  
  public void render(int pos_x, int pos_y) {
    s.draw(pos_x*scale*16,(pos_y-1)*scale*16,scale);
  }
}
