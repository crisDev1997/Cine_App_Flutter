import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

// ignore: must_be_immutable
class DrawerList extends StatelessWidget {
  DrawerList({Key? key}) : super(key: key);

  var drawerItems = [
    {"icon": "", "name": "Mis boletos"},
    {"icon": "", "name": "Facturas"},
    {"icon": "", "name": "Mi cuenta"},
    {"icon": "", "name": "Terminos y condiciones de uso"},
    {"icon": "", "name": "Acerca de"},
    {"icon": "", "name": "Cerrar Sesión"}
  ];

  @override
  Widget build(BuildContext context) {
    UserProvider user = context.watch<UserProvider>();
    return Container(
      padding: const EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DrawerMenuItem(
          svgAsset: 'assets/svg/ticket_icon.svg',
          title: "Mis Boletos",
        ),
        DrawerMenuItem(
          svgAsset: 'assets/svg/invoice_icon.svg',
          title: "Facturas",
        ),
        DrawerMenuItem(
          icon: Icons.account_circle,
          title: "Mi Cuenta",
        ),
        const Divider(color: Colors.black45, height: 1.0),
        const SizedBox(
          height: 10,
        ),
        DrawerMenuItem(
          icon: Icons.document_scanner,
          title: "Términos y Condiciones de Uso",
        ),
        DrawerMenuItem(icon: Icons.question_answer, title: "Acerca de"),
        InkWell(
          onTap: () {
            user.secureLogout().then((value) =>
                Navigator.of(context).pushReplacementNamed("/login"));
          },
          child: DrawerMenuItem(
            icon: Icons.logout,
            title: "Cerrar Sesión",
          ),
        )
      ]),
    );
  }
}

// ignore: must_be_immutable
class DrawerMenuItem extends StatelessWidget {
  DrawerMenuItem(
      {Key? key, required this.title, this.imgAsset, this.icon, this.svgAsset})
      : super(key: key);
  IconData? icon;
  String? svgAsset;
  String? imgAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imgAsset != null
                  ? Expanded(
                      flex: 2,
                      child: Image.asset(
                        imgAsset!,
                        fit: BoxFit.fill,
                        height: 25,
                        width: 25,
                      ),
                    )
                  : Container(),
              svgAsset != null
                  ? Expanded(
                      flex: 2,
                      child: SvgPicture.asset(svgAsset!,
                          width: 30, height: 30, fit: BoxFit.contain),
                    )
                  : Container(),
              icon != null
                  ? Expanded(
                      flex: 2,
                      child: Icon(
                        icon,
                        size: 20,
                        color: Colors.black,
                      ))
                  : Container(),
              Expanded(
                flex: 7,
                child: Text(
                  title,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
