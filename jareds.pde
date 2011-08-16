/*
  this is my code.. nihaopaul @ gmail o com
  i will use it to win the race :D
*/



int trig_l = 7;
int trig_r = 12;
// ultrasonic sensors ping array..

// ultrasonic sensor reply
int rx_l = 8;
int rx_r = 13;


int drivep1 = 10; 
int drivep2 = 9; 
int steerp1 = 6;
int steerp2 = 5;



//store variables
int l,r;



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

void loop() {

  ping();

  //output the distacne
  Serial.print("LEFT: \t" );
  Serial.print(l, DEC);
  Serial.print("\t Right: \t");
  Serial.println(r,DEC);
  //drive logic

  delay(100);

}

void ping() {
 //get a distance
  digitalWrite(trig_l, LOW);
  delayMicroseconds(2);
  digitalWrite(trig_l, HIGH);
  delay(5);
  digitalWrite(trig_l, LOW);

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
