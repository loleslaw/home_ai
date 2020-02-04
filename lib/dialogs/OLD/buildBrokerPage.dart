import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;

  TextEditingController brokerController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  TextEditingController identifierController = TextEditingController();

    String titleBar         = 'HomeAI';
  String broker           = '192.168.0.120';
  int port                = 1883;
  String username         = '';
  String passwd           = '';
  String clientIdentifier = 'usr id';

    mqtt.MqttClient client;
  mqtt.MqttConnectionState connectionState;

Column _buildBrokerPage(IconData connectionStateIcon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox( //Input Broker
              width: 200.0,
              child: TextField(
                controller: brokerController,
                decoration: InputDecoration(hintText: 'Input broker'),
              ),
            ),
            SizedBox( //Input Port
              width: 200.0,
              child: TextField(
                controller: portController,
                decoration: InputDecoration(hintText: 'Port'),
              ),
            ),
            SizedBox( //Username
              width: 200.0,
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(hintText: 'Username'),
              ),
            ),
            SizedBox( //Passwd
              width: 200.0,
              child: TextField(
                controller: passwdController,
                decoration: InputDecoration(hintText: 'Passwd'),
              ),
            ),
            SizedBox( //Passwd
              width: 200.0,
              child: TextField(
                controller: identifierController,
                decoration: InputDecoration(hintText: 'Client Identifier'),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              broker + ':' + port.toString(),
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(width: 8.0),
            Icon(connectionStateIcon),
          ],
        ),
        SizedBox(height: 8.0),
        RaisedButton(
          child: Text(client?.connectionState == mqtt.MqttConnectionState.connected
              ? 'Disconnect'
              : 'Connect'),
          onPressed: () {

            /*
            if(brokerController.value.text.isNotEmpty) {
              broker = brokerController.value.text;
            }

            port = int.tryParse(portController.value.text);
            if(port == null) {
              port = 14375;
            }
            if(usernameController.value.text.isNotEmpty) {
              username = usernameController.value.text;
            }
            if(passwdController.value.text.isNotEmpty) {
              passwd = passwdController.value.text;
            }
            
            clientIdentifier = identifierController.value.text;
            if(clientIdentifier.isEmpty) {
              var random = new Random();
              clientIdentifier = 'lamhx_' + random.nextInt(100).toString();
            }

            */

            if (client?.connectionState == mqtt.MqttConnectionState.connected) {
         //     _disconnect();
            } else {
          //    _connect();
           //   _subscribeToTopic('drzwi/#');
            }
          },
        ),
      ],
    );
  }
