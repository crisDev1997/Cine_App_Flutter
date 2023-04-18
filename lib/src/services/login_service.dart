import 'package:cine_app/src/models/user_model.dart';
import 'package:cine_app/src/providers/user_provider.dart';
import 'package:cine_app/src/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final UserService userService = UserService();

  Future<String?> signInWithEmail(String email, String password) async {
    try {
      UserProvider userProvider = UserProvider();

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final AuthCredential auth =
          EmailAuthProvider.credential(email: email, password: password);

      String emailSignInMethod = auth.signInMethod;
      //Set auth credentials
      final userCredential = await _auth.signInWithCredential(auth);
      userProvider.setAuthCredentials(userCredential.user);
      //Set info account in provider
      var resp = await userService.getInfoAccount(userCredential.user!.uid);
      await userProvider.setUserInfo(resp).then((value) => true);
      await userProvider.setSignInMethod(emailSignInMethod);
      return "User valid";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //print('No user found for that email.');
        return "Usuario inexistente para ese correo";
      } else if (e.code == 'wrong-password') {
        //print('Wrong password provided for that user.');
        return "Contraseña incorrecta, revise las mayusculas";
      }
    }
    return null;
  }

  Future signInWithGoogle(GoogleSignInAccount account) async {
    UserProvider userProvider = UserProvider();
    try {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      User? userCredential =
          (await _auth.signInWithCredential(credential)).user;

      var resp = await userService.getInfoAccount(userCredential!.uid);
      String googleSignInMethod = credential.signInMethod;
      await userProvider.setAuthCredentials(userCredential);
      await userProvider.setSignInMethod(googleSignInMethod);
      // ignore: unnecessary_null_comparison
      if (resp == null) {
        final UserModel userData = UserModel(
          uid: userCredential.uid,
          email: account.email,
          username: account.displayName ?? '',
          photoURL: account.photoUrl ?? '',
        );
        var result = await userProvider
            .setUserInfo(userData.toJson())
            .then((value) async {
          await userService.registerUserData(
              userCredential.uid, userData.toJson());
          return true;
        });
        return result;
      }
      UserModel data = UserModel.fromJson(resp);
      var result =
          await userProvider.setUserInfo(data.toJson()).then((value) => true);
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('Firebase error: $e');
      }
      return null;
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    UserProvider userSet = UserProvider();
    final LoginResult loginResult =
        await FacebookAuth.instance.login(permissions: [
      'email',
      'public_profile', /* 'user_birthday' */
    ]);

    if (loginResult.status == LoginStatus.success) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      //_auth = FacebookAuthProvider.credential(loginResult.accessToken!.accessToken);
      //final userData = await FacebookAuth.instance.getUserData();
      UserCredential? userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);
      User? user = userCredential.user;
      userSet.setAuthCredentials(user);
      return userCredential;
    } else if (loginResult.status == LoginStatus.failed) {}
    return null;
  }
}
