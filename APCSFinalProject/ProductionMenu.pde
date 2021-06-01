class ProdOption {
  Sprite unit, unit_grey;
  int cost;
  String name;
}

class ProductionMenu {
   int LEFT_X, TOP_Y, WIDTH, HEIGHT;
   boolean active;
   int target_x, target_y;
   int curr_mc_index;
   ArrayList<ProdOption> options;
   MenuCursor mc;
   
   public ProductionMenu(String path) {
     
   }
   
   public ProductionMenu() {
     LEFT_X = 20;
     TOP_Y = 50;
     WIDTH = 300;
     HEIGHT = 300;
     active = false;
     target_x = 0;
     target_y = 0;
   }
   
   void setTarget(int target_x, int target_y) {
     this.target_x = target_x;
     this.target_y = target_y;
   }
   
   void createUnit(int type) {
     m.board[target_y][target_x].occupying = new Unit(m, target_x, target_y, type, m.whoseTurn);  
   }
   
   void render() {
     if(active) {
       // Calculate later
       for(int i = 0; i < options.size(); ++i) {
         if(40 * i <= HEIGHT && m.money[m.whoseTurn] >= options.get(i).cost) {
           options.get(i).unit.draw(LEFT_X + 10, TOP_Y + 40 * i, 2);
           textAlign(LEFT);
           textSize(24);
           fill(0, 0, 0);
           text(options.get(i).name, LEFT_X + 40, TOP_Y + 40 * i);
           textAlign(RIGHT);
           text(options.get(i).cost, LEFT_X + WIDTH - 10, TOP_Y + 40 * i);
         }
         if(i == curr_mc_index) {
           mc.render(LEFT_X + 10, TOP_Y + 40 * i);
         }
       }
     }
     
   }
}
