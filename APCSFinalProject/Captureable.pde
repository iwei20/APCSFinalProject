public class Captureable {
  int hp;
  int team; 
  Unit capturing;
  Sprite s;
  
  public Captureable(int t) {
    hp = 20;
    team = t;
    capturing = null;
    s = new Sprite("tiles/" + (t == -1 ? "Gray" : (t == 0 ? "Red" : "Blue")) + "Base.png");
  }
  
  boolean canCapture(Unit u) {
    return (u.index == 2 || u.index == 3) && this.team != u.team;
  }
  int capt(Unit u) {
    if (u != capturing) {hp = 20;}
    hp -= ceil(u.health);
    if (hp <= 0) {team = u.team;}
    return team;  
  }
  
  public void render(int pos_x, int pos_y,int layer) {
    s.draw(pos_x*scale*16,pos_y*scale*16,scale);
  }
}
