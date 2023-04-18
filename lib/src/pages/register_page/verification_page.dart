import 'package:cine_app/src/services/register_service.dart';
import 'package:cine_app/src/widgets/pin_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage(
      {Key? key,
      required this.username,
      required this.email,
      required this.pass,
      required this.phoneNumber})
      : super(key: key);
  final String username;
  final String email;
  final String pass;
  final String phoneNumber;

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _globalFormKey = GlobalKey<FormState>();
  String message = "";
  bool errorMessage = false;
  late PhoneAuthCredential _phoneAuthCredential;
  String _verificationCode = "";
  final FocusScopeNode _node = FocusScopeNode();
  TextEditingController d1 = TextEditingController(),
      d2 = TextEditingController(),
      d3 = TextEditingController(),
      d4 = TextEditingController(),
      d5 = TextEditingController(),
      d6 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    "Verificación de Seguridad",
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Image.asset(
                  "assets/images/verification.jpg",
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Para verificar su cuenta, se le enviara a su numero de celular ${widget.phoneNumber} un codigo de seguridad que debe introducir.",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () async {
                      await _verifyPhoneNumber();
                    },
                    child: const Text("Solicitar Código de Seguridad")),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Introduzca el Código:",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              Form(
                key: _globalFormKey,
                child: FocusScope(
                  node: _node,
                  child: Wrap(
                    spacing: 10,
                    children: [
                      PinInput(
                        controller: d1,
                        node: _node,
                      ),
                      PinInput(
                        controller: d2,
                        node: _node,
                      ),
                      PinInput(
                        controller: d3,
                        node: _node,
                      ),
                      PinInput(
                        controller: d4,
                        node: _node,
                      ),
                      PinInput(
                        controller: d5,
                        node: _node,
                      ),
                      PinInput(
                        controller: d6,
                      )
                    ],
                  ),
                ),
              ),
              errorMessage
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        message,
                        style: const TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      String smsCode = d1.text +
                          d2.text +
                          d3.text +
                          d4.text +
                          d5.text +
                          d6.text;
                      setState(() {
                        _verificationCode = smsCode;
                      });
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: _verificationCode,
                              smsCode: smsCode))
                          .then((value) async {
                        if (value.user != null) {
                          RegisterService registerService = RegisterService();
                          UserModel userData = UserModel(
                              uid: "",
                              username: widget.username,
                              email: widget.email);
                          await registerService
                              .createEmailAccount(widget.email, widget.pass,
                                  userData, _phoneAuthCredential)
                              .then((value) {
                            return Navigator.of(context)
                                .pushNamedAndRemoveUntil(
                                    '/home', (route) => false);
                          });
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20)),
                    child: const Text("Verificar código y Registrarse")),
              )
            ],
          ),
        ),
      ),
    );
  }

  _verifyPhoneNumber() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: widget.phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            /* await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              if (value.user != null) {
                print("user logged in");
              }
            }); */
            setState(() {
              _phoneAuthCredential = credential;
            });
          },
          verificationFailed: (FirebaseAuthException e) {
            print("Error de verificationFailed ${e.message.toString()}");
            throw e.message.toString();
          },
          codeSent: (String verificationId, int? resendToken) {
            setState(() {
              _verificationCode = verificationId;
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            setState(() {
              _verificationCode = verificationId;
            });
          },
          timeout: const Duration(seconds: 60));
    } catch (e) {
      if (kDebugMode) {
        print("error de verificacion por numero: ${e.toString()}");
      }
      return null;
    }
    return null;
  }

  bool _testInputs() {
    bool validInputs = _globalFormKey.currentState!.validate();
    if (validInputs) {
      setState(() {
        errorMessage = false;
        message = "";
      });
    } else {
      setState(() {
        errorMessage = true;
        message = "Rellene las casillas, con el código de seguridad";
      });
    }
    return _globalFormKey.currentState!.validate();
  }

  /* Future<String?> sendVerification(String phoneNumber) async {
    try {
      final RegisterService registerService = RegisterService();
      var resp = await registerService.verifyPhoneNumber(
          phoneNumber, _verificationCode);
      return resp;
    } catch (error) {
      return null;
    }
  } */
}
