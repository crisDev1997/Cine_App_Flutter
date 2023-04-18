import 'package:cine_app/src/commons/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField1 extends StatelessWidget {
  CustomTextField1(
      {Key? key,
      this.inputTitle = "",
      this.inputHintText = "",
      this.prefixText,
      this.prefixIcon,
      this.hidePassword,
      this.inputType,
      this.obscureText,
      this.width,
      this.onPressedShowPassword,
      this.callbackOnChange,
      this.colorValidatorMessage,
      this.validator,
      required this.controller})
      : super(key: key);
  String inputTitle = "";
  String inputHintText = '';
  String? prefixText;
  TextInputType? inputType;
  Icon? prefixIcon;
  bool? obscureText;
  bool? hidePassword;
  double? width;
  Color? colorValidatorMessage;
  final Function? onPressedShowPassword;
  final void Function(String)? callbackOnChange;
  // ignore: prefer_typing_uninitialized_variables
  var validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              inputTitle,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            TextFormField(
              keyboardType: inputType,
              controller: controller,
              validator: ((value) {
                if (validator != null) {
                  return validator(value);
                }
                return null;
              }),
              obscureText: hidePassword ?? false,
              decoration: InputDecoration(
                  prefixText: prefixText,
                  prefixStyle:
                      const TextStyle(color: Colors.black, fontSize: 12.0),
                  filled: true,
                  fillColor: Colors.white,
                  errorMaxLines: 2,
                  errorStyle: TextStyle(
                      fontSize: 12.0,
                      color: colorValidatorMessage ?? black,
                      fontWeight: FontWeight.bold),
                  hintText: inputHintText,
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10.0)),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  prefixIcon: prefixIcon,
                  suffixIcon: hidePassword != null
                      ? hidePassword == false
                          ? IconButton(
                              icon: const Icon(Icons.visibility),
                              onPressed: () {
                                onPressedShowPassword?.call();
                              },
                            )
                          : IconButton(
                              icon: const Icon(Icons.visibility),
                              onPressed: () {
                                onPressedShowPassword?.call();
                              },
                            )
                      : null),
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            )
          ],
        ));
  }
}
