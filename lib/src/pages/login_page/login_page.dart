// ignore_for_file: prefer_const_constructors, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cine_app/src/commons/colors.dart';
import 'package:cine_app/src/pages/login_page/login_init.dart';
import 'package:cine_app/src/pages/login_page/login_email.dart';
/* import 'package:cine_app/src/providers/user_provider.dart';
import 'package:provider/provider.dart'; */

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  LoginPage({Key? key}) : super(key: key);
  bool emailLogin = false;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = FirebaseAuth.instance;
  bool isAPIcallProcess = false;
  bool hidePassword = true;

  final globalFormKey = GlobalKey<FormState>();

  @override
  // ignore: duplicate_ignore
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Scaffold(
          backgroundColor: secondary3,
          body: ProgressHUD(
              inAsyncCall: isAPIcallProcess,
              opacity: 0.3,
              key: UniqueKey(),
              child: Form(
                key: globalFormKey,
                child: _loginUI(context),
              )),
        )),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    //String uid = "";

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
                  white,
                  white,
                ],
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo4.png",
                    height: 200.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          widget.emailLogin
              ? LoginEmail(
                  callback: (() {
                    callback1();
                  }),
                )
              : LoginInit(
                  callback: (() {
                    callback1();
                  }),
                )
        ],
      ),
    );
  }

  void callback1() {
    setState(() {
      widget.emailLogin = !widget.emailLogin;
    });
  }
}
