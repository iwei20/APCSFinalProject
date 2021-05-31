Map m;
Sprite[] healthIcons;
Sprite[] explosionFrames; 
PFont aw2font;
boolean unitExploding;
final int scale = 2;
Unit showRange = null;
boolean inCombatMenu = false;
int[] mvmtRanges = new int[]{6,8,2,3,-1,-1,-1,-1,-1,6,4,5,4,4,4,-1,6,6,7,9,-1,-1,-1,-1,5,4,6,5};
/* damageChart[defender][attacker] */
int[] playerTeams = new int[]{0,2};
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
  aw2font = createFont("advance-wars-2-gba.ttf", 20, false);
  // load map 
  m = new Map(new byte[]{
    15,16, // Map size
    // Friendly units
    2,3,3,
    2,7,14,
    5,6,1,
    -128,
    // Enemy units
    4,2,11,
    14,4,3,
    14,5,3,
    -128,
    // Map data https://www.warsworldnews.com/wp/aw2/maps-aw2/volcano-isle/
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,4,0,4,3,3,3,3,5,5,5,5,5,0,
    0,4,4,6,3,6,2,4,4,7,7,4,4,5,5,0,
    0,6,6,4,4,4,2,4,7,7,7,6,7,4,5,0,
    0,4,2,4,6,4,8,7,7,7,7,7,4,6,2,0,
    0,0,2,3,3,6,6,7,7,7,7,7,4,4,2,0,
    0,0,2,4,4,6,7,7,7,7,7,4,7,6,2,0,
    0,4,2,6,4,7,7,7,7,7,4,6,4,4,2,0,
    0,6,2,4,4,7,7,7,7,7,6,6,3,3,2,0,
    0,5,5,7,7,7,7,7,7,4,4,6,4,4,0,0,
    0,5,5,7,7,7,7,4,4,4,4,2,4,6,0,0,
    0,5,5,4,4,7,4,5,4,4,6,2,6,4,4,0,
    0,4,5,6,6,5,5,5,4,6,4,2,4,4,6,0,
    0,6,5,5,5,5,5,0,5,3,3,3,0,0,0,0,
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
  textFont(aw2font);
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
