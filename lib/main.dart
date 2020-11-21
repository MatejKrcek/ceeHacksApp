import 'package:ceehacks/pages/root_page.dart';
import 'package:ceehacks/pages/select_role_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//! home: RootPage(),
import 'package:ceehacks/pages/main_menu_layout_page.dart';
import 'package:ceehacks/pages/doctor/doctor_verify_page.dart';
import 'package:ceehacks/pages/patient/patient_add_pill_page.dart';
import 'package:ceehacks/pages/patient/patient_pill_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Color of the status bar
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Piller',
      theme: ThemeData(
        primaryColor: Color(0xFF035AA6),
        accentColor: Colors.deepOrange,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PatienAddPilScreen()
    );
  }
}
