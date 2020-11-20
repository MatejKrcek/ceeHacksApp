import 'package:ceehacks/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showLoginVersion = false;
  double _cardHeight = 430;

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _nameFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); //close opened keaboards

    if (isValid) {
      _formKey.currentState.save();
      if (_showLoginVersion) {
        await Provider.of<Auth>(context, listen: false).signIn(
            _nameController.value.text.trim(),
            _emailController.value.text.trim(),
            _passwordController.value.text.trim());
      } else {
        await Provider.of<Auth>(context, listen: false).signUp(
            _nameController.value.text.trim(),
            _emailController.value.text.trim(),
            _passwordController.value.text.trim());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final progressStarted = Provider.of<Auth>(context).progess;

    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          height: 240,
          width: deviceSize.width * 0.8,
          constraints: BoxConstraints(minHeight: _cardHeight),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (!_showLoginVersion)
                      TextFormField(
                          key: ValueKey('name'),
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_emailFocusNode);
                          },
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty || value.length < 2) {
                              return 'Please enter a valid name';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Your full name',
                            hintText: 'Your full name',
                            icon: Icon(Icons.person),
                          )),
                    TextFormField(
                      key: ValueKey('email'),
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty ||
                            value.length < 2 ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        hintText: 'Email address',
                        icon: Icon(Icons.email),
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),
                    TextFormField(
                      key: ValueKey('password'),
                      controller: _passwordController,
                      enableSuggestions: false,
                      obscureText: true,
                      autocorrect: false,
                      focusNode: _passwordFocusNode,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'Please enter a valid password';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password',
                        icon: Icon(Icons.lock),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    // if (progressStarted)
                    // Container(
                    //   margin: EdgeInsets.only(top: 20),
                    //   child: CircularProgressIndicator(),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    // if (!progressStarted)
                    RaisedButton(
                      child: Text(
                        _showLoginVersion ? 'Login' : 'Create account',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _trySubmit,
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    // if (!progressStarted)
                    FlatButton(
                      onPressed: () {
                        setState(
                          () {
                            _showLoginVersion = !_showLoginVersion;
                            if (_showLoginVersion) {
                              _cardHeight = 380;
                            } else {
                              _cardHeight = 430;
                            }
                          },
                        );
                      },
                      child: Text(
                        _showLoginVersion
                            ? 'Create account instead'
                            : 'Login instead',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            ),
                          ),
                        ),
                        Text("OR"),
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Divider(
                                color: Colors.black,
                                height: 36,
                              )),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: OutlineButton(
                        onPressed: () async {
                          await Provider.of<Auth>(context, listen: false)
                              .googleSignIn();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        highlightElevation: 0,
                        borderSide: BorderSide(color: Colors.grey),
                        disabledBorderColor: Colors.grey,
                        highlightedBorderColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                  image: AssetImage("assets/google_logo.png"),
                                  height: 15.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  'Continue with Google',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
