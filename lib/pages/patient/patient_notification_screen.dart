import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PatientNotificationScreen extends StatefulWidget {
  @override
  _PatientNotificationScreenState createState() =>
      _PatientNotificationScreenState();
}

class _PatientNotificationScreenState extends State<PatientNotificationScreen> {
  double _currentSliderValue = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Did you take the pill?',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton.icon(
                        icon: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        label: Text('Yes, I took it!'),
                        onPressed: null,
                      ),
                      FlatButton.icon(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                        label: Text('No, I take it now'),
                        onPressed: null,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton.icon(
                        icon: Icon(
                          Icons.check,
                          color: Colors.amber,
                        ),
                        label: Text('Remind me in 10 minutes'),
                        onPressed: null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'How do you feel?',
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/sad.svg',
                    height: 22,
                    color: Colors.red,
                  ),
                  Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: 100,
                    label: 20.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                  SvgPicture.asset(
                    'assets/happy.svg',
                    height: 22,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              onPressed: null, //hasValue ? () {} : null,
              child: Text(
                'Back to Home Screen',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
