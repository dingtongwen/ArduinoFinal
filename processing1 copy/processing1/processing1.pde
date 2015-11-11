import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer sa; //variable name;
AudioPlayer sb;
AudioPlayer sc;
AudioPlayer sd;
AudioPlayer se;
AudioPlayer sf;

import processing.serial.*;

Serial myPort;                       // The serial port
int[] serialInArray = new int[6];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
int a,b,c,d,e,f;                  
boolean firstContact = false;        // Whether we've heard from the microcontroller

void setup() {
  size(600,600);  // Stage size
  noStroke();      // No border on the next thing drawn

  
  

  // Print a list of the serial ports for debugging purposes
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
  
  
  //Audio
  minim = new Minim(this);
  sa = minim.loadFile("1.mp3");
  sb = minim.loadFile("2.mp3");
  sc = minim.loadFile("3.mp3");
  sd = minim.loadFile("4.mp3");
  se = minim.loadFile("5.mp3");
  sf = minim.loadFile("6.mp3");
  
  
  
  
  
  
}

void draw() {
  background(0);
  fill(0,0.7);
  noStroke();
  rect(0,0,600,600);
  
  
  
  
  // Draw the shape
  strokeWeight(5);
  stroke(255, 0, 174);
  ellipse(100, 150, a*10, a*10);
  
  stroke(162, 0, 255);
  ellipse(150, 350, b*10, b*10);
  
  stroke(0, 161, 255);
  ellipse(350, 400, c*10, c*10);
  
  stroke(77, 255, 219);
  ellipse(300, 450, d*10, d*10);
  
  stroke(255, 71, 151);
  ellipse(250, 250, e*10, e*10);
  
  stroke(71, 255, 249);
  ellipse(500, 250, f*10, f*10);
  
  
  if(a<10){
  sa.play();
  }else{
  sa.pause();
  }
  
  if(b<10){
  sb.play();
  }else{
  sb.pause();
  }
  
  if(c<10){
  sc.play();
  }else{
  sc.pause();
  }
  
  if(d<10){
  sd.play();
  }else{
  sd.pause();
  }
  
  if(e<10){
  se.play();
  }else{
  se.pause();
  }
  
  if(f<10){
  sf.play();
  }else{
  sf.pause();
  }
  
  
  
  
}

void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  int inByte = myPort.read();
  // if this is the first byte received, and it's an A,
  // clear the serial buffer and note that you've
  // had first contact from the microcontroller.
  // Otherwise, add the incoming byte to the array:
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }
  }
  else {
    // Add the latest byte from the serial port to array:
    serialInArray[serialCount] = inByte;
    serialCount++;

    // If we have 3 bytes:
    if (serialCount > 5 ) {
      a = serialInArray[0];
      b = serialInArray[1];
      c = serialInArray[2];
      d = serialInArray[3];
      e = serialInArray[4];
      f = serialInArray[5];
      

      // print the values (for debugging purposes only):
      println(a + "\t" + b + "\t" + c + "\t" + d + "\t" + e + "\t" + f);

      // Send a capital A to request new sensor readings:
      myPort.write('A');
      // Reset serialCount:
      serialCount = 0;
    }
  }
}
