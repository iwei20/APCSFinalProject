class ProdOption {
  int type;
  Sprite unit;
  int cost;
  String name;
}

// TODO: implement menu scrolling
class ProductionMenu {
  int LEFT_X, TOP_Y, WIDTH, HEIGHT;
  boolean active;
  int target_x, target_y;
  int curr_mc_index, top_index;
  ArrayList<ProdOption> options;
  MenuCursor mc;
   
  public ProductionMenu(String path) throws IOException {
    LEFT_X = 30;
    TOP_Y = 90;
    WIDTH = 300;
    HEIGHT = height - TOP_Y - 10;
    active = false;
    target_x = 0;
    target_y = 0;
    options = new ArrayList();
    mc = new MenuCursor();
    top_index = 0;
    
    BufferedReader br = createReader(path);
    String line = null;
    
    while((line = br.readLine()) != null) {
      String[] dat = split(line, ' '); // 0 = unit type, 1 = cost, 2 = name
      
      ProdOption next = new ProdOption();
      
      // Read in sprite and load it
      int spriteIndex = int(dat[0]);
      next.type = spriteIndex;
      next.unit = new Sprite(loadImage("units/t" + m.whoseTurn + "_" + spriteIndex + ".png"));
      
      next.cost = int(dat[1]);
      next.name = "";
      for(int i = 2; i < dat.length; ++i) {
        next.name += dat[i];
        if(i != dat.length - 1) {
          next.name += " ";
        }
      }
      
      options.add(next);
    }
    
  }
   
   void setTarget(int target_x, int target_y) {
     this.target_x = target_x;
     this.target_y = target_y;
   }
   
   boolean createUnit() {
     if(m.money[m.whoseTurn] >= options.get(curr_mc_index).cost) {
       m.board[target_y][target_x].occupying = new Unit(m, target_x, target_y, options.get(curr_mc_index).type, m.whoseTurn);
       m.board[target_y][target_x].occupying.setActionTaken();
       if(m.whoseTurn == 0 || m.whoseTurn == 1) m.pUnits.add(m.board[target_y][target_x].occupying);
       if(m.whoseTurn == 2 || m.whoseTurn == 3) m.eUnits.add(m.board[target_y][target_x].occupying);
       m.money[m.whoseTurn] -= options.get(curr_mc_index).cost;
       return true;
     }
     return false;
   }
   
   void render() {
     if(active) {
       strokeWeight(2);
       stroke(0);
       fill(0, 0, 0);
       rect(LEFT_X + 5, TOP_Y + 5, WIDTH, HEIGHT);
       switch (m.whoseTurn) {
         case 0:
           fill(247, 189, 165, 225);
           break;
         case 1:
           fill(165, 239, 173, 225);
           break;
         case 2:
           fill(165, 206, 247, 225);
           break;
         case 3:
           fill(231, 231, 115, 225);
           break;
         default:
           fill(50, 50, 50, 225);
           break;
       }
       rect(LEFT_X, TOP_Y, WIDTH, HEIGHT);
       rect(LEFT_X, TOP_Y - 40, WIDTH / 2, 30);
       textAlign(LEFT);
       textSize(24);
       fill(0, 0, 0);
       text("$" + m.money[m.whoseTurn], LEFT_X + 10, TOP_Y - 15);
       // Calculate later
       for(int i = 0; i < min(options.size(), 6); ++i) {
         if(TOP_Y - 30 + 40 * i <= HEIGHT) {
           if(m.money[m.whoseTurn] >= options.get(i + top_index).cost) {
             options.get(i + top_index).unit.draw(LEFT_X + 10, TOP_Y + 10 + 40 * i, 2);
             fill(0, 0, 0);
           } else {
             options.get(i + top_index).unit.draw(LEFT_X + 10, TOP_Y + 10 + 40 * i, 2, false, 0.8, false);
             fill(128, 128, 128);
           }
           textAlign(LEFT);
           textSize(28);
           text(options.get(i + top_index).name, LEFT_X + 50, TOP_Y + 33 + 40 * i);
           textAlign(RIGHT);
           textSize(24);
           text(options.get(i + top_index).cost, LEFT_X + WIDTH - 10, TOP_Y + 33 + 40 * i);
         }
         if(i + top_index == curr_mc_index) {
           mc.render(LEFT_X - 20, TOP_Y + 15 + 40 * i);
         }
       }
       strokeWeight(1);
     }
     
   }
}
