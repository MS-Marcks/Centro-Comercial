#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>


#include <SPI.h>
#include <MFRC522.h>


#define WIFI_SSID "LG K4 (2017)"
#define WIFI_PASSWORD "123456789"

const char* server = "apicomercial.pvivirtual.com";

#define RST_PIN  0
#define SS_PIN  4
char dato = ' ';
MFRC522 mfrc522(SS_PIN, RST_PIN);

void setup() {
  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());


  SPI.begin();
  mfrc522.PCD_Init();
  mfrc522.PICC_HaltA();
  menu();

}
void loop() {
  CapturarTexto();
  if (dato != ' ') {
    if (dato == '1') {
      Reportar();
    } else if (dato == '2') {
      Reportar();
    } else if (dato == '3') {
      Reportar();
    }
  }

}
void Reportar() {
  Serial.println("PASE LA TARJETA....");
  while (!mfrc522.PICC_IsNewCardPresent()) {
    delay(500);
  }
  while (!mfrc522.PICC_ReadCardSerial()) {
    delay(500);
  }
  String uuid = "";
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    if (mfrc522.uid.uidByte[i] < 0x10) {
      uuid += "0";
    }
    uuid += mfrc522.uid.uidByte[i];
  }

  Serial.println("GUARDANDO....");
  Registrar(uuid, dato);


  mfrc522.PICC_HaltA();
  menu();

  dato = ' ';

}

void menu() {
  Serial.println("========================== MENU =========================");
  Serial.println("1) INGRESO");
  Serial.println("2) REGRESO");
  Serial.println("3) SALIR");
  Serial.println("OPCION.....");
}
void CapturarTexto() {
  if (Serial.available() > 0)
  {
    dato = Serial.read();
  }
}

void Registrar(String uuid, char estado) {
  HTTPClient http;
  http.begin("http://apicomercial.pvivirtual.com/api/sistema/acceso/"+String(uuid)+"/"+String(estado));
  int httpCode = http.GET();
  String payload = http.getString();
  Serial.println(payload);
  http.end();
}
