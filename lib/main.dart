import 'package:ceehacks/pages/root_page.dart';
import 'package:ceehacks/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        primarySwatch: Colors.blue,
        accentColor: Colors.lightGreen,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RootPage(),
    );
  }
}
