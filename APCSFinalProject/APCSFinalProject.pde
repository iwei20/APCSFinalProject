Map m;
Sprite[] healthIcons;
Sprite[] explosionFrames; 
boolean unitExploding;
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
  explosionFrames = new Sprite[9];
  for (int i = 0; i < explosionFrames.length; i++) {
    explosionFrames[i] = new Sprite("ExplosionFrame" + i + ".png");
  }
  // load map 
  m = new Map(new byte[]{
    15,16, // Map size
    // Friendly units
    0,0,3,
    0,1,14,
    -128,
    // Enemy units
    1,1,3,
    2,0,3,
    -128,
    // Map data https://www.warsworldnews.com/wp/aw2/maps-aw2/volcano-isle/
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,3,0,3,2,2,2,2,4,4,4,4,4,0,
    0,3,3,5,2,5,2,3,3,6,6,3,3,4,4,0,
    0,5,5,3,3,3,2,3,6,6,6,5,6,3,4,0,
    0,3,2,3,5,3,5,6,6,6,6,6,3,5,2,0,
    0,0,2,2,2,5,5,6,6,6,6,6,3,3,2,0,
    0,0,2,3,3,5,6,6,6,6,6,3,6,5,2,0,
    0,3,2,5,3,6,6,6,6,6,3,5,3,3,2,0,
    0,5,2,3,3,6,6,6,6,6,5,5,2,2,2,0,
    0,4,4,6,6,6,6,6,6,3,3,5,3,3,0,0,
    0,4,4,6,6,6,6,3,3,3,3,2,3,5,0,0,
    0,4,4,3,3,6,3,4,3,3,5,2,5,3,3,0,
    0,3,4,5,5,4,4,4,3,5,3,2,3,3,5,0,
    0,5,4,4,4,4,4,0,4,2,2,2,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    
  }); 
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
