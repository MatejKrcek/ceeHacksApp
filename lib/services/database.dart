import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getSidebarSnaphots() {
    return _firestore
        .collection('yadada-users')
        .doc(_firebaseAuth.currentUser.uid)
        .collection('sidebar')
        .snapshots();
  }
}
