import 'package:ceehacks/pages/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Theme.of(context).primaryColor, Colors.white]),
        ),
        child: SingleChildScrollView(
          child: Container(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 54.0),
                    transform: Matrix4.rotationZ(-8 * pi / 180)
                      ..translate(-10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: Colors.black),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black26,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Piller',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 43,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                AuthForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
