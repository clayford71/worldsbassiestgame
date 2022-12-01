#include "arduinoFFT.h"

#define SAMPLES 128
#define SAMPLING_FREQUENCY 2048

arduinoFFT FFT = arduinoFFT();

unsigned int samplingPeriod;
unsigned long microSeconds;

double vReal[SAMPLES];
double vImag[SAMPLES];
int peak;

void setup() {
  // put your setup code here, to run once:

  Serial.begin(9600);
  samplingPeriod = round(1000000 * (1.0/SAMPLING_FREQUENCY));

}

void loop() {
  // put your main code here, to run repeatedly:

  for (int i = 0; i < SAMPLES; i++){

    microSeconds = micros();

    vReal[i] = analogRead(0);
    vImag[i] = 0;

    while (micros() < (microSeconds + samplingPeriod)){
      //do nothing
    }
  }

  FFT.Windowing(vReal, SAMPLES, FFT_WIN_TYP_HAMMING, FFT_FORWARD);
  FFT.Compute(vReal, vImag, SAMPLES, FFT_FORWARD);
  FFT.ComplexToMagnitude(vReal, vImag, SAMPLES);

  peak = simplify( FFT.MajorPeak(vReal, SAMPLES, SAMPLING_FREQUENCY) );
  //Serial.println(peak);

  sendData();

  //while(1);
}

float getSmoothRead (int analogPin) {

  // represents the sum of all collected readings
  static float sum = 0;

  // represents the amount of readings that are performed
  const int numReads = 100;

  // an array that holds every reading
  static int readingArray[numReads];
  static int index = 0;

// variable representing the reading from the pin
  int reading = analogRead(analogPin);

  // remove the old reading from sum
  sum -= readingArray[index];
  
  // add new reading to sum and array
  sum += reading;
  readingArray[index] = reading;

  // updates index and ensures proper reset
  index += 1;

  if (index >= numReads){
    index = 0;
  }

  // returns the average, represented by the total sum divided by the number of readings
  int average = sum / numReads;
  return average;
}

int simplify (int aNumber){
  
  int simpleAnswer;

  //Serial.println(aNumber);
  
  if ((aNumber > 70 && aNumber < 100) || (aNumber > 155 && aNumber < 175)){
    simpleAnswer = 1;
  }
  if (aNumber > 100 && aNumber < 120){
    simpleAnswer = 2;
  }
  if (aNumber > 120 && aNumber < 140){
    simpleAnswer = 3;
  }
  if (aNumber > 140 && aNumber < 155){
    simpleAnswer = 4;
  }
  if (aNumber > 155 || aNumber < 70){
    simpleAnswer = 0;
  }
  //Serial.println(simpleAnswer);
  return simpleAnswer;
}

void sendData(){
  String message = String(peak);
  Serial.print(message);
}
