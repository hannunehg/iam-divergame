import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT         fft;

double _Max = -99999.99999;
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
  void draw() {
    fft.forward( in.mix );
   
    for(int i = 0; i < in.bufferSize() - 1; i++){
      line( i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50 );
      line( i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50 );
    }
    
    double avgMicValue = 0;
    int lowLevels = (int) (fft.specSize() * 0.1);
    int highlevels = (int) (fft.specSize() * 0.1);
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