Map m;
Sprite[] healthIcons;
Sprite[] captureIcons;
Sprite[] teamIcons;
Sprite[] teamMoneyIcons;
Sprite[] winScreens;
Sprite victorySprite;
Sprite[] explosionFrames; 
Sprite[] numberSprites;
boolean gameOver;
int gameOverTime;
int winningPlayer;
PFont aw2font;
boolean unitExploding;
final int scale = 2;
Unit showRange = null;
boolean inCombatMenu = false;
int[] mvmtRanges = new int[]{6,8,2,3,-1,-1,-1,-1,-1,6,4,5,4,4,4,-1,6,6,7,9,-1,-1,-1,-1,5,4,6,5};
/* damageChart[defender][attacker] */
int[] playerTeams = new int[]{1,3};
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
  captureIcons = new Sprite[4];
  for (int i = 0; i < captureIcons.length; i++) {
    captureIcons[i] = new Sprite("icons/t" + i + "_Capture.png");
  }
  teamIcons = new Sprite[4];
  for (int i = 0; i < teamIcons.length; i++) {
    teamIcons[i] = new Sprite("teams/t" + i + "_newturn.png");
  }
  teamMoneyIcons = new Sprite[4];
  for (int i = 0; i < teamMoneyIcons.length; i++) {
    teamMoneyIcons[i] = new Sprite("teams/t" + i + "_Money.png");
  }
  winScreens = new Sprite[4];
  for (int i = 0; i < winScreens.length; i++) {
    winScreens[i] = new Sprite("teams/t" + i+ "_Win.png");  
  }
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
  if (!gameOver ||gameOverTime < 75) {m.render();}
  if (gameOver == true) {showRange = null;}
  if (showRange != null) {
    showRange.displayRange(true,true);
    m.c.render(false,m.c.x,m.c.y);
  }
  if (gameOver) {
      if (gameOverTime < 75) {
        noStroke();
        fill(color(255,255,255,gameOverTime*4.25));
        rect(0,0,width,height);
        victorySprite.draw(0,height/2-victorySprite.dat.height/2,scale);
        gameOverTime++;
      } else {
        winScreens[winningPlayer].draw(0,0,scale); 
      }
    }
}

void keyPressed() {
  if (keyCode == 'C') {m.win(1);}
  parseInput();
}
void keyReleased() {
  if (key == 'u' || key == 'U') {
    showRange = null;  
  }
}
