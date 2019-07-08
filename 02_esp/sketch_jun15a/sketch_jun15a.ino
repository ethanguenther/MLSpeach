#include <ESP8266WiFi.h>
#include <PubSubClient.h>
 
const char* ssid = "iPhone von Valerie";
const char* password = "1derLand";
const char* mqttServer = "172.20.10.12";
const int mqttPort = 1883;
 
WiFiClient espClient;
PubSubClient client(espClient);

// Initializing the pins for led's
int red_light_pin= 16;
int green_light_pin = 5;
int blue_light_pin = 4;
int light_mode;
 
void setup() {
 
  Serial.begin(115200);
  WiFi.begin(ssid, password);
 
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("Connecting to WiFi..");
  }
  Serial.println("Connected to the WiFi network");
 
  client.setServer(mqttServer, mqttPort);
  client.setCallback(callback);
 
  while (!client.connected()) {
    Serial.println("Connecting to MQTT...");
 
    if (client.connect("ESP8266Client")) {
 
      Serial.println("connected");  
 
    } else {
 
      Serial.print("failed with state ");
      Serial.print(client.state());
      delay(2000);
 
    }
  }
  
  client.subscribe("/light");  
 
}
 
void callback(char* topic, byte* payload, unsigned int length) {

  if (payload[0] == '1') {
    Serial.println ("ethan_morning");
    RGB_color(0,0,255);
    
    }
  else if (payload[0] == '2') {
    Serial.println ("ethan_work");
    RGB_color(255,0,0);
    }

/*  Serial.print("Message arrived in topic: ");
  Serial.println(topic);
 
  Serial.print("Message:");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }
 
  Serial.println();
  Serial.println("-----------------------");
  */
}
 
void loop() {
  client.loop();
}

void RGB_color(int red_light_value, int green_light_value, int blue_light_value)
 {
  analogWrite(red_light_pin, red_light_value);
  analogWrite(green_light_pin, green_light_value);
  analogWrite(blue_light_pin, blue_light_value);
}
