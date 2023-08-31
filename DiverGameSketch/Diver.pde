
PImage[] _DiverSwimmingSprites;
PImage[] _DiverDyingSprites;
PImage[]  _DiverIdleSprites;
PImage[][] _LungSprites;


PImage[] explodeAnimation(String path,int row, int column,int missingCount ){
  
  PImage[] sprites = new PImage[row*column - missingCount];
  PImage spritesheet = loadImage(path);  
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

void explodeLung( ){

  
  
  float x = 0.66667; // define colum starting
  float y = 1.6666667;
  float w = 41.6666667; // define colum starting
  float h= 41.6666667;
  
  int cols = 38; // how many columns exist in actual image?
  int rows = 28; // how many rows exist in actual image?
  //int availableFrames = 8000/200; // in width or in heigh
 
  //PImage[] sprites = new PImage[(int)frameRate];
  _LungSprites = new PImage[cols][rows];

  PImage spritesheet = loadImage("lungs copy.png");  
  imageMode(CENTER);
  
  for (int i=0; i<cols ; i++) {
      for (int j=0; j<rows ; j++) {
              _LungSprites[i][j] = spritesheet.get((int)(x+i*w),(int) (y+j*h),(int) w,(int) h);
      }
    //x += x >= size-singleSize ? singleSize : 0;
  }
}

class Diver {
 
  Diver() {
    //_DiverSprites = explodeAnimation("http://www.nordenfelt-thegame.com/blog/wp-content/uploads/2011/11/explosion_transparent.png",5,5,0);
  _DiverSwimmingSprites = explodeAnimation("D001 copy.png",8,8,2);
  _DiverDyingSprites = explodeAnimation("D002 copy.png",8,8,2);
  _DiverIdleSprites = explodeAnimation("D003 copy.png",8,8,2);
   explodeLung();
  
  _DiverX = width/2;
  }
  
  
  float DIVING_SPEED = 10f;
  float UP_SPEED = 2.2f;
  int countEvery = 10; // n frames
  float DIVING_DEPTH_LIMIT = height - BOTTOM_LAND_HEIGHT - 10;
  float DIVING_SURFACE_LIMIT = 88f;
  
  int lungIndex = 0;
  int columnIndex = 0;
  int lungFrameCnt = 0;
  int lungFrameHandicap = 0;

  void draw() {
    // Sprites 
    //lungFrameCnt = frameCount;
  lungIndex =   lungFrameCnt%_LungSprites[0].length;// (frameCount%(int)frameRate);
  if(lungIndex == 0) columnIndex++;
  image(_LungSprites[columnIndex%_LungSprites.length][lungIndex], width - 110, 110);
  text("frameCount: "+frameCount,20,160,400);
  text("frameRate: "+frameRate,20,180,400);
  text("lung: "+lungFrameCnt,20,200,400);
 
  text("info: "+_LungSprites[0].length,20,220,400);
  
   // image(_LungSprites[frameCount%_LungSprites.length], width - 110, 110);

  //if(_MicValue >20){
  // image(_DiverSwimmingSprites[frameCount%_DiverSwimmingSprites.length], width/2, height/2);
  //} else if ( _MicValue < 30) {
  //  image(_DiverDyingSprites[frameCount%_DiverDyingSprites.length],300, 300);
  //}
  
   //if ( _MicValueLowAvg< _MicValueHighAvg)
   if (_MicValueHighAvg > 5)
   {
     if(lungFrameHandicap++%countEvery == 0) lungFrameCnt++;
     
     _DiverDepthY += DIVING_SPEED;
     _DiverDepthY = (_DiverDepthY > DIVING_DEPTH_LIMIT) ? DIVING_DEPTH_LIMIT : _DiverDepthY;   
     image(_DiverSwimmingSprites[frameCount%_DiverSwimmingSprites.length],_DiverX, _DiverDepthY);   
     
   } else {
     if(lungFrameCnt > 0 && lungFrameHandicap++%countEvery == 0 ) lungFrameCnt--;
     
     _DiverDepthY -= UP_SPEED;
     _DiverDepthY = (_DiverDepthY < DIVING_SURFACE_LIMIT) ? DIVING_SURFACE_LIMIT : _DiverDepthY; 
      image(_DiverDyingSprites[frameCount%_DiverDyingSprites.length],_DiverX, _DiverDepthY);
   }
  
  //image(_DiverDyingSprites[frameCount%_DiverDyingSprites.length],300, 300);
  //image(_DiverIdleSprites[frameCount%_DiverIdleSprites.length],300, 300);

  // collision -- calculate distance

 
  }
}
