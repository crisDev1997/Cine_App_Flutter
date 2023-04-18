// ignore_for_file: prefer_final_fields
import 'package:cine_app/src/commons/colors.dart';
import 'package:cine_app/src/commons/validators.dart';
import 'package:cine_app/src/services/login_service.dart';
import 'package:cine_app/src/widgets/custom_textfield1.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginEmail extends StatefulWidget {
  LoginEmail({Key? key, this.callback}) : super(key: key);
  VoidCallback? callback;
  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  String? errorLoginMessage;
  late TextEditingController _email;
  late TextEditingController _pass;
  bool hidepassword = true;
  final Validators _validators = Validators();
  final _globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _pass = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Form(
          key: _globalFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 20),
                      onTap: () {
                        widget.callback!();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Acceder por otro método",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Bienvenido, ingrese su correo y contraseña",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              CustomTextField1(
                validator: _validators.emailLoginValidator,
                inputHintText: 'Escriba su correo aqui',
                colorValidatorMessage: white,
                prefixIcon: const Icon(Icons.email),
                controller: _email,
                width: 320,
              ),
              CustomTextField1(
                hidePassword: hidepassword,
                validator: _validators.emptyFieldValidator,
                prefixIcon: const Icon(Icons.security),
                colorValidatorMessage: white,
                inputHintText: 'Contraseña',
                controller: _pass,
                width: 320,
                onPressedShowPassword: () {
                  setState(() {
                    hidepassword = !hidepassword;
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              errorLoginMessage != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 10),
                      child: Text(
                        '$errorLoginMessage',
                        style: const TextStyle(
                            color: white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),
              // ignore: prefer_const_constructors
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_testInputs()) {
                      final loginService = LoginService();
                      loginService
                          .signInWithEmail(_email.text, _pass.text)
                          .then((value) {
                        if (value == 'User valid') {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home',
                            (route) => false,
                          );
                        } else {
                          setState(() {
                            errorLoginMessage = value;
                          });
                        }
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 56, 166, 240),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15.0),
                  ),
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontSize: 16.0, color: white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              // ignore: prefer_const_constructors
              Container(
                margin: const EdgeInsets.only(bottom: 50.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1cebf5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 105, vertical: 15.0),
                    ),
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _testInputs() => _globalFormKey.currentState!.validate();
}
