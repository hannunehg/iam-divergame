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
   pBackground = loadImage("BG-01.png");
   pBoat = loadImage("0003Layer-4 copy.png");
   // small - large
   pCorals = new PImage[3];
   pCorals[0] = loadImage("0005Layer-6 copy.png");
   pCorals[1] = loadImage("0004Layer-5 copy.png");
   pCorals[2] = loadImage("0006Layer-7 copy.png");
   
   pRocks = new PImage[2];
   pRocks[0] = loadImage("0001Layer-2 copy.png");
   pRocks[1] = loadImage("0002Layer-3 copy.png");
   
   pBottomImages = new PImage[5];
   pBottomImages[0] = pCorals[0];
   pBottomImages[1] = pCorals[1];
   pBottomImages[2] = pCorals[2];
   pBottomImages[3] = pRocks[0];
   pBottomImages[4] = pRocks[1];
   
   pFish = new PImage[2];
   pFish[0] = loadImage("0007Layer-8 copy.png");
   pFish[1] = loadImage("0008Layer-9 copy.png");
   
   pSurfaceWater = loadImage("ser-water-02.png");
   
   
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
 
  void drawOnce() {
   for (int i= 0 ; i< MAX_LANE_ITEMS_COUNT ; i++) {
      arrangeImage(pBottomImages[(int)random(0,pBottomImages.length)]);  
    } 
  }
  float surfacePlayer = 1;
  float surfaceX = 0;
  
  void draw() {
     //<>//
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
  
  void positionImage(PImage image){ //<>//
    _loopIndexY += image.height ;
     _MovingObjects.add(new MovingObject(image, width, height - 30 -(_loopIndexY%(BOTTOM_LAND_HEIGHT -30 )), _BackgroundSpeedX));
    //image(image, _BackgroundMoveReferencePositionX %width + width , height - (_loopIndexY%BOTTOM_LAND_HEIGHT) );
  }
  
  void arrangeImage(PImage image) {
    _loopIndexX += _MoveItemPivotX ;
    _loopIndexY += image.height ;
    //image(image, _loopIndexX %width , height - (_loopIndexY%BOTTOM_LAND_HEIGHT) ); 
    _MovingObjects.add(new MovingObject(image,  _loopIndexX %width, height - 30 - (_loopIndexY%(BOTTOM_LAND_HEIGHT -30 )), _BackgroundSpeedX));
  }
  
}