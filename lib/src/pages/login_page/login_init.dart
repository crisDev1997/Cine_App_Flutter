// ignore_for_file: prefer_const_constructors

import 'package:cine_app/src/commons/colors.dart';
import 'package:cine_app/src/services/google_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

// ignore: must_be_immutable
class LoginInit extends StatelessWidget {
  LoginInit({Key? key, this.callback}) : super(key: key);
  VoidCallback? callback;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Bienvenido a la aplicación oficial de Cine App",
            style: TextStyle(fontSize: 16.0, color: white),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Continué con una opción para Iniciar Sesión",
            style: TextStyle(fontSize: 14.0, color: white),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: SignInButton(Buttons.Email, text: "Continuar con correo",
                    onPressed: () {
                  callback!();
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: SignInButton(Buttons.Google,
                    text: 'Continuar con Google', onPressed: () async {
                  await GoogleSignInService.signInWithGoogle().then((value) {
                    if (value != null) {
                      return Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                        '/home',
                        (route) => false,
                      )
                          .catchError((e) {
                        print(e);
                      });
                    }
                    return null;
                  });
                }),
              ),
              /* Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: SignInButton(Buttons.Facebook,
                    text: "Continuar con Facebook", onPressed: () {
                  userService.signInWithFacebook().then((value) {
                    if (value != null) {
                      return Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home',
                        (route) => false,
                      );
                    }
                    return null;
                  });
                }),
              ), */
            ],
          ),
        ),
      ],
    );
  }
}
