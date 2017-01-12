#include <AccelStepper.h>
//https://forum.processing.org/two/discussion/7055/working-integer-data-to-and-from-arduino-from-processing

const int motorAenable = 3;
const int motorAdir = 5;
const int motorAstep = 6;

void setup() {
  // initialize serial:
  Serial.begin(9600);
  // make the pins outputs:
  pinMode(motorAenable, OUTPUT);
  pinMode(motorAdir, OUTPUT);
  pinMode(motorAstep, OUTPUT);

}


void loop() {
  while (Serial.available() > 0){
    serialRead = Serial.read();
     if (serialRead == 'A'){
       servoAVal = Serial.read();
     }
     if (serialRead == 'B'){
       servoBVal = Serial.read();
     }
  } 
}
