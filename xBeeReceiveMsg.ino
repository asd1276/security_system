//This code is modified version of xBeeREceiveMsg code given to us by Brock in Lecture.

// xBeeReceiveMsg
// demo to receive data from the xBee, and collect them as discrete messages
// a message is any sequence of characters, terminated by a newLine

#include <SoftwareSerial.h>

//buzzer for incomming messsage and led for indicator
const int ledPin = 13;
const int beepPin = 12;

//pin numbers for each buttons
const int clearMain = 7;
const int clearTreasure = 10;

//used to read the states of the each button
int buttonState1 = 0;
int buttonState2 = 0;

//used to format msg comming from xBee
const String tabChar = "\t";
const byte newLineChar = 0x0A;

// initialize the serial port for the xBee with whatever pins are used for it
SoftwareSerial xBee(2, 3); // (TX, RX) : pins on XBee adapter

int messages = 0;         // counts the number of messages that have been received

// the following two global variables are used by the XBee reading method 'checkMessageReceived()'.
// please don't tell any of *my* CS professors that I gave this code to anyone as an example;
// I'm afraid I might have my credentials as a CS instructor revoked.

bool msgComplete = false; // true when an incoming message is complete
String msg = "";          // buffer to collect incoming message


void setup()  {

  // initialize our own serial monitor window
  Serial.begin(9600);
  //Serial.println("\n\nxBeeReceive");

  // set pin modes
  pinMode(ledPin, OUTPUT);
  pinMode(beepPin, OUTPUT);
  pinMode(clearMain, INPUT_PULLUP);
  pinMode(clearTreasure, INPUT_PULLUP);

  // initialize and set the data rate for the SoftwareSerial port -- to send/receive messages via the xBee
  xBee.begin(9600);

}


void loop() {

  // look to see if any complete incoming messages are ready
  checkMessageReceived();
 
  // so, the message will be found in the global String variable 'msg'
  if (msgComplete) {
    // this is just for debuging or tracking the message; you don't have to use it
    //messages++;
    digitalWrite(ledPin, HIGH);
    tone(beepPin, 220, 100);
    //Serial.print(messages);
    //Serial.print(" - message received: \n");
    Serial.println(msg);
    digitalWrite(ledPin, LOW);
    delay(1000);

    // now do whatever you are going to do with the message you just recieved --
    // it will be found in the global String variable 'msg'
    // very likely you might want to parse it using String object methods:
    //  https://www.arduino.cc/en/Reference/StringObject

    // when you're done handling the message, initialize the following two variables
    // to start over and wait for the next message
    msgComplete = false;
    msg = "";
  }

  //check the states of the buttons (if button is pressed or not)
  buttonState1 = digitalRead(clearMain);
  buttonState2 = digitalRead(clearTreasure);

  //if the main clear button is pushed, send message saying "main clear"
  if (buttonState1 == LOW) {
   xBee.write("main clear");
   Serial.println("main on");//when everything is clear the system gets turned on again
   Serial.println("1 ok"); //test code for button1
   delay(500); //buffer delay
  }
  
  //if the main clear button is pushed, send message saying "treasure clear"
  if (buttonState2 == LOW) {
    xBee.write("treasure clear");
    Serial.println("treasure on"); //when everything is clear the system gets turned on again
    //Serial.println("2 ok"); //test code for button2
    delay(500);//buffer delay
  }
  
    


}


// checks to see if a complete message (one terminated by a newLine) has been received
// if it has, the message will be found in the global String variable 'msg' (without the newLine)
// ... I know -- this is terrible programming practice, using global variables.
// ... this XBee reading thing should be a library, but I didn't have time to do that (yet)
void checkMessageReceived () {

  if (xBee.available()) {
    byte ch = xBee.read();
    if (ch == newLineChar) {
      msgComplete = true;
    }
    else {
      msg += char(ch);
    }
  }

}


