Instruction
Speech Recognition with P5.js. When a text phrase is detected e.g. "light on", the webbrowser sends emit to websocket. Websocket forwards speech data with osc to processing.

Installation
npm install express
npm install node-osc
npm install socket.io

Start
node socketserver.js

Open webbrowser on localhost:8000 to use the speech recognition

Start processing