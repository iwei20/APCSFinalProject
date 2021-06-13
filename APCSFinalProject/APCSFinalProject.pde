import java.io.*;

File[] mapList;
File selectedMap;
Sprite TeamCursor;
Sprite selectMapSprite;
Sprite teamOverlay;
Sprite selectionBackground;
Sprite displayTileNums;
Sprite behindMapSelected;
int mapListingScroll = 0;
int mapSelected = 0;
int[] numTiles;
int[] selectedTeams;
int teamChanging;
Map m;
Sprite[] coIcons;
Sprite[] teamSymbols;
Sprite[] healthIcons;
Sprite[] captureIcons;
Sprite[] teamIcons;
Sprite[] teamMoneyIcons;
Sprite[] winScreens;
Sprite[] loadIcons;
Sprite victorySprite;
Sprite[] explosionFrames; 
Sprite[] numberSprites;
Sprite[] whiteNumberSprites;
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
int[] playerTeams = new int[]{0,2};
int[][] damageChart;

void setup() {
  selectMapSprite = new Sprite("GUI/selectmap.png");
  selectionBackground = new Sprite("GUI/selectionBackground.png");
  behindMapSelected = new Sprite("GUI/underMapSelected.png");
  displayTileNums = new Sprite("GUI/NumBasesCities.png");
  teamOverlay = new Sprite("GUI/TeamsOverlay.png");
  TeamCursor = new Sprite("TeamCursor.png");
  File directory = new File(this.dataPath("maps/"));
  mapList = directory.listFiles();
  selectedMap = null;
  tu = null;
  numTiles = getTileNums(loadBytes(mapList[0]));
  //frameRate(5);
  size(480,320);
  healthIcons = new Sprite[9];
  for (int i = 0; i < healthIcons.length; i++) {
    healthIcons[i] = new Sprite("icons/" + (i+1) + ".png");
  }
  whiteNumberSprites = new Sprite[10];
  numberSprites = new Sprite[10];
  for (int i = 0; i < numberSprites.length; i++) {
    numberSprites[i] = new Sprite("icons/number_" + i + ".png");
    whiteNumberSprites[i] = new Sprite("GUI/" + i + ".png");
  }
  captureIcons = new Sprite[4];
  for (int i = 0; i < captureIcons.length; i++) {
    captureIcons[i] = new Sprite("icons/t" + i + "_Capture.png");
  }
  coIcons = new Sprite[4];
  for (int i = 0; i < coIcons.length; i++) {
    coIcons[i] = new Sprite("icons/t" + i + "_co.png");  
  }
  loadIcons = new Sprite[4];
  for (int i = 0; i < coIcons.length; i++) {
    loadIcons[i] = new Sprite("icons/t" + i + "_loadicon.png");  
  }
  teamSymbols = new Sprite[4];
  for (int i = 0; i < teamSymbols.length; i++) {
    teamSymbols[i] = new Sprite("icons/t" + i + "_teamicon.png");  
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
  if (m != null) {
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
  } else {
    if (selectedMap == null) {
      textAlign(LEFT);
      int y_pos = 0;
      textSize(30);
      fill(255);
      selectMapSprite.draw(0,1*scale,scale);
      selectionBackground.draw(0,height/3-32,scale);
      displayTileNums.draw(width-displayTileNums.dat.width*scale,0,scale);
      String tempString = "" + numTiles[0];
      int temp = tempString.length() - 1;
      for (int i = 0; i < tempString.length(); i++) {
        whiteNumberSprites[tempString.charAt(i)-48].draw(width-displayTileNums.dat.width*scale-temp*16+scale*16,18*scale,scale);  
        temp--;  
      }
      tempString = "" + numTiles[1];
      temp = tempString.length() - 1;
      for (int i = 0; i < tempString.length(); i++) {
        whiteNumberSprites[tempString.charAt(i)-48].draw(width-displayTileNums.dat.width*scale-temp*16+scale*40,18*scale,scale);  
        temp--;  
      }
      behindMapSelected.draw(0,77+mapSelected*32,scale);
      for (int i = mapListingScroll; i < mapList.length; i++) {
        String toStr = mapList[i].toString();
        toStr = toStr.substring(1+toStr.lastIndexOf('\\'),toStr.lastIndexOf('.'));
        toStr = toStr.replace("_"," ");
        text(toStr,width/64,32*y_pos+height/3-6);
        y_pos++;
      }
    } else {
      coIcons[selectedTeams[0]].draw(92,128,scale);
      coIcons[selectedTeams[1]].draw(92+192,128,scale);
      teamOverlay.draw(0,0,scale);  
      TeamCursor.draw(92+192*teamChanging,106,scale);
    }
  }
}

Map loadMap(String path, int[] playerteams) {
  // load map 
  Map m = null;
  byte[] mapData = loadBytes(path);
  m = new Map(mapData,playerteams[0],playerteams[1]);
  if (m != null) {m.newTurn();}
  return m;
}

void keyPressed() {
  if (keyCode == 'C') {m.win(1);}
  if (m != null) {
    parseInput();
  } else {
    if (selectedMap == null) {
      //int mapListingScroll;
      //int mapSelected;
      if (keyCode == 'W') {
        if (mapSelected <= 1) {
          if (mapListingScroll == 0) {
            mapSelected = max(0,mapSelected-1);
          } else {
            mapListingScroll--;
          }
        } else {
          mapSelected--;  
        }
      } else if (keyCode == 'S') {
        if (mapSelected >= 7) {
          if (mapListingScroll == mapList.length - 8) {
            mapSelected = max(0,mapSelected+1);
          } else {
            mapListingScroll++;
          }
        } else {
          mapSelected = min(mapSelected+1,mapList.length-1);  
        }
      } else if (keyCode == 'I') {
        //println(mapSelected+mapListingScroll);
        //println(mapList[mapSelected+mapListingScroll].toString());
        selectedTeams = new int[2];
        selectedTeams[0] = 0;
        selectedTeams[1] = 2;
        teamChanging = 0;
        selectedMap = mapList[mapSelected+mapListingScroll];
      }
      if (keyCode == 'W' || keyCode == 'S') {
        numTiles = getTileNums(loadBytes(mapList[mapSelected+mapListingScroll]));  
      }
    } else {
      if (keyCode == 'I') {
        m = loadMap(selectedMap.toString(),selectedTeams);  
      } else if (keyCode == 'U') {
        selectedMap = null;  
      } else if (keyCode == 'W') {
        int[] temp0 = {0,2,0,1};
        int temp2 = selectedTeams[teamChanging];
        selectedTeams[teamChanging] = temp0[selectedTeams[teamChanging]];
        if (selectedTeams[0] == selectedTeams[1]) {
          selectedTeams[teamChanging] = temp0[selectedTeams[teamChanging]]; 
          if (selectedTeams[0] == selectedTeams[1]) {
            selectedTeams[teamChanging] = temp2;
          }
        }
      } else if (keyCode == 'S') {
        int[] temp1 = {2,3,1,3};
        int temp3 = selectedTeams[teamChanging];
        selectedTeams[teamChanging] = temp1[selectedTeams[teamChanging]];
        if (selectedTeams[0] == selectedTeams[1]) {
          selectedTeams[teamChanging] = temp1[selectedTeams[teamChanging]]; 
          if (selectedTeams[0] == selectedTeams[1]) {
            selectedTeams[teamChanging] = temp3;
          }
        }
      } else if (keyCode == 'D' && teamChanging == 0) {
        teamChanging++;  
      } else if (keyCode == 'A' && teamChanging > 0) {
        teamChanging--;
      }
    }
  }
}
int[] getTileNums(byte[] map) {
  int i = 2 + (map[0] == 0 ? 1 : 0);
  int[] toReturn = new int[2];
  
  toReturn[0] = 0;
  toReturn[1] = 0;
  for (; map[i] != -128; i += 3) { 
  }
  i++;
  for (; map[i] != -128; i += 3) { 
  }
  i++;
  for (; i < map.length; i++) {
    if (map[i] >= 8 && map[i] <= 12) {
      toReturn[0]++;  
    }
    if (map[i] >= 13 && map[i] <= 15) {
      toReturn[1]++;  
    }
  }
  
  return toReturn;
}


void keyReleased() {
  if (key == 'u' || key == 'U') {
    showRange = null;  
  }
}
