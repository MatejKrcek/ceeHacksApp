import 'package:ceehacks/model/user_types.dart';
import 'package:ceehacks/services/auth.dart';
import 'package:ceehacks/services/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SelectRolePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

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
                  'Who are you?',
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
                Positioned(
                  left: size.width / 6,
                  top: 80,
                  child: Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 15),
                    child: OutlineButton(
                      onPressed: () async {
                        var uid =
                            Provider.of<Auth>(context, listen: false).user.uid;
                        await Functions().changeUserType(
                          uid,
                          UserType.Pacient,
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      highlightElevation: 0,
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                      ),
                      disabledBorderColor: theme.primaryColor,
                      highlightedBorderColor: theme.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              size: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: const Text(
                                'User',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 160,
                  left: size.width / 6,
                  child: Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 15),
                    child: OutlineButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/doctor-verify');
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      highlightElevation: 0,
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                      ),
                      disabledBorderColor: theme.primaryColor,
                      highlightedBorderColor: theme.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/doctor_icon.svg',
                              height: 22,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: const Text(
                                'Doctor',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
