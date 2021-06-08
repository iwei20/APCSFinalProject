Map m;
Sprite[] healthIcons;
Sprite[] captureIcons;
Sprite[] teamIcons;
Sprite[] winScreens;
Sprite victorySprite;
Sprite[] explosionFrames; 
Sprite[] numberSprites;
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
  numberSprites = new Sprite[10];
  for (int i = 0; i < numberSprites.length; i++) {
    numberSprites[i] = new Sprite("icons/number_" + i + ".png");
  }
  captureIcons = new Sprite[5];
  captureIcons[0] = new Sprite("icons/t0_Capture.png");
  captureIcons[2] = new Sprite("icons/t2_Capture.png");
  teamIcons = new Sprite[4];
  for (int i = 0; i < teamIcons.length; i++) {
    teamIcons[i] = new Sprite("teams/t" + i + "_newturn.png");
  }
  winScreens = new Sprite[5];
  winScreens[0] = new Sprite("teams/t0_Win.png");
  winScreens[2] = new Sprite("teams/t2_Win.png");
  victorySprite = new Sprite("teams/Victory.png");
  explosionFrames = new Sprite[9];
  for (int i = 0; i < explosionFrames.length; i++) {
    explosionFrames[i] = new Sprite("ExplosionFrame" + i + ".png");
  }
  aw2font = createFont("advance-wars-2-gba.ttf", 20, false);
  // load map 
  try {
    byte[] mapData = loadBytes("maps/Volcano_Island.dat");
    m = new Map(mapData);
  } catch(Exception e) {
    e.printStackTrace();
  }
  m.newTurn();
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
  background(color(239,222,173));
  m.render();
  if (showRange != null) {
    showRange.displayRange(true,true);
    m.c.render(false,m.c.x,m.c.y);
  }
}

void keyPressed() {
  //if (keyCode == 'C') {m.win(1);}
  parseInput();
}
void keyReleased() {
  if (key == 'u' || key == 'U') {
    showRange = null;  
  }
}
