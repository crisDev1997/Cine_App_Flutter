import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserService {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<dynamic> getInfoAccount(String uid) async {
    var resp = await _firestore.collection('users').doc(uid).get();
    if (resp.data() != null) {
      return resp.data();
    }
    return null;
  }

  Future<dynamic> registerUserData(uid, dynamic data) async {
    final now = DateTime.now().toLocal();
    final formatter = DateFormat('dd/MM/yyyy');
    final currentDate = formatter.format(now);
    data["createdAt"] = currentDate;
    data["updatedAt"] = currentDate;
    var resp = await _firestore
        .collection('users')
        .doc(uid)
        .set(data)
        .catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
      throw Exception("Hubo un error al registrar la informacion!");
    }).then((value) {
      return true;
    });
    return resp;
  }

  Future<dynamic> getTickets(uid) async {
    return null;
  }
}
