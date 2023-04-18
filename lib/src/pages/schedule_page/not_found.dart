import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoFoundResults extends StatelessWidget {
  const NoFoundResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Center(
            child: SvgPicture.asset('assets/images/no_found.svg', height: 150),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Center(
            child: Text(
              'No se encontro resultados para tu búsqueda',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Center(
            child: Text(
              'Utilice clave palabras relacionadas al título de la película',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
      ]),
    );
  }
}
