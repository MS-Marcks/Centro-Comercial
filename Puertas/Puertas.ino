//================================================
// Librerias
//================================================
#include <NewPing.h>
#include <pt.h>
#include <Servo.h>

//================================================
// PINES
//================================================
#define servopuertaPin 8
#define servoestacionPin 9

//=============================================================
// PROXIMETRO 1
//==============================================================
#define trigEstacionPin 13 //AMARRILLO
#define echoEstacionPin 12 // MORADO

//=============================================================
// PROXIMETRO 2
//==============================================================
#define trigPuertaPin 4
#define echoPuertaPin 3

//================================================
// VARIABLES GLOBALES
//================================================
#define MAX_DISTANCE  200

Servo servoMotorEstacion;
Servo servoMotorPuerta;

NewPing sonarEstacionamiento(trigEstacionPin, echoEstacionPin, MAX_DISTANCE);
NewPing sonarPuerta(trigPuertaPin, echoPuertaPin, MAX_DISTANCE);

bool HabilitarEstacion = false, habilitoEstacion = false, HabilitarPuerta = false, habilitoPuerta = false;
int iE = 0, kE = 0, iP = 0, kP = 0;

//================================================
// HILOS EN EL PROGRAMA
//================================================
struct pt ProximetroEstacionamiento;
struct pt ServoMotorEstacionamiento;

struct pt ProximetroPuertaPrincipal;
struct pt ServoMotorPuertaPrincipal;

void setup() {
  Serial.begin(9600);

  PT_INIT(&ServoMotorEstacionamiento);
  PT_INIT(&ProximetroEstacionamiento);

  PT_INIT(&ServoMotorPuertaPrincipal);
  PT_INIT(&ProximetroPuertaPrincipal);

  servoMotorEstacion.attach(servoestacionPin);
  servoMotorPuerta.attach(servopuertaPin);

  pinMode(trigEstacionPin, OUTPUT);
  pinMode(echoEstacionPin, INPUT);

  pinMode(trigPuertaPin, OUTPUT);
  pinMode(echoEstacionPin, INPUT);

  servoMotorEstacion.write(0);
  servoMotorPuerta.write(0);
}

void loop() {
  fun_ProximetroEstacionamiento(&ProximetroEstacionamiento);
  fun_ProximetroPuerta(&ProximetroPuertaPrincipal);
  fun_ServoEstacionamiento(&ServoMotorEstacionamiento);
  fun_ServoPuerta(&ServoMotorPuertaPrincipal);
}

void fun_ProximetroEstacionamiento(struct pt *pt) {
  PT_BEGIN(pt);
  static long t = 0;
  do {
    t = millis(); PT_WAIT_WHILE(pt, (millis() - t) < 50);
    long distanciaE = sonarEstacionamiento.ping_cm();
    if ( distanciaE < 10 && distanciaE != 0) {
      HabilitarEstacion = true;
      Serial.print("hola");
    } else {
      HabilitarEstacion = false;
    }
  } while (true);
  PT_END(pt);
}

void fun_ProximetroPuerta(struct pt *pt) {
  PT_BEGIN(pt);
  static long t = 0;
  do {
    t = millis(); PT_WAIT_WHILE(pt, (millis() - t) < 50);
    long distanciaP = sonarPuerta.ping_cm();
    if ( distanciaP < 10 && distanciaP != 0) {
      HabilitarPuerta = true;
      Serial.println("adios");
    } else {
      HabilitarPuerta = false;
    }
  } while (true);
  PT_END(pt);
}

void fun_ServoEstacionamiento(struct pt *pt) {
  PT_BEGIN(pt);
  static long t = 0;
  do {
    if (HabilitarEstacion == true && habilitoEstacion == false) {
      for (iE = 0; iE <= 90 ; iE += 15) {
        servoMotorEstacion.write(iE);
        t = millis(); PT_WAIT_WHILE(pt, (millis() - t) < 100);
      }
      habilitoEstacion = true;
    } else if (HabilitarEstacion == false && habilitoEstacion == true) {
      t = millis(); PT_WAIT_WHILE(pt, (millis() - t) < 5000);
      for (kE = 90; kE >= 0 ; kE -= 15) {
        servoMotorEstacion.write(kE);
        t = millis(); PT_WAIT_WHILE(pt, (millis() - t) < 100);
      }
      habilitoEstacion = false;
    }
    t = millis(); PT_WAIT_WHILE(pt, (millis() - t) < 1000);
  } while (true);
  PT_END(pt);
}

void fun_ServoPuerta(struct pt *pt) {
  PT_BEGIN(pt);
  static long t = 0;
  do {
    if (HabilitarPuerta == true && habilitoPuerta == false) {
      for (iP = 90; iP >= 0 ; iP -= 15) {
        servoMotorPuerta.write(iP);
        t = millis(); PT_WAIT_WHILE(pt, (millis() - t) < 100);
      }
      habilitoPuerta = true;
    } else if (HabilitarPuerta == false && habilitoPuerta == true) {
      t = millis(); PT_WAIT_WHILE(pt, (millis() - t) < 5000);
      for (kP = 0; kP <= 90 ; kP += 15) {
        servoMotorPuerta.write(kP);
        t = millis(); PT_WAIT_WHILE(pt, (millis() - t) < 100);
      }
      habilitoPuerta = false;
    }
    t = millis(); PT_WAIT_WHILE(pt, (millis() - t) < 1000);
  } while (true);
  PT_END(pt);
}
