// ignore_for_file: must_be_immutable

import 'package:cine_app/src/commons/colors.dart';
import 'package:flutter/material.dart';

import '../commons/validators.dart';

class CustomPhoneField extends StatelessWidget {
  CustomPhoneField(
      {Key? key,
      this.inputTitle = "",
      this.inputHintText = "",
      this.prefixText,
      this.prefixIcon,
      this.obscureText,
      this.width,
      this.colorValidatorMessage,
      required this.controller})
      : super(key: key);
  String inputTitle = "";
  String inputHintText = '';
  String? prefixText;
  Icon? prefixIcon;
  bool? obscureText;
  double? width;
  Color? colorValidatorMessage;

  // ignore: prefer_typing_uninitialized_variables
  var validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final Validators validators = Validators();
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
              keyboardType: TextInputType.phone,
              controller: controller,
              validator: ((value) {
                String phoneNumber = "+591${controller.text}";
                return validators.phoneValidator(phoneNumber);
              }),
              decoration: InputDecoration(
                prefixText: prefixText,
                prefixStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
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
              ),
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            )
          ],
        ));
  }
}
