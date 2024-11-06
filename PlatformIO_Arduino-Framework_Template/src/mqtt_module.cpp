#include "mqtt_module.h"

WiFiClient client;

// Setup the MQTT client class by passing in the WiFi client and MQTT server and login details
Adafruit_MQTT_Client mqtt(&client, AIO_SERVER, AIO_SERVERPORT, AIO_USERNAME, AIO_KEY);
Adafruit_MQTT_Publish uwbposition = Adafruit_MQTT_Publish(&mqtt, AIO_USERNAME "/feeds/uwbposition/csv");

void MQTT_connect() {
  // Stop if already connected
  if (mqtt.connected()) {
    return;
  }

  Serial.println("Connecting to MQTT... ");
  int8_t ret;
  uint8_t retries = 3;

  while ((ret = mqtt.connect()) != 0) { // Connect will return 0 for connected
    Serial.println(mqtt.connectErrorString(ret));
    Serial.println("Retrying MQTT connection in 5 seconds...");
    mqtt.disconnect();
    vTaskDelay(pdMS_TO_TICKS(5000)); // wait 5 seconds
    retries--;
    if (retries == 0) {
      // Basically die and wait for WDT to reset me
      while (1)
        ;
    }
  }
  Serial.println("MQTT Connected!");
}

void MQTT_send_data() {
  extract_data();
  String temp = values[0] + "," + values[1] + "," + values[2] + "," + values[3];
  writeToCSV();
  if (!uwbposition.publish(temp.c_str())) {
    Serial.println("Send failed!");
  } else {
    Serial.println("Send success!");
  }
  vTaskDelay(pdMS_TO_TICKS(6000));
  return;
}
