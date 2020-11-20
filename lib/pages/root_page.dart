import 'package:ceehacks/pages/auth/auth_page.dart';
import 'package:ceehacks/pages/home_page.dart';
import 'package:ceehacks/pages/pick_page.dart';
import 'package:ceehacks/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootPage extends StatelessWidget {
  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => Auth.instance(),
      child: Consumer<Auth>(
        builder: (context, Auth auth, _) {
          switch (auth.status) {
            case AuthStatus.NOT_DETERMINED:
            case AuthStatus.LOGGING_IN:
              return _buildWaitingScreen();
              break;
            case AuthStatus.LOGGED_IN:
              if (auth.userData == null) {
                return _buildWaitingScreen();
              } else {
                if (auth.userData.type == null) {
                  return PickPage();
                } else {
                  return HomePage();
                }
              }
              break;
            case AuthStatus.NOT_LOGGED_IN:
              return AuthPage();
              break;
            default:
              return AuthPage();
          }
        },
      ),
    );
  }
}
