## Instruction

### Speech Recognition
Speech Recognition with P5.js. When a text phrase is detected e.g. "light on", the webbrowser sends emit to websocket. Websocket forwards speech data with osc to processing.

## Installation
```
npm install express
npm install node-osc
npm install socket.io
```

**Start Node-Server**
```
node socketserver.js
```

Open webbrowser on localhost:8000 to use the speech recognition.

**Run processing sketch**

## Voice Recognition
The OpenFramework tool MFCC detects the sound signal an sends it to wekinator. The ML Tool wekinator is used to learn the voice of different users for a personalized light control.

**Start MFCC**

**Start Wekinator with the following setup**
```
osc port: 6448
inputs: 13
output port: 12000
type: all dynamic time warping
gesture types: 2
```

Wekinator must be trained to the different voices, which should be used for the personalized light control.

## MQTT Connection
MQTT is used to for the connection between processig and the ESP8266. The data is published on the topic "/client" in the local network.

**Start the mosqitto broker**
```
/usr/local/sbin/mosquitto -c mosquitto.conf
```