PImage spritesheet;
PImage[] _DiverSwimmingSprites;
PImage[] _DiverDyingSprites;
PImage[]  _DiverIdleSprites;
PImage[] _LungSprites;

PImage[] explodeAnimation(String path,int row, int column,int missingCount ){
  
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
  
  
  void draw() {
      
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