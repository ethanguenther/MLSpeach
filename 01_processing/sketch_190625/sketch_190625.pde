// Importing the library that will help us in sending and receiving the values from the Arduino
// You always need to import the serial library in addition to the VSync library
import vsync.*; 
import processing.serial.*;  

// Below libraries will connect and send, receive OSC messages
import oscP5.*;  
import netP5.*;

// Creating the instances to connect and send, receive OSC messages
OscP5 oscP5;
NetAddress dest;
OscP5 oscP5_wekinator;
NetAddress dest_wekinator;

// New ValueSender to send values to arduino
ValueSender sender;

// The below variables will be syncronized with the Arduino and they should be same on the both sides.
public int output;
public int output_browser;
public int output_wekinator;


void setup() 
{
  // Starting the serial communication, the baudrate and the com port should be same as on the Arduino side.
  Serial serial = new Serial(this, "/dev/cu.SLAB_USBtoUART", 9600);

  //  Ininialize the ValueReceiver and ValueSender with this (to hook it to your sketch)
  //  and the serial interface you want to use.
  sender = new ValueSender(this, serial);

  // Synchronizing the variables as on the Arduino side. The order should be same.
  sender.observe("output");

  // Starting the OSC Communication. listen on port 9000, return messages on port 8000
  oscP5 = new OscP5(this, 9000); 
  dest = new NetAddress("127.0.0.1", 8000);

  oscP5_wekinator = new OscP5(this, 12000);
  dest_wekinator = new NetAddress("127.0.0.1", 6448);
}

void draw() {
}

// Recieve OSC messages from browser
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/word") == true) {
    // Receiving the output from browser
    output_browser = theOscMessage.get(0).intValue();  
  }
  else if (theOscMessage.checkAddrPattern("/output_1") == true) {
    output_wekinator = 1;
  }
  else if (theOscMessage.checkAddrPattern("/output_2") == true) {
    output_wekinator = 2;
  }
  
  if (output_browser == 3 && output_wekinator == 1) {
    output = 1;
    println(output);
  }
  else if (output_browser == 3 && output_wekinator == 2) {
    output = 2;
    println(output);
  }
}
