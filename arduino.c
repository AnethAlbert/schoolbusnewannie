
#include <Adafruit_Fingerprint.h>
#include <Servo.h>

#if (defined(__AVR__) || defined(ESP8266)) && !defined(__AVR_ATmega2560__)
SoftwareSerial mySerial(2, 3); // SoftwareSerial for UNO and others without hardware serial
#else
#define mySerial Serial1 // Hardware serial for Leonardo/M0/etc.
#define FINGERPRINT_ERROR 0xFF // Define your custom error code

#endif

Adafruit_Fingerprint finger = Adafruit_Fingerprint(&mySerial);
uint8_t id;

// SERVO MOTOR
Servo myServo;
int ledRed = 10;
int ledGreen = 11;
int ledBlue = 12;

void setup() {
  Serial.begin(9600);
  myServo.attach(9);

  pinMode(ledRed, OUTPUT);
  pinMode(ledGreen, OUTPUT);
  pinMode(ledBlue, OUTPUT);

  myServo.write(0);

  while (!Serial);
  delay(100);
  Serial.println("\n\nAdafruit Fingerprint sensor combined sketch");

  finger.begin(57600);

  if (finger.verifyPassword()) {
    Serial.println("Found fingerprint sensor!");
  } else {
    Serial.println("Did not find fingerprint sensor :(");
    while (1) { delay(1); }
  }

  Serial.println(F("Reading sensor parameters"));
  finger.getParameters();
  Serial.print(F("Status: 0x")); Serial.println(finger.status_reg, HEX);
  Serial.print(F("Sys ID: 0x")); Serial.println(finger.system_id, HEX);
  Serial.print(F("Capacity: ")); Serial.println(finger.capacity);
  Serial.print(F("Security level: ")); Serial.println(finger.security_level);
  Serial.print(F("Device address: ")); Serial.println(finger.device_addr, HEX);
  Serial.print(F("Packet len: ")); Serial.println(finger.packet_len);
  Serial.print(F("Baud rate: ")); Serial.println(finger.baud_rate);
}


uint8_t readnumber(void) {
  uint8_t num = 0;
  while (num == 0) {
    while (! Serial.available());
    num = Serial.parseInt();
  }
  return num;
}


void loop() {
  Serial.println("Press 1 for fingerprint detection, 2 for enrollment, 3 for deletion, 4 to empty fingerprint database:");
  while (!Serial.available());
  char selection = Serial.read();

  switch (selection) {
    case '1':
      if (fingerprintDetection()) {
        // Fingerprint detected, return to prompt
        break;
      }
      break;
    case '2':
      fingerprintEnrollment();
      break;
    case '3':
      fingerprintDeletion();
      break;
    case '4':
      emptyFingerprintDatabase();
      break;
      case 'u':
      myServo.write(90);
      setColor(0, 255, 0); // Green
      break;
      case 'l':
      myServo.write(0);
      setColor(255 ,0, 0); // Red
      break;
    default:
      Serial.println("Invalid selection");
      break;
  }
}


bool fingerprintDetection() {
  Serial.println("Fingerprint detection mode");
  unsigned long startTime = millis(); // Record the start time

  while (millis() - startTime < 5000) { // Timeout duration of 5000 ms
    uint8_t result = getFingerprintID();
    if (result == FINGERPRINT_OK) {
      Serial.print("Fingerprint detected! ID:");
      Serial.println(finger.fingerID);

      return true; // Return true if fingerprint detected
    } else if (result == FINGERPRINT_NOFINGER) {
      // No finger detected, continue waiting
    } else {
      Serial.println("Error detecting fingerprint");
      break; // Exit the loop if an error occurs
    }
    delay(50);
  }

  // Timeout occurred, no fingerprint detected
  Serial.println("Fingerprint detection timeout");
  return false;
}


uint8_t getFingerprintID() {
  uint8_t consecutiveFailures = 0; // Variable to count consecutive failures
  while (consecutiveFailures < 4) { // Maximum 4 consecutive failures allowed
    uint8_t p = finger.getImage();
    switch (p) {
      case FINGERPRINT_OK:
        Serial.println("Image taken");
        break;
      case FINGERPRINT_NOFINGER:
        // Serial.println("No finger detected");
        return p;
      case FINGERPRINT_PACKETRECIEVEERR:
        Serial.println("Communication error");
        return p;
      case FINGERPRINT_IMAGEFAIL:
        Serial.println("Imaging error");
        return p;
      default:
        Serial.println("Unknown error");
        return p;
    }

    p = finger.image2Tz();
    switch (p) {
      case FINGERPRINT_OK:
        Serial.println("Image converted");
        break;
      case FINGERPRINT_IMAGEMESS:
        Serial.println("Image too messy");
        return p;
      case FINGERPRINT_PACKETRECIEVEERR:
        Serial.println("Communication error");
        return p;
      case FINGERPRINT_FEATUREFAIL:
        Serial.println("Could not find fingerprint features");
        return p;
      case FINGERPRINT_INVALIDIMAGE:
        Serial.println("Could not find fingerprint features");
        return p;
      default:
        Serial.println("Unknown error");
        return p;
    }

    p = finger.fingerSearch();
    switch (p) {
      case FINGERPRINT_OK:
        return p; // Return success
      case FINGERPRINT_NOTFOUND:
        Serial.println("No match found");
        Serial.println("false");
        consecutiveFailures++; // Increment consecutive failures
        break;
      case FINGERPRINT_PACKETRECIEVEERR:
        Serial.println("Communication error");
        return p;
      default:
        Serial.println("Unknown error");
        return p;
    }
  }

  // If 4 consecutive failures occurred, print error message and return FINGERPRINT_NOTFOUND
  Serial.println("Fingerprint not detected after 4 attempts");
  return FINGERPRINT_NOTFOUND;
}


void fingerprintEnrollment() {
  Serial.println("Fingerprint enrollment mode");
  Serial.println("Please type in the ID # (from 1 to 127) you want to save this finger as...");
  id = readnumber();
  if (id == 0) {
    Serial.println("ID #0 not allowed, try again!");
    return;
  }
  Serial.print("Enrolling ID #");
  Serial.println(id);

  while (! getFingerprintEnroll() );
}


uint8_t getFingerprintEnroll() {
  int p = -1;
  while (p != FINGERPRINT_OK) {
    p = finger.getImage();
    if (p != FINGERPRINT_NOFINGER) {
      Serial.print("Waiting for valid finger to enroll as #"); Serial.println(id);
    }
  }

  p = finger.image2Tz(1);
  if (p != FINGERPRINT_OK) {
    return p;
  }

  Serial.println("Remove finger");
  delay(2000);
  while (p != FINGERPRINT_NOFINGER) {
    p = finger.getImage();
  }
  Serial.print("ID "); Serial.println(id);
  Serial.println("Place same finger again");

  p = -1;
  while (p != FINGERPRINT_OK) {
    p = finger.getImage();
    if (p != FINGERPRINT_NOFINGER) {
      Serial.print("Waiting for valid finger to enroll as #"); Serial.println(id);
    }
  }

  p = finger.image2Tz(2);
  if (p != FINGERPRINT_OK) {
    return p;
  }

  Serial.print("Creating model for #");  Serial.println(id);
  p = finger.createModel();
  if (p != FINGERPRINT_OK) {
    return p;
  }

  Serial.print("ID "); Serial.println(id);
  p = finger.storeModel(id);
  if (p != FINGERPRINT_OK) {
    return p;
  }

  Serial.println("Stored!");
  return true;
}


void fingerprintDeletion() {
  Serial.println("Fingerprint deletion mode");
  Serial.println("Please type in the ID # (from 1 to 127) you want to delete...");
  id = readnumber();
  if (id == 0) {// ID #0 not allowed, try again!
     return;
  }

  Serial.print("Deleting ID #");
  Serial.println(id);

  deleteFingerprint(id);
}


uint8_t deleteFingerprint(uint8_t id) {
  uint8_t p = -1;

  p = finger.deleteModel(id);

  if (p == FINGERPRINT_OK) {
    Serial.println("Deleted!");
     Serial.print("ID "); Serial.println(id);
  } else if (p == FINGERPRINT_PACKETRECIEVEERR) {
    Serial.println("Communication error");
  } else if (p == FINGERPRINT_BADLOCATION) {
    Serial.println("Could not delete in that location");
  } else if (p == FINGERPRINT_FLASHERR) {
    Serial.println("Error writing to flash");
  } else {
    Serial.print("Unknown error: 0x"); Serial.println(p, HEX);
  }

  return p;
}


void emptyFingerprintDatabase() {
  Serial.println("Emptying fingerprint database...");
  finger.emptyDatabase();
  Serial.println("Fingerprint database is now empty");
}


void setColor(int red, int green, int blue){
  analogWrite(ledRed, red);
  analogWrite(ledGreen, green);
  analogWrite(ledBlue, blue);
}



////********************************************************************************************************************************

