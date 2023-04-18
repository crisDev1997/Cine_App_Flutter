import 'package:cine_app/src/models/user_model.dart';
import 'package:cine_app/src/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class RegisterService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool?> verifyExistAccount(String email, String phone) async {
    try {
      var resp = await _firestore.collection('users').doc(email).get();
      var resp2 = await _firestore
          .collection('users')
          .where('phone', isEqualTo: phone)
          .get();
      if (resp.exists || resp2.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return null;
    }
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
      throw Exception("Hubo un error al registrar la informacion!");
    }).then((value) {
      return true;
    });
    return resp;
  }

  Future<String?> createEmailAccount(String email, String password,
      UserModel userModel, PhoneAuthCredential phoneAuthCredential) async {
    try {
      String? resp = await _auth
          .signInWithCredential(phoneAuthCredential)
          .then((value) async {
        String? uid = await value.user!.getIdToken();
        UserModel userData = UserModel(
            uid: uid,
            email: email,
            username: userModel.username,
            phone: userModel.phone);
        await registerUserData(value.user!.getIdToken(), userData.toJson())
            .onError((error, stackTrace) {
          throw error.toString();
        }).then((value) async {
          User? user = value.user;
          await user!.updateDisplayName(userModel.username);
          await user.updatePassword(password);
          await user.updateEmail(userModel.email);
          UserProvider userProvider = UserProvider();
          await userProvider.setAuthCredentials(user);
          await userProvider.setUserInfo(userData.toJson());
          return "User Registered Successfully";
        });
      }).catchError((error, stackTrace) {
        throw error.toString();
      });
      return resp;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  /*  Future<String?> createUserWithEmailNoVerification(
      String email, String password, UserModel data) async {
    late User? user;
    try {
      print("2");
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        user = value.user;
        var method = value.credential!.signInMethod;
        if (kDebugMode) {
          print("User: $user");
        }
        print(user == null);
        if (user != null) {
          print("4");
          bool resp = false;
          UserProvider userSet = UserProvider();
          UserModel userData = UserModel(
              uid: user!.uid,
              username: data.username,
              email: email,
              phone: data.phone);
          await user!.updateDisplayName(data.username).catchError((error) {
            throw Exception("Error al registrar al usuario");
          });
          //print("3");
          await registerUserData(user!.uid, userData.toJson())
              .onError((error, stackTrace) {
            throw Exception("Error al registrar al usuario");
          }).then((_) async {
            //print("4");
            await userSet.setAuthCredentials(user);
            await userSet.setUserInfo(userData.toJson());
            await userSet.setSignInMethod(method);
            resp = true;
          });
          print("5");
          if (resp) {
            return "Usuario registrado exitosamente!";
          } else {
            throw Exception("Error al registrar al usuario");
          }
        } else {
          print("return null");
          return null;
        }
      }).catchError((error) {
        throw Exception("Error al crear la cuenta del usuario");
      });
    } catch (e) {
      if (e.toString() == "Error al registrar al usuario" && user != null) {
        await user!.delete();
      }
      return null;
    }
    return null;
  } */
  Future<String?> createUserWithEmailNoVerification(
      String email, String password, UserModel data) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;
      if (kDebugMode) {
        print("User: $user");
      }
      final userProvider = UserProvider();
      final userData = UserModel(
        uid: user.uid,
        username: data.username,
        email: email,
        phone: data.phone,
      );
      await user.updateDisplayName(data.username);
      await registerUserData(user.uid, userData.toJson());
      await userProvider.setAuthCredentials(user);
      await userProvider.setUserInfo(userData.toJson());
      await userProvider.setSignInMethod("email");
      return "Usuario registrado exitosamente!";
    } catch (e) {
      if (e is FirebaseException) {
        throw Exception("Error al crear la cuenta del usuario");
      } else if (e is Exception) {
        final user = _auth.currentUser;
        if (user != null) {
          await user.delete();
        }
        throw Exception("Error al registrar al usuario");
      } else {
        rethrow;
      }
    }
  }
}
