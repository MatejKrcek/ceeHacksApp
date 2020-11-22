import 'package:ceehacks/pages/patient/patient_add_pill_page.dart';
import 'package:ceehacks/pages/patient/patient_graphs_page.dart';
import 'package:ceehacks/pages/patient/patient_notification_screen.dart';
import 'package:ceehacks/pages/patient/patient_pill_list_page.dart';
import 'package:ceehacks/services/functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MainMenuLayoutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainMenuLayoutPageState();
  }
}

class _MainMenuLayoutPageState extends State<MainMenuLayoutPage> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<BottomNavigationBarItem> _bottomItems() {
    List<BottomNavigationBarItem> items = [];
    items.addAll([
      BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: "List",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: "Add",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.notifications),
        label: "Notifications",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.graphic_eq),
        label: "Statistics",
      ),
    ]);
    return items;
  }

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

  getCurrentBody(int index) {
    switch (_currentIndex) {
      case 0:
        return PatientPillsList();
        break;
      case 1:
        return PatienAddPilScreen();
        break;
      case 2:
        return PatientNotificationScreen();
        break;
      case 3:
        return PatientGraphsPage();
        break;
      default:
        return PatientPillsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: onTabTapped,
        items: _bottomItems(),
      ),
      body: getCurrentBody(_currentIndex),
    );
  }
}
