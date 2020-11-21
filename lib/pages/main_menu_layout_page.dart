import 'package:ceehacks/services/functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:ceehacks/pages/patient/patient_main_menu_buttons.dart';

class MainMenuLayoutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainMenuLayoutPageState();
  }
}

class _MainMenuLayoutPageState extends State<MainMenuLayoutPage> {
  void checkNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    var resp = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (resp.authorizationStatus == AuthorizationStatus.authorized) {
      var token = await messaging.getToken();
      await Functions().setUserNotifToken(token);
    }
  }

  @override
  void initState() {
    checkNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: const Text(
                  'I want to',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 70,
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                PatientMainMenuButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
