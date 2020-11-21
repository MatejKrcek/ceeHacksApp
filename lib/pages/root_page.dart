import 'package:ceehacks/pages/auth/auth_page.dart';
import 'package:ceehacks/pages/doctor/doctor_verify_page.dart';
import 'package:ceehacks/pages/main_menu_layout_page.dart';
import 'package:ceehacks/pages/patient/patient_add_pill_page.dart';
import 'package:ceehacks/pages/patient/patient_graphs_page.dart';
import 'package:ceehacks/pages/patient/patient_notification_screen.dart';
import 'package:ceehacks/pages/patient/patient_pill_list_page.dart';
import 'package:ceehacks/pages/patient/patient_search_pill.dart';
import 'package:ceehacks/pages/select_role_page.dart';
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
                  return Navigator(
                    initialRoute: '/onboarding',
                    onGenerateRoute: (settings) {
                      switch (settings.name) {
                        case '/onboarding':
                          return MaterialPageRoute(
                            builder: (BuildContext context) => SelectRolePage(),
                          );
                          break;
                        case '/doctor-verify':
                          return MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DoctorVerifyPage(),
                          );
                          break;
                        default:
                          return MaterialPageRoute(
                            builder: (BuildContext context) => SelectRolePage(),
                          );
                          break;
                      }
                    },
                  );
                } else {
                  return Navigator(
                    initialRoute: '/',
                    onGenerateRoute: (settings) {
                      switch (settings.name) {
                        case '/':
                          return MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MainMenuLayoutPage(),
                          );
                          break;
                        case '/pill-list':
                          return MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PatientPillsList(),
                          );
                          break;
                        case '/notifications':
                          return MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PatientNotificationScreen(),
                          );
                          break;
                        case '/add-pill':
                          return MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PatienAddPilScreen(),
                          );
                          break;
                        case '/statistics':
                          return MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PatientGraphsPage(),
                          );
                          break;
                        case '/search-pill':
                          return MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PatientSearchPill(),
                          );
                          break;
                        default:
                          return MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MainMenuLayoutPage(),
                          );
                          break;
                      }
                    },
                  );
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
