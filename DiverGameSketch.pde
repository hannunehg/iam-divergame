

Diver _Diver;
Mic _Mic;
Game _Game;
int BOTTOM_LAND_HEIGHT = 55;
float _DiverDepthY = 0;
float _DiverX;
boolean SHOW_DEBUG = true;
  
void setup() {
  size(1024, 384);
  //noLoop();
  _Game = new Game();
  _Diver = new Diver();
  _Mic = new Mic();
 
}
int firstTimeFlag = 0;
void draw() {
 

  if(firstTimeFlag == 0) 
  {
    _Game.drawOnce();
    firstTimeFlag = 1;
  }
  
  _Game.draw();

  _Mic.draw();
  _Diver.draw();
  
}