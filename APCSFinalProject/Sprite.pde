class Sprite {
  PImage dat;  
  boolean[] transparency;
  
  public Sprite(String path) {
    shallowCopy(new Sprite(loadImage(path)),this); 
  }
  public Sprite(String path, color toTransparent) {
    shallowCopy(new Sprite(loadImage(path), toTransparent),this); 
  }
  public Sprite(PImage img) {
    this(img, color(255,85,255));
  }
  public Sprite(PImage img, color toTransparent) {
    dat = new PImage(img.width,img.height);
    arrayCopy(img.pixels,dat.pixels);
    transparency = new boolean[dat.pixels.length];
    for (int i = 0; i < transparency.length; i++) {
      transparency[i] = !(dat.pixels[i] == toTransparent); 
    }
  }
  private void shallowCopy(Sprite a, Sprite b) {
    b.dat = a.dat;
    b.transparency = a.transparency;
  }
  public void draw(int x, int y, int scale) {
    draw(x,y,scale,false); 
  }
  public void draw(int x,int y, int scale, boolean hFlip) {
    draw(x,y,scale,hFlip,false);
  }
  public void draw(int x,int y, int scale, boolean hFlip, boolean shift) {
    if (shift) {
      x += m.left_view*scale*16;
      y += m.top_view*scale*16;
    }
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
  public void draw(int x,int y, int scale, boolean hFlip, float shadeFactor) {
    draw(x,y,scale,hFlip,shadeFactor,true);
  }
  public void draw(int x,int y, int scale, boolean hFlip, float shadeFactor, boolean shift) {
    if (shift) {
      x += m.left_view*scale*16;
      y += m.top_view*scale*16;
    }
    if (shadeFactor >= .99) {
      draw(x,y,scale,hFlip);
      return;  
    }
    for (int j = 0; j < dat.height; j++) {
      for (int i = 0; i < dat.width; i++) {
        if (transparency[hFlip ? ((j+1)*dat.width-i-1) : (j*dat.width+i)]) {
          color c = dat.pixels[hFlip ? ((j+1)*dat.width-i-1) : (j*dat.width+i)];
          c = color(red(c)*shadeFactor,green(c)*shadeFactor,blue(c)*shadeFactor);
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
