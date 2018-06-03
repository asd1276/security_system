import processing.serial.*; // import serial communication library

Serial myPort; // the port the Arduino is connected to
String message; // the message the Arduino receives

boolean tab1Over = true; // main house tab hover state
boolean tab2Over = false; // treasure house tab hover state
int fill1 = 225; // main house tab color; default: white
int fill2 = 105; // treasure house tab color; default: gray

String mainCircleColor = "green"; // main house location circle color
String mainStatusColor = "green"; // main house security system status text color
String motionStatusColor = "green"; // motion sensor status text color
String mainStatus = "ON"; // main house security system status
String motionStatus = "SAFE"; // motion sensor status

String treasureCircleColor = "green"; // treasure house location circle color
String treasureStatusColor = "green"; // treasure house security system status text color
String laserStatusColor = "green"; // laser status text color
String treasureStatus = "ON"; // treasure house security system status
String laserStatus = "SAFE"; // laser status

PImage img; // map

void setup() {
   // set up visualization:
   size(1130, 650);
   background(0);
   
   // set up serial communications: 
   myPort = new Serial(this,Serial.list()[0],9600);
   myPort.bufferUntil('\n');
   
   readMsg(); // read message from Arduino
   
   // set up information visualization:
   stroke(0);
   fill(255);
   rect(6.5, 46.5, 750, 600, 0, 12, 12, 12);
   
   // display main house security system status:
   fill(0);
   textSize(50);
   text("Security System: ", 20, 100);
   if (mainStatusColor.equals("green")) {
      fill(50, 205, 50);
   } else if (mainStatusColor.equals("black")) {
      fill(0);
   } else {
      fill(255, 0, 0);
   }
   text(mainStatus, 420, 100);
   
   // display motion sensor status:
   fill(0);
   textSize(30);
   text("Motion Sensor Status: ", 20, 160);
   if (motionStatusColor.equals("green")) {
      fill(50, 205, 50);
   } else if (motionStatusColor.equals("black")) {
      fill(0);
   } else {
      fill(255, 0, 0);
   }
   text(motionStatus, 340, 160);
   
   // set up map:
   img = loadImage("mapimage.jpg");
   image(img, 763, height * 0.01);
   
   // display main house location:
   if (mainCircleColor.equals("green")) {
      fill(50, 205, 50);
   } else if (mainCircleColor.equals("black")) {
      fill(0);
   } else {
      fill(255, 0, 0);
   }
   ellipse(900, 300, 20, 20);
   
   // display treasure house location:
   if (treasureCircleColor.equals("green")) {
      fill(50, 205, 50);
   } else if (treasureCircleColor.equals("black")) {
      fill(0);
   } else {
      fill(255, 0, 0);
   }
   ellipse(980, 210, 20, 20);
}

void draw() {
   update(mouseX, mouseY); // update mouse position
   
   // change tab colors based on which one is selected
   // if main house tab is selected:
   if(tab1Over){
      // set main house tab to white:
      fill(fill1);
      rect(6.5, height * 0.01, 200, 40, 12, 12, 0, 0);
      
      // set treasure house tab to gray:
      fill(fill2);
      rect(208.5,height * 0.01, 200, 40, 12, 12, 0, 0);
      
   // if treasure house tab is selected:
   } else {
      // set main house tab color to gray:
      fill(fill1);
      rect(6.5, height * 0.01, 200, 40, 12, 12, 0, 0);
      
      // set treasure house tab color to white:
      fill(fill2);
      rect(208.5, height * 0.01, 200, 40, 12, 12, 0, 0);
   }
   
   // label tabs:
   fill(0);
   textSize(24);
   text("Main House", 32, 35);
   text("Treasure House", 218, 35);
   
   // update main house location status:
   if (mainCircleColor.equals("green")) {
      fill(50, 205, 50);
   } else if (mainCircleColor.equals("black")) {
      fill(0);
   } else {
      fill(255, 0, 0);
   }
   ellipse(900, 300, 20, 20);
   
   // update treasure house location status:
   if (treasureCircleColor.equals("green")) {
      fill(50, 205, 50);
   } else if (treasureCircleColor.equals("black")) {
      fill(0);
   } else {
      fill(255, 0, 0);
   }
   ellipse(980, 210, 20, 20);
   
   // if main house tab is selected:
   if (fill1 == 225) {
      // change tab colors:
      fill1 = 225; // main house tab: white
      fill2 = 105; // treasure house tab: gray
      
      // clear information visualization:
      fill(255);
      rect(6.5, 46.5, 750, 600, 0, 12, 12, 12);
      
      // display main house security system status:
      fill(0);
      textSize(50);
      text("Security System: ", 20, 100);
      if (mainStatusColor.equals("green")) {
         fill(50, 205, 50);
      } else if (mainStatusColor.equals("black")) {
         fill(0);
      } else {
         fill(255, 0, 0);
      }
      text(mainStatus, 420, 100);
      
      // display motion sensor status:
      fill(0);
      textSize(30);
      text("Motion Sensor Status: ", 20, 160);
      if (motionStatusColor.equals("green")) {
         fill(50, 205, 50);
      } else if (motionStatusColor.equals("black")) {
         fill(0);
      } else {
         fill(255, 0, 0);
      }
      text(motionStatus, 340, 160);
   }
   
   // if treasure house tab is selected:
   if (fill2 == 225) {
      // change tab colors:
      fill1 = 105; // main house tab: gray
      fill2 = 225; // treasure house tab: white
      
      // clear information visualization:
      fill(255);
      rect(6.5, 46.5, 750, 600, 0, 12, 12, 12);
      
      // display treasure house security system status:
      fill(0);
      textSize(50);
      text("Security System: ", 20, 100);
      if (treasureStatusColor.equals("green")) {
         fill(50, 205, 50);
      } else if (treasureStatusColor.equals("black")) {
         fill(0);
      } else {
         fill(255, 0, 0);
      }
      text(treasureStatus, 420, 100);
      
      // display laser status:
      fill(0);
      textSize(30);
      text("Laser Sensor Status: ", 20, 160);
      if (laserStatusColor.equals("green")) {
         fill(50, 205, 50);
      } else if (laserStatusColor.equals("black")) {
         fill(0);
      } else {
         fill(255, 0, 0);
      }
      text(laserStatus, 315, 160);
   }

   readMsg(); // read message from Arduino
}

// referenced https://processing.org/examples/rollover.html for update method
// if a tab is hovered over:
void update(int x, int y) {
   // if main house tab is hovered over:
   if (overTab(6.5, height * 0.01, 200, 40) ) {
      tab1Over = true;
      tab2Over = false;
      
   // if treasure house tab is hovered over:
   } else if (overTab(208.5, height * 0.01, 200,40) ) {
      tab1Over = false;
      tab2Over = true;
      
   // if neither tab is hovered over:
   } else {
      tab2Over = tab1Over = false;
   }
}

// referenced https://processing.org/examples/rollover.html for overTab method
// tests if mouse is hovering over a tab:
boolean overTab (float x, float y, int width, int height)  {
   if (mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height) {
      return true;
   } else {
      return false;
   }
}

// if mouse is pressed:
void mousePressed() {
   // if main house tab is selected:
   if (tab1Over) {
      // change tab colors:
      fill1 = 225; // main house tab: white
      fill2 = 105; // treasure house tab: gray
      
      // clear information visualization:
      fill(255);
      rect(6.5, 46.5, 750, 600, 0, 12, 12, 12);
      
      // display main house security system status:
      fill(0);
      textSize(50);
      text("Security System: ", 20, 100);
      if (mainStatusColor.equals("green")) {
         fill(50, 205, 50);
      } else if (mainStatusColor.equals("black")) {
         fill(0);
      } else {
         fill(255, 0, 0);
      }
      text(mainStatus, 420, 100);
      
      // display motion sensor status:
      fill(0);
      textSize(30);
      text("Motion Sensor Status: ", 20, 160);
      if (motionStatusColor.equals("green")) {
         fill(50, 205, 50);
      } else if (motionStatusColor.equals("black")) {
         fill(0);
      } else {
         fill(255, 0, 0);
      }
      text(motionStatus, 340, 160);
   }
   
   // if treasure house tab is selected:
   if (tab2Over) {
      // change tab colors:
      fill1 = 105; // main house tab: gray
      fill2 = 225; // treasure house tab: white
      
      // clear information visualization:
      fill(255);
      rect(6.5, 46.5, 750, 600, 0, 12, 12, 12);
      
      // display treasure house security system status:
      fill(0);
      textSize(50);
      text("Security System: ", 20, 100);
      if (treasureStatusColor.equals("green")) {
         fill(50, 205, 50);
      } else if (treasureStatusColor.equals("black")) {
         fill(0);
      } else {
         fill(255, 0, 0);
      }
      text(treasureStatus, 420, 100);
      
      // display laser status:
      fill(0);
      textSize(30);
      text("Laser Sensor Status: ", 20, 160);
      if (laserStatusColor.equals("green")) {
         fill(50, 205, 50);
      } else if (laserStatusColor.equals("black")) {
         fill(0);
      } else {
         fill(255, 0, 0);
      }
      text(laserStatus, 315, 160);
   }
}

// read message from the Arduino and change house status:
void readMsg(){
   // if the data is available:
   if (myPort.available() > 0) {
      message = myPort.readStringUntil('\n');
      message = trim(message);
      println(message);
      if (message != null){
         // if main house security system is on:
         if (message.equals("main on")) {
            mainCircleColor = "green";
            mainStatusColor = "green";
            motionStatusColor = "green";
            mainStatus = "ON";
            motionStatus = "SAFE";
         }
         
         // if main house security system is off:
         else if (message.equals("main off")) {
            mainCircleColor = "black";
            mainStatusColor = "black";
            motionStatusColor = "black";
            mainStatus = "OFF";
            motionStatus = "N/A";
         }
         
         // if main house security system has a password error:
         else if(message.equals("main password")) {
            mainCircleColor = "red";
            mainStatusColor = "red";
            mainStatus = "PASSWORD";
         }
         
         // if motion sensor is tripped:
         if (message.equals("motion trip")) {
            mainCircleColor = "red";
            motionStatusColor = "red";
            motionStatus = "INTRUDER";
         }
         
         // if treasure house security system is on:
         if(message.equals("treasure on")) {
            treasureCircleColor = "green";
            treasureStatusColor = "green";
            laserStatusColor = "green";
            treasureStatus = "ON";
            laserStatus = "SAFE";
         }
         
         // if treasure house security system is off:
         else if (message.equals("treasure off")) {
            treasureCircleColor = "black";
            treasureStatusColor = "black";
            laserStatusColor = "black";
            treasureStatus = "OFF";
            laserStatus = "N/A";
         }
         
         // if treasure house security system has a password error:
         else if (message.equals("treasure password")) {
            treasureCircleColor = "red";
            treasureStatusColor = "red";
            treasureStatus = "PASSWORD";
         }
         
         // if laser is tripped:
         if (message.equals("laser trip")) {
            treasureCircleColor = "red";
            laserStatusColor = "red";
            laserStatus = "INTRUDER";
         }
      }
   }
}
