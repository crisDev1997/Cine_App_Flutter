import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowScheduleEmpty extends StatelessWidget {
  const ShowScheduleEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Center(
            child: SvgPicture.asset('assets/images/schedule_empty.svg',
                height: 150),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Center(
            child: Text(
              'No hay funciones publicadas para este día',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Center(
            child: Text(
              'Revise si existen funciones en los otros dias',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
      ]),
    );
  }
}
