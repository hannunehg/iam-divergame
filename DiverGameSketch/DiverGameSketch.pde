
Game _Game;
Diver _Diver;
Lung _Lung;
Mic _Mic;

void setup() {
  size(1024, 384);
  frameRate(39);
  
  //noLoop();
  _Game = new Game();
  _Diver = new Diver();
  _Lung = new  Lung();  
  _Mic = new Mic(this);
}

int firstTimeFlag = 0;
void draw() {

  if (firstTimeFlag == 0) {
    _Game.drawOnce();
    firstTimeFlag = 1;
  }

  _Game.draw();
  _Mic.draw();
  _Diver.draw();
  _Lung.draw();
}
