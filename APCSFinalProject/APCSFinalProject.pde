Map m;
Sprite[] healthIcons;
final int scale = 2;
Unit showRange = null;
boolean inCombatMenu = false;
/* damageChart[defender][attacker] */
int[][] damageChart;

void setup() {
  //frameRate(5);
  size(480,320);
  healthIcons = new Sprite[9];
  for (int i = 0; i < healthIcons.length; i++) {
    healthIcons[i] = new Sprite("icons/" + (i+1) + ".png");
  }
  // load map 
  m = new Map(new byte[]{3,3,0,0,3,0,1,14,-128,1,1,3,2,0,3,-128,6,6,6,4,4,4,3,3,3}); 
  // load Damage Chart 
  damageChart = new int[28][28];
  byte[] temp = loadBytes("damageChart.dat");
  for (int j = 0; j < damageChart.length; j++) {
    for (int i = 0; i < damageChart[0].length; i++) {
      damageChart[j][i] = temp[i+j*damageChart[0].length];
    }  
  }
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
