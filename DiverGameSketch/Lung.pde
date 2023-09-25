
enum DivingState { DIVE, REST, PENALTY }

DivingState _DivingState = DivingState.REST;

class Lung {
  
  PImage[][] _LungSprites;
  
  int penalty_MAX = 10;
  int countEvery = 10; // n frames
  int lungIndex = 0;
  int columnIndex = 0;
  int lungFrameCnt = 0;
  int lungFrameHandicap = 0;
  int penalty = 0;
  boolean penaltyActive = false;
  
  Lung() {
    explodeLung(); 
  }
  
  void draw(){
    // Sprites 
    //lungFrameCnt = frameCount;
    lungIndex =   lungFrameCnt%_LungSprites[0].length;// (frameCount%(int)frameRate);
    if(lungIndex == 0) columnIndex++;
    image(_LungSprites[columnIndex%_LungSprites.length][lungIndex], width - 110, 110);
    text("frameCount: "+frameCount,20,160,400);
    text("frameRate: "+frameRate,20,180,400);
    text("lung: "+lungFrameCnt,20,200,400);
    text("info: "+_LungSprites[0].length+", p: "+penalty,20,220,400);
    if(penaltyActive){
        text("penalty MODE: cannot dive before "+penalty+"seconds",20,240,400);
    }
  
   // image(_LungSprites[frameCount%_LungSprites.length], width - 110, 110);
   
   if (sShush) {
     // sssshhh sound active
     if(lungFrameCnt < 28 && !penaltyActive &&  penalty < penalty_MAX){
       if(lungFrameHandicap++%countEvery == 0) {
         // Every second filter
         if(lungFrameCnt == 27){
           // at 27, start increasing penalty.
           penalty++;
           lungFrameCnt--;
         }else{
           // normal diving flow
           lungFrameCnt++;
         }
       }
       _DivingState = DivingState.DIVE;
     } else{
       // penalty is active and user is still shussshing so for diver to go up
       _DivingState = DivingState.PENALTY;
     }
   } else {
     
     // no ssssshhhh sound OR penalty activated
     
     if(lungFrameHandicap++%countEvery == 0 ) {
       
       if(penalty > 1){  // > 1 consume penalty until its over
         penaltyActive = true;
         penalty--;
       } else if(penalty == 1){  // = 1 reset penalty
         lungFrameCnt = 14; //penalty_MAX;
         
         penalty = 0;
       } else {  // < 1
         penaltyActive = false;
         if(lungFrameCnt > 0){
           // normal recovoring flow
           lungFrameCnt--;
         }
       }
       
     }
     _DivingState = DivingState.REST;
   }
   
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
}
