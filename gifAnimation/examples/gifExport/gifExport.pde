/*
 * Demonstrates the use of the GifAnimation library.
 * Exports a GIF-File to the sketch folder if space
 * bar is pressed. Wow, feels like 90's! ;)
 * 
 * for docs see:
 * http://extrapixel.github.io/gif-animation/
 */

import gifAnimation.*;

GifMaker gifExport;
float rotation = 0.0;
static int   FRAME_RATE = 30;

public void setup() {
  size(200, 200);
  frameRate(FRAME_RATE);
  noStroke();
  
  println("press SPACE to export gif. move mouse to change color and rotation speed.");
  
  gifExport = new GifMaker(this, "export.gif");
  
  // make it a looping animation
  gifExport.setRepeat(0); 
  
  /* make white the transparent color. every black pixel in the animation will be transparent
   * GIF doesn't know have alpha values like processing. a pixel can only be totally transparent or totally opaque.
   * set the processing background and the transparent gif color to the same value as the gifs destination background color 
   * (e.g. the website bg-color). Like this you can have the antialiasing from processing in the gif.*/
   gifExport.setTransparent(255, 255, 255); 
}


void draw() {
  background(255);
  fill(mouseX, 40, 110);
  translate(width/2, height/2);
  rotation += map(mouseX, 0, width, 0.01, 0.1);
  rotate(rotation);
  
  rect(-50, -50, 100, 100);
  
  // we make the gif-"framerate" the same as the sketch framerate.
  gifExport.setDelay(1000/FRAME_RATE); // takes milliseconds. we make the gif-"framerate" the same as the sketch framerate. 
  gifExport.addFrame();
}

void keyPressed() {
  gifExport.finish();
  println("gif exported");
}
