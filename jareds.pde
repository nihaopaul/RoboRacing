/*
  This is my code.. nihaopaul @ gmail o com
  I will use it to win the race :D
*/


// ultrasonic sensors ping array..
int trig_l = 7;
int trig_r = 12;


// ultrasonic sensor reply
int rx_l = 8;
int rx_r = 13;


//h-bridge shield
//left side and right side of the shield
int drivep1 = 10; 
int drivep2 = 9; 

int steerp1 = 6;
int steerp2 = 5;



//store variables of distance sensors, i like these global 
int l,r;

int val = 0; //<<----- delete me - just a dummy

/*
  The setup block is the first block run before going into loop(), 
  it's a good idea to set your pin modes here, i also use the serial output for debugging
*/
void setup() {
  
  
  //ping send
  pinMode(trig_l, OUTPUT);
  pinMode(trig_r, OUTPUT);
  
  //echo receive
  pinMode(rx_l, INPUT);
  pinMode(rx_r, INPUT);
  //
  Serial.begin(9600);
}

/*
The loop that keeps on running!
*/

void loop() {
  /*
   i've externalised the pinging as it's the same stuff, 
   i also want clean records when i make decissions.
  */
  ping();

  //output the distance in my serial terminal ^--- it's up there in arduino IDE
  Serial.print("LEFT: \t" );
  Serial.print(l, DEC);
  Serial.print("\t Right: \t");
  Serial.println(r,DEC);
  //drive logic/brains need to go in here.. 
  
  //i dont need an accurate delay, so i'll use a cheap delay
  delay(100);

}
/*
  PWM - at 5v analog signal
  see the 5 states:
  http://www.arduino.cc/en/Tutorial/PWM
  
  keep on calling forward() to increase the speed.
*/
void forward() {
  val = (val + 10) % 5;    // one of 5 states
  analogWrite(drivep1, val);  
  analogWrite(drivep2, 0);  
}

void reverse() {
  val = (val + 10) % 5;    // one of 5 states
  analogWrite(drivep1, 0);  
  analogWrite(drivep2, val);  
}

/*
if you have a cheap toy, 
it probably doesn't have precission stearing.. 
use digital - lower voltage on or off
*/

void left() {
  digitalWrite(steerp1,HIGH);
  digitalWrite(steerp2,LOW);
}
void right() {
  digitalWrite(steerp1,HIGH);
  digitalWrite(steerp2,LOW);
}
      

/* 
  either on or off - no PWM 1.5v
*/
void forward() {
  digitalWrite(drivep1,HIGH);
  digitalWrite(drivep2,LOW);
}

void reverse() {
  digitalWrite(drivep1,LOW);
  digitalWrite(drivep2,HIGH);
}

void left() {
  digitalWrite(steerp1,HIGH);
  digitalWrite(steerp2,LOW);
}
void right() {
  digitalWrite(steerp1,HIGH);
  digitalWrite(steerp2,LOW);
}


void ping() {
 //get a distance.. first make sure it's off
  digitalWrite(trig_l, LOW);
  //precission timing
  delayMicroseconds(2);
  //lets turn it on for a ping
  digitalWrite(trig_l, HIGH);
  //not so much of a precission, quick & dirty please
  delay(5);
  //ok we got our reply, done, lets turn it off again
  digitalWrite(trig_l, LOW);

  /*
   this is the left sensor, we get our data, 
   after HIGH you can also set the timeout to wait but this causes problems
   on the XCJ 5 ping Ultrasonic sensors (works great on the 4 pin ones)
   pulseIn(rx_l, HIGH, 2000) (wait and giveup after 2seconds)
  */
   l = microsecondsToCentimeters(pulseIn(rx_l, HIGH));
 
  //get a distance
  digitalWrite(trig_r, LOW);
  delayMicroseconds(2);
  digitalWrite(trig_r, HIGH);
  delay(5);
  digitalWrite(trig_r, LOW);

  r = microsecondsToCentimeters(pulseIn(rx_r, HIGH));
}




long microsecondsToCentimeters(long microseconds)
{
  // The speed of sound is 340 m/s or 29 microseconds per centimeter.
  // The ping travels out and back, so to find the distance of the
  // object we take half of the distance travelled.
  return microseconds / 29 / 2;
}
