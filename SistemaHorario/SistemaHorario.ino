#include <SoftwareSerial.h>
SoftwareSerial SerialESP8266(3, 2); // RX, TX

String server = "www.apicomercial.pvivirtual.com";

String cadena = "";

#include <SPI.h>
#include <MFRC522.h>

#define RST_PIN         9
#define SS_PIN          10

String Estado = "0";
char dato = ' ';
MFRC522 mfrc522(SS_PIN, RST_PIN);

void setup() {

  SerialESP8266.begin(9600);
  Serial.begin(9600);
  SerialESP8266.setTimeout(2000);

  SerialESP8266.println("AT");
  if (SerialESP8266.find("OK")) {
    Serial.println("Respuesta AT correcto");
  } else {
    Serial.println("Error en ESP8266");
  }

  SerialESP8266.println("AT+CWMODE=1");
  if (SerialESP8266.find("OK")) {
    Serial.println("ESP8266 en modo Estacion");
  }

  SerialESP8266.println("AT+CWJAP=\"MarcksPC\",\"12345678\"");
  Serial.println("Conectandose a la red ...");
  SerialESP8266.setTimeout(10000);
  if (SerialESP8266.find("OK")) {
    Serial.println("WIFI conectado");
  } else {
    Serial.println("Error al conectarse en la red");
  }
  SerialESP8266.setTimeout(2000);
  SerialESP8266.println("AT+CIPMUX=0");
  if (SerialESP8266.find("OK")) {
    Serial.println("Multiconexiones deshabilitadas");
  }
  delay(1000);

  while (!Serial);
  SPI.begin();
  mfrc522.PCD_Init();
  delay(4);
  menu();
}

void loop() {
  CapturarTexto();
  if (dato != ' ') {
    if (dato == '1') {
      Serial.println("PASE LA TARJETA PARA INGRESAR....");
      Marcar();
    } else if (dato == '2') {
      Serial.println("PASE LA TARJETA PARA REGRESO O REGRESAR....");
      Marcar();
    } else if (dato == '3') {
      Serial.println("PASE LA TARJETA PARA RETIRARSE....");
      Marcar();
    }
  }
}

void Marcar() {
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
  Serial.println(String(uuid));
  EnviarDatos(uuid, dato);
  mfrc522.PICC_HaltA();
}

void menu() {
  Serial.println("========================== MENU =========================");
  Serial.println("1) INGRESAR");
  Serial.println("2) REGRESAR");
  Serial.println("3) SALIDA");
  Serial.println("OPCION.....");
}
void CapturarTexto() {
  if (Serial.available() > 0)
  {
    dato = Serial.read();
  }
}
void EnviarDatos(String uuid, char estado) {

  SerialESP8266.println("AT+CIPSTART=\"TCP\",\"" + server + "\",80");
  while (SerialESP8266.available() > 0)
  {
    char c = SerialESP8266.read();
    Serial.write(c);
  }
  if ( SerialESP8266.find("OK"))
  {
    Serial.println();
    Serial.println();
    Serial.println();
    Serial.println("ESP8266 conectado con el servidor...");

    String peticionHTTP = "GET /api/sistema/acceso/" + String(uuid) + "/" + String(estado);
    peticionHTTP = peticionHTTP + " HTTP/1.1\r\n";
    peticionHTTP = peticionHTTP + "Host: www.apicomercial.pvivirtual.com\r\n\r\n";

    SerialESP8266.print("AT+CIPSEND=");
    SerialESP8266.println(peticionHTTP.length());

    if (SerialESP8266.find(">"))
    {
      Serial.println("Enviando HTTP . . .");
      SerialESP8266.println(peticionHTTP);
      if ( SerialESP8266.find("SEND OK"))
      {
        Serial.println("Peticion HTTP enviada:");
        Serial.println();
        Serial.println(peticionHTTP);
        Serial.println("Esperando respuesta...");

        boolean fin_respuesta = false;
        long tiempo_inicio = millis();
        cadena = "";

        while (fin_respuesta == false)
        {
          while (SerialESP8266.available() > 0)
          {
            char c = SerialESP8266.read();
            Serial.write(c);
            cadena.concat(c);
          }

          if (cadena.length() > 1024)
          {
            Serial.println("La respuesta a excedido el tamaÃ±o maximo");

            SerialESP8266.println("AT+CIPCLOSE");
            if ( SerialESP8266.find("OK"))
              Serial.println("Conexion finalizada");
            fin_respuesta = true;
            dato = ' ';
            menu();

          }
          if ((millis() - tiempo_inicio) > 100000)
          {
            Serial.println("Tiempo de espera agotado");
            SerialESP8266.println("AT+CIPCLOSE");
            if ( SerialESP8266.find("OK"))
              Serial.println("Conexion finalizada");
            fin_respuesta = true;
            dato = ' ';
            menu();

          }
          if (cadena.indexOf("CLOSED") > 0)
          {
            Serial.println();
            Serial.println("Cadena recibida correctamente, conexion finalizada");
            fin_respuesta = true;
            dato = ' ';
            menu();
          }
        }
      }
      else
      {
        Serial.println("No se ha podido enviar HTTP.....");
        dato = ' ';
        menu();
      }
    }
  }
  else
  {
    Serial.println("No se ha podido conectarse con el servidor");
    dato = ' ';
    menu();
  }

}
