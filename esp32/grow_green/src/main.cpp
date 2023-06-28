#include <Arduino.h>
#include <WiFiManager.h>
#include <WiFi.h>
#include <HTTPClient.h>

int moisturePin = 33;
int moistureLevel = 0;
const char* serverUrl = "http://192.168.50.129:5050/sensor-data";
String espHostName = "";
#define VBATPIN A13

// send data to server
void sendData(int moisture, float battery, String sensorId) {
  HTTPClient http;
  http.begin(serverUrl);
  http.addHeader("Content-Type", "application/json");
  String payload = "{\"sensor_id\": \"" + String(sensorId) + "\", \"moisture\": " + String(moisture) + ", \"battery_health\": " + String(battery) + "}";

  //String payload = "{\"sensor_id\": " + String(sensorId) + ", \"moisture\": " + String(moisture) + ", \"battery_health\": " + String(battery) + "}";
  int httpResponseCode = http.POST(payload);
  if (httpResponseCode > 0) {
    Serial.print("HTTP Response code: ");
    Serial.println(httpResponseCode);
    String response = http.getString();
    Serial.println(response);
  } else {
    Serial.print("Error code: ");
    Serial.println(httpResponseCode);
  }
  http.end();
}
// get esp mac address
String getEspMacAddress() {
  uint8_t baseMac[6];
  esp_efuse_mac_get_default(baseMac);
  Serial.printf("MAC: %02X:%02X:%02X:%02X:%02X:%02X\n", baseMac[0], baseMac[1], baseMac[2], baseMac[3], baseMac[4], baseMac[5]);
  return String(baseMac[0], HEX) + String(baseMac[1], HEX) + String(baseMac[2], HEX) + String(baseMac[3], HEX) + String(baseMac[4], HEX) + String(baseMac[5], HEX);
}

// set esp hostname
void setNewHostname() {
  espHostName = "Node-" + getEspMacAddress();
  Serial.println("Hostname: " + espHostName);
}

// connect to wifi
void setup_wifi() {
  WiFiManager wifiManager;
  setNewHostname();
  wifiManager.setHostname(espHostName.c_str());
  //wifiManager.resetSettings(); // reset settings - for testing

  // Enter access point mode
  if(!wifiManager.autoConnect(espHostName.c_str())) {
    Serial.println("Failed to connect to wifi and hit timeout");
  }

  Serial.println("Connected to wifi");
}

//TODO need to update this to measure the battery level correctly
// measure battery level
float measureBattery() {
  float measuredvbat = analogReadMilliVolts(VBATPIN);
  measuredvbat *= 2;    // we divided by 2, so multiply back
  measuredvbat /= 1000; // convert to volts!
  return measuredvbat;
}

// measure moisture level
int measureMoisture() {
  int moistureLevel = analogRead(moisturePin);
  //Serial.println(moistureLevel);
  return map(moistureLevel, 3300, 1350, 0, 100);
}

// sleep for 8 hours
void startSleep() {
  //unsigned long sleepTime = 1000000UL * 60 * 60 * 8; // 8 hours
  int testSleepTime = 1000000UL * 5; // 5 seconds
  esp_sleep_enable_timer_wakeup(testSleepTime);
  esp_deep_sleep_start();
}

// main setup function
void setup() {
  Serial.begin(115200);
  setup_wifi();
}

// main loop function
void loop() {
  int moisture = measureMoisture();
  float battery = measureBattery();
  sendData(moisture, battery, espHostName.c_str());
  startSleep();
}
