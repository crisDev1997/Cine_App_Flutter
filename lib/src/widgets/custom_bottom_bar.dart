// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({Key? key, this.index = 0, this.onTap}) : super(key: key);
  int index;
  Function? onTap;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (value) {
        onTap!.call(value);
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoritos"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/ticket_icon.svg'),
            label: "Mis boletos"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Mi Cuenta')
      ],
    );
  }
}
