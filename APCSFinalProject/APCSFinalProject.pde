Map m;
final int scale = 2;
void setup() {
  size(240,240);
  m = new Map(new byte[]{3,3,0,0,3,-128,-128,6,6,6,4,4,4,3,3,3}); 
}

void draw() {
  background(128);
  m.render();
}

void keyPressed() {
  parseInput();
}
