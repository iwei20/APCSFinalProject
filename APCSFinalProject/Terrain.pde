public class Terrain {
  int defense; 
  boolean ocean;
  boolean drivable;
  // index 0 = on foot, 1 = treads, 2 = tires, 3 = boat
  int movementCosts[];
  Sprite s;
  
  public Terrain(int index, int subindex) {
    s = new Sprite(new PImage(16,16));
    switch(index) {
      case -1: // reef
        drivable = false;
        ocean = true;
        defense = 0;
        s = new Sprite("tiles/Reef.png");
        movementCosts = new int[]{-1,-1,-1,2};
        break;
      case 0: // ocean
        drivable = false;
        ocean = true;
        defense = 0;
        s = new Sprite("tiles/water_" + subindex + ".png");
        movementCosts = new int[]{-1,-1,-1,1};
        break;
      case 1: // river
        drivable = true;
        ocean = false;
        defense = 0;
        s = new Sprite("tiles/water_" + subindex + ".png");
        movementCosts = new int[]{2,-1,-1,1};
        break;
      case 2: // horizontal road
        drivable = true;
        ocean = false;
        defense = 0;
        s = new Sprite("tiles/road_1.png");
        movementCosts = new int[]{1,1,1,-1};
        break;
      case 3: // vertical road
        drivable = true;
        ocean = false;
        defense = 0;
        s = new Sprite("tiles/road_" + subindex + ".png");
        movementCosts = new int[]{1,1,1,-1};
        break;
      case 4: // plains
        drivable = true;
        ocean = false;
        defense = 1;
        s = new Sprite("tiles/Plains.png");
        movementCosts = new int[]{1,1,2,-1};
        break;
      case 5: // forest
        drivable = true;
        ocean = false;
        defense = 2;
        s = new Sprite("tiles/Forest.png");
        movementCosts = new int[]{1,2,3,-1};
        break;
      case 6: // city
        drivable = true;
        ocean = false;
        defense = 3;
        s = new Sprite("tiles/City.png");
        movementCosts = new int[]{1,1,1,-1};
        break;
      case 7: //mountain
        drivable = false;
        ocean = false;
        defense = 4;
        s = new Sprite("tiles/Mountain.png");
        movementCosts = new int[]{2,-1,-1,-1};
        break;
      case 8: // neutral base
      case 9: // red base
      case 10: // blue base
        drivable = true;
        ocean = false;
        defense = 3;
        s = new Sprite("tiles/GrayCity.png");
        movementCosts = new int[]{1,1,1,-1};
        break;
      case 11: // red hq
      case 12: // blue hq
        drivable = true;
        ocean = false;
        defense = 3;
        s = new Sprite("tiles/GrayCity.png");
        movementCosts = new int[]{1,1,1,-1};
        break;
      case 13:
      case 14:
      case 15:
        drivable = true;
        ocean = false;
        defense = 3;
        s = new Sprite("tiles/GrayBase.png");
        movementCosts = new int[]{1,1,1,-1};
        break;
      case 16:
      case 17:
      case 18: // Gray seaport
        drivable = false;
        ocean = true;
        defense = 3;
        s = new Sprite("tiles/GraySeaport.png");
        movementCosts = new int[] {-1, -1, -1, 1};
        break;
      case 19:
      case 20:
      case 21:
        drivable = true;
        ocean = false;
        defense = 3;
        s = new Sprite("tiles/GrayAirport.png");
        movementCosts = new int[]{1,1,1,-1};
    }
  }
}
