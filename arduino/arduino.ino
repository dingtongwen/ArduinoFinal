// 引用 Servo Library
#include <Servo.h>
#include <NewPing.h> 

#define TRIGGER_PIN  12  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     11  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 90

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);
                                                                            

// 建立一個 Servo 物件 
Servo myservo1; 
Servo myservo; 

int s0 = 0; 
int s1 = 0;  
int s2 = 0;
int s3 = 0; 
int s4 = 0;  
int s5 = 0;     
int inByte = 0;         // incoming serial byte

void setup() {
  // start serial port at 9600 bps:
  Serial.begin(9600);
   myservo1.attach(9);  // Servo 接在 pin 9
  myservo.attach(10);


  pinMode(TRIGGER_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  establishContact();  // send a byte to establish contact until receiver responds
}

void loop() {
  // if we get a valid byte, read analog ins:
  if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();
    
    s0 = analogRead(0);
    // delay 10ms to let the ADC recover:
    delay(10);
    
    s1 = analogRead(1);
    
    s2 = analogRead(2);
    
    s3 = analogRead(3);
    s4 = analogRead(4);
    s5 = analogRead(5);
    
    Serial.write(s0);
    Serial.write(s1);
    Serial.write(s2);
    Serial.write(s3);
    Serial.write(s4);
    Serial.write(s5);  

    
   
    
                    
  }

    

    myservo1.write(0); 
    myservo.write(100); 
    
    delay(10);
    myservo1.write(90); 
    myservo.write(0); 

    delay(10); 

}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}
