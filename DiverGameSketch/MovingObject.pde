
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
  
  void move() {
     xMovingObject -= speed;
  }
  
  void draw() {
    image(pImage,xMovingObject,yMovingObject);
   
  }
  
  boolean finished() {
    float newX = _DiverX + 70;
    float newY = _DiverDepthY+35;
    if (SHOW_DEBUG) {  
      text("a",newX,newY);   
      text((int)dist(xMovingObject,yMovingObject,newX,newY ) , xMovingObject - pImage.width/2 ,yMovingObject);
    }
    
    if ( dist(xMovingObject,yMovingObject,newX,newY ) < 24) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean missed() {
    return xMovingObject < 0;
  }
  
}
