import 'package:cine_app/src/commons/colors.dart';
import 'package:cine_app/src/commons/route_transitions.dart';
import 'package:cine_app/src/commons/validators.dart';
import 'package:cine_app/src/models/user_model.dart';
import 'package:cine_app/src/services/register_service.dart';
import 'package:cine_app/src/widgets/custom_phonefield.dart';
import 'package:cine_app/src/widgets/custom_textfield1.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _email, _username, _phone, _pass;
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  bool emailPhoneExists = false;
  final _globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _username = TextEditingController();
    _phone = TextEditingController();
    _pass = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _username.dispose();
    _phone.dispose();
    _pass.dispose();
    _globalFormKey.currentState!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Validators validators = Validators();
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _globalFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.32,
                  decoration: BoxDecoration(
                      color: primary,
                      border: Border.all(width: 0.1, style: BorderStyle.solid),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: white, width: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          color: white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Crear cuenta",
                          style: TextStyle(color: white, fontSize: 36.0),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 55.0,
                        ),
                        child: Text(
                          "en Cine App",
                          style: TextStyle(color: white, fontSize: 36.0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Rellene los siguientes campos: ",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      CustomTextField1(
                        validator: validators.userNameValidator,
                        controller: _username,
                        inputHintText: 'Nombre de usuario',
                        prefixIcon: const Icon(Icons.person),
                      ),
                      CustomTextField1(
                        validator: validators.emailLoginValidator,
                        controller: _email,
                        inputHintText: 'Correo',
                        prefixIcon: const Icon(Icons.email),
                      ),
                      CustomPhoneField(
                        prefixText: "+591 ",
                        controller: _phone,
                        inputHintText: "Número de Celular",
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      CustomTextField1(
                        validator: validators.passValidator,
                        hidePassword: hidePassword,
                        controller: _pass,
                        prefixIcon: const Icon(Icons.security),
                        inputHintText: 'Contraseña',
                        onPressedShowPassword: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: RichText(
                          text: TextSpan(children: <TextSpan>[
                            const TextSpan(
                                text: "Al continuar con el registro, ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0)),
                            TextSpan(
                                text: "acepto los terminos y condiciones ",
                                style: TextStyle(
                                    color: Colors.blue[400], fontSize: 14.0)),
                            const TextSpan(
                                text: "para el uso de la aplicación. ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0)),
                          ]),
                        ),
                      ),
                      emailPhoneExists == true
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "El correo electrónico o número de teléfono introducidos fueron registrados anteriormente en otra cuenta de correo o por otro método de acceso, use otro correo o número de teléfono",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              ),
                            )
                          : Container(),
                      Center(
                        child: ElevatedButton(
                            onPressed: () async {
                              String phoneNumber = "+591${_phone.text}";
                              if (_testInputs()) {
                                var registerService = RegisterService();
                                var accountExists =
                                    await registerService.verifyExistAccount(
                                        _email.text, phoneNumber);

                                if (accountExists == false) {
                                  setState(() {
                                    emailPhoneExists = false;
                                  });
                                  RouteTransition route =
                                      // ignore: use_build_context_synchronously
                                      RouteTransition(context);
                                  // ignore: use_build_context_synchronously

                                  UserModel userData = UserModel(
                                      uid: "",
                                      username: _username.text,
                                      email: _email.text,
                                      phone: phoneNumber);
                                  await registerService
                                      .createUserWithEmailNoVerification(
                                          _email.text, _pass.text, userData)
                                      .then((value) {
                                    if (value ==
                                        "Usuario registrado exitosamente!") {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        '/home',
                                        (route) => false,
                                      );
                                    }
                                  });
                                } else {
                                  setState(() {
                                    emailPhoneExists = true;
                                  });
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue[600],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            child: SizedBox(
                              width: 110.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    "Continuar",
                                    style:
                                        TextStyle(color: white, fontSize: 16.0),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: white,
                                  )
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _testInputs() => _globalFormKey.currentState!.validate();
}
