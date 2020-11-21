import 'package:flutter/material.dart';

class PatientPillMoreInfoPage extends StatefulWidget {
  @override
  _PatientPillMoreInfoPageState createState() =>
      _PatientPillMoreInfoPageState();
}

class _PatientPillMoreInfoPageState extends State<PatientPillMoreInfoPage> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pill XXX - More Info'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'General Information',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Name'),
                    subtitle: Text('Subtitle'),
                    trailing: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '3',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              //todo pokud je cislo mensi nez 4, zmenit barvu na cervenou
                              //color: NUMBER < 4 ? Colors.red : Colors.black
                            ),
                          ),
                          TextSpan(text: '/'),
                          TextSpan(
                            text: '11',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: ' remaining!'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Pill Dosage',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  ListTile(
                    trailing: FlatButton.icon(
                      icon: Icon(Icons.calendar_today),
                      label: Text('Change day'),
                      onPressed: null,
                    ),
                    title: Text(
                      'Every day at 16:00',
                      style: TextStyle(
                        color: theme.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('Next in 2 hours'),
                  ),
                  ListTile(
                    title: Text('Take with water after food'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Switch(
                          value: _isSwitched,
                          onChanged: (value) {
                            setState(() {
                              _isSwitched = value;
                            });
                          },
                          activeTrackColor: theme.primaryColorLight,
                          activeColor: theme.primaryColor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
