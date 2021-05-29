public class Terrain {
  int defense; 
  boolean ocean;
  boolean wet;
  boolean drivable;
  Sprite s;
  
  public Terrain(int index) {
    s = new Sprite(new PImage(16,16));
    switch(index) {
      case -1: // reef
        drivable = false;
        ocean = true;
        wet = true;
        defense = 0;
        s = new Sprite("tiles/Reef.png");
        break;
      case 0: // ocean
        drivable = false;
        ocean = true;
        wet = true;
        defense = 0;
        s = new Sprite("tiles/Water.png");
        break;
      case 1: // river
        drivable = true;
        ocean = false;
        wet = true;
        defense = 0;
        s = new Sprite("tiles/Water.png");
        break;
      case 2: // road
        drivable = true;
        ocean = false;
        wet = false;
        defense = 0;
        s = new Sprite("tiles/Gray.png");
        break;
      case 3: // plains
        drivable = true;
        ocean = false;
        wet = false;
        defense = 1;
        s = new Sprite("tiles/Plains.png");
        break;
      case 4: // forest
        drivable = true;
        ocean = false;
        wet = false;
        defense = 2;
        s = new Sprite("tiles/Forest.png");
        break;
      case 5: // city
        drivable = true;
        ocean = false;
        wet = false;
        defense = 3;
        s = new Sprite("tiles/City.png");
        break;
      case 6: //mountain
        drivable = false;
        ocean = false;
        wet = false;
        defense = 4;
        s = new Sprite("tiles/Mountain.png");
        break;
    }
  }
}
