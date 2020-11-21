import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class PatienAddPilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Pill'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Add a New Pill',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Select an option, please',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    FlatButton.icon(
                      icon: Icon(
                        Icons.qr_code_scanner,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {},
                      label: Text(
                        'Scan Barcode',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    FlatButton.icon(
                      icon: Icon(
                        Icons.camera,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {},
                      label: Text(
                        'Take photo of pill',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    FlatButton.icon(
                      icon: Icon(
                        Icons.playlist_add,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {},
                      label: Text(
                        'Select pill',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    FlatButton.icon(
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {},
                      label: Text(
                        'Write pill name',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
