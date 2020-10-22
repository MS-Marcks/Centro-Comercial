#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>

#include <SPI.h>    
#include <MFRC522.h>

#include <DHT.h>

#define FIREBASE_HOST "centro-comercial-617c3.firebaseio.com"
#define FIREBASE_AUTH "V4ypsu2QTycLJZ3TJxempMvIqYkE6ae2K26ebNWK"
#define WIFI_SSID "MarcksPC"
#define WIFI_PASSWORD "12345678"

#define DHTPIN 5
#define DHTTYPE DHT11

DHT dht(DHTPIN, DHTTYPE);
long OnTimedht = 350;
long OffTimedht = 350;
bool Statedht = true;
unsigned long previousMillisdht;


#define SENSOR1 16
long OnTimesensor1 = 350;
long OffTimesensor1 = 350;
bool Statesensor1 = true;
boolean valsensor1;
unsigned long previousMillissensor1;


#define SENSOR2 4
long OnTimesensor2 = 350;
long OffTimesensor2 = 350;
bool Statesensor2 = true;
boolean valsensor2;
unsigned long previousMillissensor2;

#define RST_PIN  9     
#define SS_PIN  10     

MFRC522 mfrc522(SS_PIN, RST_PIN); 

void setup() {
  Serial.begin(115200);
  dht.begin();
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.set("tiendas", "");
  pinMode (SENSOR1, INPUT);
  pinMode (SENSOR2, INPUT);
}

void loop() {
  unsigned long currentMillis = millis();
  DetectoHumTemp1(currentMillis);
  Sensor1(currentMillis);
  Sensor2(currentMillis);

}
void DetectoHumTemp1(unsigned long currentMillis) {
  if ((Statedht == true) && (currentMillis - previousMillisdht >= OnTimedht))
  {
    Statedht = false;
    previousMillisdht = currentMillis;
    float temp = dht.readTemperature();
    float hum = dht.readHumidity();
    if (isnan(temp) || isnan(hum)) {
      Serial.println("Error obteniendo datos");
    } else {
      Firebase.setFloat("tiendas/0/temp", temp);
      Firebase.setFloat("tiendas/0/hum", hum);
    }
  }
  else if ((Statedht == false) && (currentMillis - previousMillisdht >= OffTimedht))
  {
    Statedht = true;
    previousMillisdht = currentMillis;
  }
}

void Sensor1(unsigned long currentMillis) {
  if ((Statesensor1 == true) && (currentMillis - previousMillissensor1 >= OnTimesensor1))
  {
    Statesensor1 = false;
    previousMillissensor1 = currentMillis;
    valsensor1 = !digitalRead(SENSOR1);
    //estadoanterior= val;
    //if()
    Firebase.setInt("estacionamiento/0/ocupado", valsensor1);

  }
  else if ((Statesensor1 == false) && (currentMillis - previousMillissensor1 >= OffTimesensor1))
  {
    Statesensor1 = true;
    previousMillissensor1 = currentMillis;
  }
}

void Sensor2(unsigned long currentMillis) {
  if ((Statesensor2 == true) && (currentMillis - previousMillissensor2 >= OnTimesensor2))
  {
    Statesensor2 = false;
    previousMillissensor1 = currentMillis;
    valsensor2 = !digitalRead(SENSOR2);
    //estadoanterior= val;
    //if()
    Firebase.setInt("estacionamiento/1/ocupado", valsensor2);

  }
  else if ((Statesensor2 == false) && (currentMillis - previousMillissensor2 >= OffTimesensor2))
  {
    Statesensor2 = true;
    previousMillissensor2 = currentMillis;
  }
}
