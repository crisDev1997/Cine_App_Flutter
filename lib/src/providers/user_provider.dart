import 'dart:convert';

import 'package:cine_app/src/models/user_model.dart';
import 'package:cine_app/src/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

import '../services/google_service.dart';

//import 'package:firebase_st';
class UserProvider with ChangeNotifier {
  final String _userInfo = '';
  String _signInMethod = '';
  late FirebaseAuth _auth;

  bool _isLoggedIn = false;
  // ignore: prefer_final_fields
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool get isloggedIn => _isLoggedIn;
  String get signInMethod => _signInMethod;
  String get userInfo => _userInfo;

  static const _storage = FlutterSecureStorage();

  static const _token = 'token';
  static const _uid = 'uid';
  static const _authCredentials = "auth";

  static Future setToken(String token) async {
    await _storage.write(key: _token, value: token);
  }

  static Future setUid(String uid) async {
    await _storage.write(key: _uid, value: uid);
  }

  static Future setAuth(FirebaseAuth auth) async {
    final value = json.encode(auth);
    await _storage.write(key: _authCredentials, value: value);
  }

  Future<void> setSignInMethod(String signInMethod) async {
    _signInMethod = signInMethod;
  }

  Future<String?> getToken() async => await _storage.read(key: _token);
  Future<String?> getUid() async => await _storage.read(key: _uid);

  UserProvider();

  Future<void> autologin() async {
    String uid = await getUid() ?? '';
    String token = await getToken() ?? '';
    if (uid != '' && token != '') {
      UserService userService = UserService();
      var resp = await userService.getInfoAccount(uid);
      setUserInfo(resp);
      if (resp == null) {
        _isLoggedIn = false;
      } else {
        //await setUserInfo(resp);
        _isLoggedIn = true;
      }
    } else {
      _isLoggedIn = false;
    }
    notifyListeners();
  }

  Future<void> setAuthCredentials(User? credential) async {
    String uid = credential?.uid ?? '';
    String token = credential?.getIdToken().toString() ?? '';
    await setUid(uid);
    await setToken(token);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> setUserInfo(Map<String, dynamic> userInfo) async {
    final value = json.encode(userInfo);
    await _storage.write(key: _userInfo, value: value.toString());
    notifyListeners();
  }

  Future<UserModel?> getProvideUserInfo() async {
    var dataSecured = await _storage.read(key: _userInfo);
    if (dataSecured == null) {
      return null;
    }
    Map<String, dynamic> data = await json.decode(dataSecured.toString());
    UserModel userInfo = UserModel.fromJson(data);
    return userInfo;
  }

  Future<void> secureLogout() async {
    await _storage.delete(key: _uid);
    await _storage.delete(key: _token);
    await _storage.delete(key: _userInfo);
    _isLoggedIn = false;
    _signInMethod = '';
    GoogleSignInService.signOutWithGoogle();
    notifyListeners();
  }
}
