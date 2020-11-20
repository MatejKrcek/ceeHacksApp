import 'dart:async';
import 'package:ceehacks/model/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGING_IN,
  LOGGED_IN,
}

class Auth with ChangeNotifier {
  Stream<DocumentSnapshot> _dataListener;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthStatus _status = AuthStatus.NOT_DETERMINED;

  User _user;
  UserData _userData;

  AuthStatus get status => _status;
  User get user => _user;
  UserData get userData => _userData;

  Auth.instance() {
    _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<String> signIn(String email, String password) async {
    _status = AuthStatus.LOGGING_IN;
    UserCredential result;
    try {
      result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception catch (_) {
      await this.signUp(email, password);

      return null;
    }
    _user = result.user;
    notifyListeners();

    return _user.uid;
  }

  Future<String> signUp(String email, String password) async {
    _status = AuthStatus.LOGGING_IN;
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    _user = result.user;
    notifyListeners();

    return _user.uid;
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _status = AuthStatus.NOT_LOGGED_IN;
    notifyListeners();
  }

  Future<String> googleSignIn() async {
    _status = AuthStatus.LOGGING_IN;
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    _user = (await _firebaseAuth.signInWithCredential(credential)).user;
    notifyListeners();

    return _user.uid;
  }

  Future<void> changePassword(String newPassword) async {
    if (_user == null) {
      return;
    }
    await _user.updatePassword(newPassword);
  }

  bool isUserSignedByEmail() {
    if (_user == null) {
      return false;
    }
    if (_user.providerData.length > 1) {
      return true;
    } else {
      return _user.providerData[0].providerId == "password";
    }
  }

  Future<String> anonymousSignIn() async {
    final authResult = await FirebaseAuth.instance.signInAnonymously();
    final firebaseUser = authResult.user;

    return firebaseUser.uid;
  }

  Future<void> _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser != null) {
      _status = AuthStatus.LOGGED_IN;
      _user = firebaseUser;
      notifyListeners();
      _dataListener = FirebaseFirestore.instance
          .doc("users/" + firebaseUser.uid)
          .snapshots();
      _dataListener.listen((snap) {
        if (snap != null && snap.data().isNotEmpty) {
          _userData = new UserData.fromMap(snap.data());
          notifyListeners();
        }
      });
    } else {
      _user = null;
      _status = AuthStatus.NOT_LOGGED_IN;
      notifyListeners();
    }
  }
}
