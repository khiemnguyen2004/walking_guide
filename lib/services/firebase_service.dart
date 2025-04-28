import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> saveUser(String uid, String name, String email) async {
    await users.doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
