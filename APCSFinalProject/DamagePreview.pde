class DamagePreview {
  Unit attacker, target;
  public DamagePreview(Unit attacker, Unit target) {
    this.attacker = attacker;
    this.target = target;
  }
  boolean hasUnits() {
    return attacker != null && target != null; 
  }
  void display() {
    fill(180, 180, 0);
    rect(10, height - 110, 200, 100);
    target.s.draw(150, height - 70, 3);
    fill(0, 0, 0);
    textSize(20);
    text("" + round(attacker.calcPower(attacker, target) * 10) + " %", 150, height - 80);
  }
}
