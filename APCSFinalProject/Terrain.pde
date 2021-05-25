public class Terrain {
  int defense; 
  boolean ocean;
  boolean drivable;
  Sprite s;
  
  public Terrain(int index) {
    switch(index) {
      case 0: // ocean
        drivable = false;
        ocean = true;
        defense = 0;
        break;
      case 1: // river
        drivable = true;
        ocean = false;
        defense = 0;
        break;
      case 2: // road
        drivable = true;
        ocean = false;
        defense = 0;
        break;
      case 3: // plains
        drivable = true;
        ocean = false;
        defense = 1;
        break;
      case 4: // forest
        drivable = true;
        ocean = false;
        defense = 2;
        break;
      case 5: // city
        drivable = true;
        ocean = false;
        defense = 3;
        break;
      case 6: //mountain
        drivable = false;
        ocean = false;
        defense = 4;
        break;
    }
  }
}
