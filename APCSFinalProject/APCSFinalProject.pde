Map m;
Sprite[] healthIcons;
final int scale = 2;
Unit showRange = null;
boolean inCombatMenu = false;

void setup() {
  size(240,240);
  healthIcons = new Sprite[9];
  for (int i = 0; i < healthIcons.length; i++) {
    healthIcons[i] = new Sprite("icons/" + (i+1) + ".png");
  }
  m = new Map(new byte[]{3,3,2,2,3,0,0,3,0,1,14,-128,1,0,3,-128,6,6,6,4,4,4,3,3,3}); 
}

void draw() {
  background(128);
  m.render();
  if (showRange != null) {
    showRange.displayRange(true,true);
  }
}

void keyPressed() {
  parseInput();
}
void keyReleased() {
  if (key == 'u' || key == 'U') {
    showRange = null;  
  }
}
