import 'package:flutter/material.dart';

class SearchMovie extends StatelessWidget {
  SearchMovie({
    Key? key,
    required this.controller,
    required this.dateFormated,
    this.onEditComplete,
  }) : super(key: key);
  TextEditingController controller;
  String dateFormated;
  VoidCallback? onEditComplete;

  @override
  Widget build(BuildContext context) {
    FocusNode focus = FocusNode();

    return SizedBox(
        width: 300,
        child: TextFormField(
          focusNode: focus,
          controller: controller,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          onEditingComplete: () {
            onEditComplete!.call();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Buscar Película',
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(10.0)),
            contentPadding: const EdgeInsets.all(10.0),
            prefixIcon: const Icon(Icons.search),
          ),
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ));
  }
}
