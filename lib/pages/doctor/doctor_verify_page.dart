import 'package:ceehacks/model/user_types.dart';
import 'package:ceehacks/services/auth.dart';
import 'package:ceehacks/services/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DoctorVerifyPage extends StatefulWidget {
  @override
  _DoctorVerifyPageState createState() => _DoctorVerifyPageState();
}

class _DoctorVerifyPageState extends State<DoctorVerifyPage> {
  final _formKey = GlobalKey<FormState>();
  final _holder = TextEditingController();

  void _trySubmit() async {
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();
      var userData = Provider.of<Auth>(context, listen: false).user;
      var split = userData.displayName.split(' ');
      var id = await Functions().getDoctorId(split[0], split[split.length - 1]);
      var holderid = _holder.value.text;
      if (id != holderid) {
        final snackBar = SnackBar(content: Text('Bad id'));
        Scaffold.of(context).showSnackBar(snackBar);
      } else {
        var uid = Provider.of<Auth>(context, listen: false).user.uid;
        await Functions().changeUserType(
          uid,
          UserType.Doctor,
        );
        await Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('One more step'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                child: Text(
                  'We need to verify your doctor ID',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: deviceSize.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _holder,
                            textCapitalization: TextCapitalization.none,
                            autocorrect: false,
                            key: ValueKey('data'),
                            enableSuggestions: false,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              labelText: 'Enter your ID',
                              hintText: 'Enter your ID',
                              icon: Icon(Icons.assignment_ind),
                            ),
                            validator: (value) {
                              if (value.isEmpty || value.length < 9) {
                                return 'Please enter your valid ID';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: RaisedButton(
                        child: Text(
                          'Verify',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: _trySubmit,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
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
