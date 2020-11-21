import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class PatienAddPilScreen extends StatefulWidget {
  @override
  _PatienAddPilScreenState createState() => _PatienAddPilScreenState();
}

class _PatienAddPilScreenState extends State<PatienAddPilScreen> {
  // bool _hasImage = false;
  // String _scanBarcode = 'Unknown';

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    // setState(() {
    //   _hasImage = true;
    // });
  }

  Future<void> _scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
  }

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
                      onPressed: _scanQR,
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
                      onPressed: _takePicture,
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
                      onPressed: () {
                        Navigator.of(context).pushNamed('/search-pill');
                      },
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
                      onPressed: null,
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
