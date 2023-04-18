import 'package:cine_app/src/commons/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinInput extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  PinInput({Key? key, required this.controller, this.node}) : super(key: key);
  final TextEditingController controller;
  final FocusScopeNode? node;
  @override
  Widget build(BuildContext context) {
    final Validators _validators = Validators();
    return Container(
      width: 50,
      height: 60,
      decoration: BoxDecoration(
          color: const Color(0xffe9f0f3),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
              color: Colors.black, width: 0.5, style: BorderStyle.none)),
      child: TextFormField(
        controller: controller,
        validator: (value) => _validators.emptyInputPin(value),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (value) {
          if (value.length == 1) node?.nextFocus();
        },
        decoration: const InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.only(bottom: 40),
          errorStyle: TextStyle(height: 0),
          enabledBorder: OutlineInputBorder(gapPadding: 40.0),
          border: OutlineInputBorder(gapPadding: 40.0),
        ),
      ),
    );
  }
}
