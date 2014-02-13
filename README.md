# gifAnimation processing library

GifAnimation is a [Processing][1] library to play and export GIF
animations. It is under a GPL license. The GIFEncoder &amp; GIFDecoder
classes were written by [Kevin Weiner][2]. Please see the separate copyright notice in
the headers of the GifDecoder &amp; GifEncoder classes.


## DOWNLOAD

[gifAnimation_processing_library_v2_3.zip][3] (updated: 18. January 2008)

## HOW TO

###  INSTALLATION:

Unzip the gifAnimation.zip and copy the gifAnimation-folder into your
processing libraries folder.

### USAGE:

Besides this reference, there are basic examples included in the download.
There's also an [online example][4].
To use gifAnimation library, you need to import it into your sketch
by using the menu or typing



    import gifAnimation.*;

### DISPLAYING A GIF ANIMATION:

The class to access/display GIF animations is called _Gif_. It
has two possibilities to access the frame pixel data:

Extract all frames of an animated Gif into a PImage[] array using
the static method "getPImages()". you need to pass a reference to the
PApplet and a filename to it. The file should be in the sketch data
folder. This method is useful if you just want to mess with the frames
yourself and don't need the playback possibilities. The method is
static, so you have no separate thread going.


    PImage[] allFrames = Gif.getPImages(this, "lavalamp.gif");

The second way to acces the animation is to play it like a movie
(actually it has the same methods like Processings Movie class). This
will play the animation with the frame delays specified in the GIF file.
Gif extends PImage, so any instance of Gif fits wherever PImage can be
used.

To create a new Gif object use:



    Gif myAnimation = new Gif(PApplet parent, String filename);

In a sketch this would look like this:


    void setup() {
    size(400,400);
    	Gif myAnimation = new Gif(this, "lavalamp.gif");
    myAnimation.play();
    }

    void draw() {
    image(myAnimation, 10,10);
    }

Gif objects have following methods:

_void play()_
plays the animation without loop

_void pause()_
pauses the animation

_void stop()_
stops and rewinds the animation

_void loop()_
starts the animation. it will play in a loop and ignore the
GIF repeat setting.

_void noLoop()_
disables looping

_void ignoreRepeat()_
GIF-files can have a repeat-count setting. It states
the amount of loops this animation should perform. if you call
ignoreRepeat() on a Gif object, it will ingore this setting when
playing. if you start animations using loop(), repeat settings will be
ignored anyway.

_void jump(int where)_
jumps to a specific frame in the animation if that frame exists

_boolean isPlaying()_
whether the Animation is currently playing

_boolean isLooping()_
whether the Animation has its loop-flag set

_boolean isIgnoringRepeat()_
whether this Gif has its ignoreRepeat-flag set or not.
See also _ignoreRepeat()_

_int currentFrame()_
returns the number of the frame that is currently displayed

_PImage[] getPImages()_
returns an array of PImages containing the animation
frames. note that this method is called in an instance of Gif, while
Gif.getPImages(PApplet, String) is a static method

_int getRepeat()_
returns the number of repeats that is specified in the GIF-file

&nbsp;

### EXPORTING A GIF ANIMATION

The class to export GIF animations is called _GifMaker_. To start recording
into a GIF file, create a GifMaker object like this:


    GifMaker gifExport = new GifMaker(PApplet parent, String filename);
    GifMaker gifExport = new GifMaker(PApplet parent, String filename, int quality);
    GifMaker gifExport = new GifMaker(PApplet parent, String filename, int quality, int transparentColor);

In a sketch this would look like this:


    void setup() {
    size(200,200);
    	frameRate(12);

    	gifExport = new GifMaker(this, "export.gif");
    	gifExport.setRepeat(0);				// make it an "endless" animation
    	gifExport.setTransparent(0,0,0);	// black is transparent

    }

    void draw() {
    	background(0);
    	fill(255);
    	ellipse(mouseX, mouseY, 10, 10);

    	gifExport.setDelay(1);
    	gifExport.addFrame();
    }

    void mousePressed() {
    	gifExport.finish();					// write file
    }


&nbsp;

GifMaker objects have the following methods:

_void setTransparent(int color)
void setTransparent(int red, int green, int blue)
void setTransparent(float red, float green, float blue)_
Sets the transparent color of the GIF file. Unlike other image formats
that support alpha (e.g. PNG), GIF does not support semi-transparent pixels.
The way to achieve transparency is to set a color that will be transparent
when rendering the GIF. So, if you set the transparent color to black, the
black pixels in your gif file will be transparent.

_void setQuality(int qualtiy) _
Sets the quality of the color quantization process. GIF only supports 256
indexed colors per frame. So, the colors that come in your images need to
be reduced to a set of 256 colors. The quality of this process can be set
using this method (or by instantiating the GifMaker object wiht the re-
spective constructor). Default is 10 and seems to produce good results.
Higher qualities will cause the qantization process to be more expensive
in terms of cpu-usage.

_void setSize(int width, int height)_
Sets the size of the new GIF file. If this method is not invoked, the image
dimensions of the first added frame will be the size of the GIF.

_void setRepeat(int count)_
Sets the repeat setting in the GIF file. GIF renderers like webbrowsers
should respect this setting and loop the animation that many times before
stopping. Default is 1. 0 means endless loop.

_void addFrame()_
_void addFrame(PImage image)_
_void addFrame(int[] pixelArray, int width, int height)_
Adds a frame to the GIF animation. Use addFrame() without parameters to
pass the current sketch window contents to the gif.

_void setDelay(int ms)_
Sets the delay (the "framerate") for the most recently added frame. This
is measured in Milliseconds. This can be different for every frame. Note,
this effects the playback speed of the resulting GIF-file only. So, the
speed / framerate with which you wrote the frames has no effect on play-
back speed.

_void setDispose(int mode)_
Sets the disposal mode for the current frame. Disposal modes are a special
concept used in the GIF file format. It basically tetermines whether a frame
will be overriden by the next frame, or if the next frame should be added,
layed over the last frame.
For convenience there are constants for the different disposal modes:
_GifMaker.DISPOSE_NOTHING_: Nothing special
_GifMaker.DISPOSE_KEEP_: retain the current image
_GifMaker.DISPOSE_RESTORE_BACKGROUND_: restore the background color
_GifMaker.DISPOSE_REMOVE_: remove the current image, and restore whatever image was beneath it.

_boolean finish()_
Finishes GIF recording and saves the GIF file to the given file name in
the sketch folder. Returns true if saving the file was successful, false if not.

   [1]: http://www.processing.org
   [2]: http://www.fmsware.com/stuff/gif.html
   [3]: http://www.extrapixel.ch/gifAnimation_processing_library_v2_3.zip
   [4]: http://extrapixel.ch/processing/gifAnimation/applet/
  
