import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addPillToUser(String name) async {
    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .collection('drugs')
        .add({'name': name});
  }

  Stream<QuerySnapshot> getYourCurrentPills() {
    return _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .collection('drugs')
        .snapshots();
  }
}
