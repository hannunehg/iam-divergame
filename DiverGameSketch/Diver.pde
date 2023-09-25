


class Diver {

  PImage[] _DiverSwimmingSprites;
  PImage[] _DiverDyingSprites;
  PImage[] _DiverIdleSprites;
  
  float DIVING_SPEED = 10f;
  float UP_SPEED = 2.2f;
  float DIVING_DEPTH_LIMIT = height - BOTTOM_LAND_HEIGHT - 10;
  float DIVING_SURFACE_LIMIT = 88f;

  Diver() {
      //_DiverSprites = explodeAnimation("http://www.nordenfelt-thegame.com/blog/wp-content/uploads/2011/11/explosion_transparent.png",5,5,0);
    _DiverSwimmingSprites = explodeAnimation("D001 copy.png",8,8,2);
    _DiverDyingSprites = explodeAnimation("D002 copy.png",8,8,2);
    _DiverIdleSprites = explodeAnimation("D003 copy.png",8,8,2);
    
    _DiverX = width/2;
  }
  
  void draw() {
    

  //if(_MicValue >20){
  // image(_DiverSwimmingSprites[frameCount%_DiverSwimmingSprites.length], width/2, height/2);
  //} else if ( _MicValue < 30) {
  //  image(_DiverDyingSprites[frameCount%_DiverDyingSprites.length],300, 300);
  //}
  
    switch(_DivingState) {
        
      case DIVE:
        _DiverDepthY += DIVING_SPEED;
        _DiverDepthY = (_DiverDepthY >= DIVING_DEPTH_LIMIT) ? DIVING_DEPTH_LIMIT : _DiverDepthY;   
        image(_DiverSwimmingSprites[frameCount%_DiverSwimmingSprites.length],_DiverX, _DiverDepthY);
        break;
      
      case PENALTY:
        _DiverDepthY -= UP_SPEED;
        _DiverDepthY = (_DiverDepthY <= DIVING_SURFACE_LIMIT) ? DIVING_SURFACE_LIMIT : _DiverDepthY; 
        image(_DiverDyingSprites[frameCount%_DiverDyingSprites.length],_DiverX, _DiverDepthY);
        break;
      
      default:
      case REST:
        _DiverDepthY -= UP_SPEED;
        _DiverDepthY = (_DiverDepthY < DIVING_SURFACE_LIMIT) ? DIVING_SURFACE_LIMIT : _DiverDepthY; 
        image(_DiverDyingSprites[frameCount%_DiverDyingSprites.length],_DiverX, _DiverDepthY);
        break;
       
    }
        
  
  //image(_DiverDyingSprites[frameCount%_DiverDyingSprites.length],300, 300);
  //image(_DiverIdleSprites[frameCount%_DiverIdleSprites.length],300, 300);

  // collision -- calculate distance
  }
  
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

}
