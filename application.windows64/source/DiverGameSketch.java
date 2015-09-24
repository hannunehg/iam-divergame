import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DiverGameSketch extends PApplet {



Diver _Diver;
Mic _Mic;
Game _Game;
int BOTTOM_LAND_HEIGHT = 55;
float _DiverDepthY = 0;
float _DiverX;
boolean SHOW_DEBUG = true;
  
public void setup() {
  
  //noLoop();
  _Game = new Game();
  _Diver = new Diver();
  _Mic = new Mic();
 
}
int firstTimeFlag = 0;
public void draw() {
 

  if(firstTimeFlag == 0) 
  {
    _Game.drawOnce();
    firstTimeFlag = 1;
  }
  
  _Game.draw();

  _Mic.draw();
  _Diver.draw();
  
}

PImage spritesheet;
PImage[] _DiverSwimmingSprites;
PImage[] _DiverDyingSprites;
PImage[]  _DiverIdleSprites;
PImage[] _LungSprites;

public PImage[] explodeAnimation(String path,int row, int column,int missingCount ){
  
  PImage[] sprites = new PImage[row*column - missingCount];
  spritesheet = loadImage(path);  
  imageMode(CENTER);
  int W = spritesheet.width/column;
  int H = spritesheet.height/row;
  for (int i=0; i<sprites.length ; i++) {
    int x = i%row*W;
    int y = i/column*H;
    sprites[i] = spritesheet.get(x, y, W, H);
  }
  return sprites;
}

class Diver {
 
  Diver() {
    //_DiverSprites = explodeAnimation("http://www.nordenfelt-thegame.com/blog/wp-content/uploads/2011/11/explosion_transparent.png",5,5,0);
  _DiverSwimmingSprites = explodeAnimation("C:/Users/Welcome/Dropbox/Coral/low-res/D001 copy.png",8,8,2);
  _DiverDyingSprites = explodeAnimation("C:/Users/Welcome/Dropbox/Coral/low-res/D002 copy.png",8,8,2);
  _DiverIdleSprites = explodeAnimation("C:/Users/Welcome/Dropbox/Coral/low-res/D003 copy.png",8,8,2);
  _LungSprites = explodeAnimation("C:/Users/Welcome/Dropbox/Coral/lungs copy.png",40,40,520);
  
  _DiverX = width/2;
  }
  
  
  int DIVING_SPEED = 5;
  int DIVING_DEPTH_LIMIT = height - BOTTOM_LAND_HEIGHT - 10;
  int DIVING_SURFACE_LIMIT = 88;
  
  
  public void draw() {
      
    // Sprites 
  image(_LungSprites[frameCount%_LungSprites.length], width - 110, 110);
  
  //if(_MicValue >20){
  // image(_DiverSwimmingSprites[frameCount%_DiverSwimmingSprites.length], width/2, height/2);
  //} else if ( _MicValue < 30) {
  //  image(_DiverDyingSprites[frameCount%_DiverDyingSprites.length],300, 300);
  //}
  
   //if ( _MicValueLowAvg< _MicValueHighAvg)
   if (_MicValueHighAvg > 5)
   {
     _DiverDepthY += DIVING_SPEED;
     _DiverDepthY = (_DiverDepthY > DIVING_DEPTH_LIMIT) ? DIVING_DEPTH_LIMIT : _DiverDepthY;   
     image(_DiverSwimmingSprites[frameCount%_DiverSwimmingSprites.length],_DiverX, _DiverDepthY);   
     
   } else {
     _DiverDepthY -= DIVING_SPEED;
     _DiverDepthY = (_DiverDepthY < DIVING_SURFACE_LIMIT) ? DIVING_SURFACE_LIMIT : _DiverDepthY; 
      image(_DiverDyingSprites[frameCount%_DiverDyingSprites.length],_DiverX, _DiverDepthY);
   }
  
  //image(_DiverDyingSprites[frameCount%_DiverDyingSprites.length],300, 300);
  //image(_DiverIdleSprites[frameCount%_DiverIdleSprites.length],300, 300);

  // collision -- calculate distance

 
  }
}
class Game {
  PImage pBackground;
  PImage pBoat;
  PImage[] pCorals;
  PImage[] pRocks;
  PImage[] pBottomImages;
  PImage[] pFish;
  ArrayList<MovingObject> _MovingObjects;
  PImage pSurfaceWater;
  
  Game() { 
   pBackground = loadImage("C:/Users/Welcome/Dropbox/Coral/elements/BG-01.png");
   pBoat = loadImage("C:/Users/Welcome/Dropbox/Coral/elements/Low-res-elements/0003Layer-4 copy.png");
   // small - large
   pCorals = new PImage[3];
   pCorals[0] = loadImage("C:/Users/Welcome/Dropbox/Coral/elements/Low-res-elements/0005Layer-6 copy.png");
   pCorals[1] = loadImage("C:/Users/Welcome/Dropbox/Coral/elements/Low-res-elements/0004Layer-5 copy.png");
   pCorals[2] = loadImage("C:/Users/Welcome/Dropbox/Coral/elements/Low-res-elements/0006Layer-7 copy.png");
   
   //pCorals[0] = loadImage("C:/Users/Welcome/Dropbox/Coral/elements/0005Layer-6.png");
   //pCorals[1] = loadImage("C:/Users/Welcome/Dropbox/Coral/elements/0004Layer-5.png");
   //pCorals[2] = loadImage("C:/Users/Welcome/Dropbox/Coral/elements/0006Layer-7.png");
   
   pRocks = new PImage[2];
   pRocks[0] = loadImage("C:/Users/Welcome/Dropbox/Coral/elements/Low-res-elements/0001Layer-2 copy.png");
   pRocks[1] = loadImage("C:/Users/Welcome/Dropbox/Coral/elements/Low-res-elements/0002Layer-3 copy.png");
   
   pBottomImages = new PImage[5];
   pBottomImages[0] = pCorals[0];
   pBottomImages[1] = pCorals[1];
   pBottomImages[2] = pCorals[2];
   pBottomImages[3] = pRocks[0];
   pBottomImages[4] = pRocks[1];
   
   pFish = new PImage[2];
   pFish[0] = loadImage("C:/Users/Welcome/Dropbox/Coral/elements/Low-res-elements/0007Layer-8 copy.png");
   pFish[1] = loadImage("C:/Users/Welcome/Dropbox/Coral/elements/Low-res-elements/0008Layer-9 copy.png");
   
   pSurfaceWater = loadImage("C:/Users/Welcome/Dropbox/Coral/elements/ser-water-02.png");
   
   
   // moving
    _loopIndexX = 0;
    _loopIndexY = 0;
   _MovingObjects = new ArrayList<MovingObject>();
  }
  float _BackgroundSpeedX = 1;
  float _BackgroundMoveReferencePositionX = 0;
  
  
  int _loopIndexX;
  int _loopIndexY;
  
  int MAX_LANE_ITEMS_COUNT = 15;
  int LANES_COUNT = 3;
  int _MoveItemPivotX = width/MAX_LANE_ITEMS_COUNT;
  int _MoveItemPivotY = BOTTOM_LAND_HEIGHT / LANES_COUNT;
 
  public void drawOnce() {
   
   for (int i= 0 ; i< MAX_LANE_ITEMS_COUNT ; i++) {
      arrangeImage(pBottomImages[(int)random(0,pBottomImages.length)]);  
    } 
  }
  float surfacePlayer = 1;
  float surfaceX = 0;
  public void draw() {
    
    background(0,0,0);
    int movingSpace = 30;
    if ( frameCount%movingSpace == 0) {
      surfacePlayer *= -1;
    }
    if (frameCount%3 == 0) {
    surfaceX += surfacePlayer;
    }
    image(pBackground,pBackground.width/2 - movingSpace + surfaceX, pBackground.height/2);
    image(pSurfaceWater, pSurfaceWater.width/2 - movingSpace +surfaceX , 50);
    
    image(pBoat,_BackgroundMoveReferencePositionX+ width ,pBoat.height); 
    //for (int i= 0 ; i< MAX_LANE_ITEMS_COUNT ; i++) {
    //  positionImage(pRocks[0]);
    //  positionImage(pCorals[0]);
    //  positionImage(pRocks[1]);
    //  positionImage(pCorals[1]);
    //  positionImage(pCorals[2]);
    //}
    if (frameCount%30 == 0  && _MovingObjects.size() < MAX_LANE_ITEMS_COUNT) {
     positionImage(pBottomImages[(int)random(0,pBottomImages.length)]);
    }
    
    
     for (int i = _MovingObjects.size()-1; i >= 0; i--) { 
        // An ArrayList doesn't know what it is storing so we have to cast the object coming out
        MovingObject movingObject = _MovingObjects.get(i);
        movingObject.move();
        movingObject.draw();
        if (movingObject.finished()) {
          // Items can be deleted with remove()
          _MovingObjects.remove(i);
        }
      
      }
  
    _BackgroundMoveReferencePositionX = _BackgroundMoveReferencePositionX - _BackgroundSpeedX;
  }
  
  public void positionImage(PImage image){
    
    _loopIndexY += image.height ;
     _MovingObjects.add(new MovingObject(image, width, height - 30 -(_loopIndexY%(BOTTOM_LAND_HEIGHT -30 )), _BackgroundSpeedX));
    //image(image, _BackgroundMoveReferencePositionX %width + width , height - (_loopIndexY%BOTTOM_LAND_HEIGHT) );
  }
  public void arrangeImage(PImage image) {
    _loopIndexX += _MoveItemPivotX ;
    _loopIndexY += image.height ;
    //image(image, _loopIndexX %width , height - (_loopIndexY%BOTTOM_LAND_HEIGHT) ); 
    _MovingObjects.add(new MovingObject(image,  _loopIndexX %width, height - 30 - (_loopIndexY%(BOTTOM_LAND_HEIGHT -30 )), _BackgroundSpeedX));
  }
}




Minim minim;
AudioInput in;
FFT         fft;

double _Max = -99999.99999f;
double _AvgMicValue = 0;
double _MicValueLowAvg;
double _MicValueHighAvg;


class Mic {
 
  Mic() { 
    // mic
    minim = new Minim(this);
    // use the getLineIn method of the Minim object to get an AudioInput
    in = minim.getLineIn();
  
    fft = new FFT( in.bufferSize(), in.sampleRate() );
  }
  public void draw() {
    fft.forward( in.mix );
   
    for(int i = 0; i < in.bufferSize() - 1; i++){
      line( i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50 );
      line( i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50 );
    }
    
    double avgMicValue = 0;
    int lowLevels = (int) (fft.specSize() * 0.1f);
    int highlevels = (int) (fft.specSize() * 0.1f);
    double highAvg = 0;
    for(int i = 0; i < fft.specSize(); i++)
    {
      if (i < lowLevels) {
        avgMicValue +=fft.getBand(i)*8;
      }
      else if (i < lowLevels + highlevels) {
        highAvg += fft.getBand(i)*8;
      }
     if (SHOW_DEBUG) {
       // draw the line for frequency band i, scaling it up a bit so we can see it
      line( i, height, i, height - fft.getBand(i)*8 );
     }
      
    }
    _MicValueLowAvg = avgMicValue/lowLevels;
    _MicValueHighAvg = highAvg/highlevels; 
    
    _Max = (_MicValueLowAvg > _Max) ? _MicValueLowAvg : _Max;
    stroke(4);
    fill(color(204, 0, 0));
    if (SHOW_DEBUG) {
      text( "Input monitoring value " +_MicValueHighAvg , 5, 15 );
      text( "Max monitoring value " + _Max, 5, 35 );
      text( "framcount " + frameCount, 5, 55 );
      text( "fft.specSize() " + fft.specSize(), 5, 75 );
    }
  }
}
class MovingObject {
  float xMovingObject;
  float yMovingObject;
  float speed;
  PImage pImage;
  MovingObject(PImage image, float tempX, float tempY, float tempSpeed) { 
    xMovingObject = tempX;
    yMovingObject = tempY;
    pImage = image;
    speed = tempSpeed;
  }
  public void move() {
     xMovingObject -= speed;
  }
  public void draw() {
    
    image(pImage,xMovingObject,yMovingObject);
    
    //image(pImage,0,0);
  }
  public boolean finished() {
    float newX = _DiverX + 70;
    float newY = _DiverDepthY+35;
    if (SHOW_DEBUG) {  
      text("a",newX,newY);   
      text((int)dist(xMovingObject,yMovingObject,newX,newY ) , xMovingObject - pImage.width/2 ,yMovingObject);
    }
    
    
    
    if (xMovingObject < 0 || dist(xMovingObject,yMovingObject,newX,newY ) < 24) {
      return true;
    } else {
      return false;
    }
  }
}
  public void settings() {  size(1024, 384); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DiverGameSketch" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
