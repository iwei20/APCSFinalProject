class Sprite {
  PImage dat;  
  boolean[] transparency;
  boolean transparencyDisabled;
  
  public Sprite(PImage img) {
    dat = new PImage(img.width,img.height);
    arrayCopy(img.pixels,dat.pixels);
    transparency = new boolean[dat.pixels.length];
    color magenta = color(255,85,255);
    for (int i = 0; i < transparency.length; i++) {
      transparency[i] = !(dat.pixels[i] == magenta); 
    }
  }
  
}
