class Sprite {
  PImage dat;  
  boolean[] transparency;
  
  private Sprite() {
    
  }
  public Sprite(PImage img) {
    dat = new PImage(img.width,img.height);
    arrayCopy(img.pixels,dat.pixels);
    transparency = new boolean[dat.pixels.length];
    color magenta = color(255,85,255);
    for (int i = 0; i < transparency.length; i++) {
      transparency[i] = !(dat.pixels[i] == magenta); 
    }
  }
  public Sprite shallowCopy() {
    Sprite s = new Sprite();
    s.dat = this.dat;
    s.transparency = this.transparency;
    return s;
  }
  public void draw(int x, int y, int scale) {
    draw(x,y,scale,false); 
  }
  public void draw(int x,int y, int scale, boolean hFlip) {
    for (int j = 0; j < dat.height; j++) {
      for (int i = 0; i < dat.width; i++) {
        if (transparency[hFlip ? ((j+1)*dat.width-i-1) : (j*dat.width+i)]) {
          color c = dat.pixels[hFlip ? ((j+1)*dat.width-i-1) : (j*dat.width+i)];
          for (int j2 = 0; j2 < scale; j2++) {
            for (int i2 = 0; i2 < scale; i2++) {
              set(scale*i+x+i2,scale*j+y+j2,c);
            }
          } 
        }
      }   
    }
  }
  
  
}
