import 'package:cine_app/src/commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainAppBar(
      {Key? key,
      this.title = "",
      required this.tabController,
      required this.preferredSize,
      this.onTap})
      : super(key: key);
  @override
  final Size preferredSize;
  final TabController tabController;
  String title = "";
  Function? onTap;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primary,
      title: const Text("Cine App"),
      centerTitle: true,
      bottom: TabBar(
          indicatorColor: Colors.white,
          isScrollable: true,
          controller: tabController,
          tabs: tabss),
    );
  }
}

final tabss = <Tab>[
  Tab(
    height: 60,
    child: Column(
      children: const [
        FaIcon(
          FontAwesomeIcons.home,
          size: 26,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "Principal",
          style: TextStyle(fontSize: 12),
        ),
      ],
    ),
  ),
  Tab(
    height: 60,
    child: Column(
      children: const [
        FaIcon(
          FontAwesomeIcons.calendarAlt,
          size: 26,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "Horarios",
          style: TextStyle(fontSize: 12),
        ),
      ],
    ),
  ),
  Tab(
    height: 60,
    child: Column(
      children: const [
        FaIcon(
          FontAwesomeIcons.film,
          size: 26,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "Estrenos",
          style: TextStyle(fontSize: 12),
        ),
      ],
    ),
  ),
  Tab(
    height: 60,
    child: Column(
      children: const [
        FaIcon(
          FontAwesomeIcons.newspaper,
          size: 26,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "Promos",
          style: TextStyle(fontSize: 12),
        ),
      ],
    ),
  ),
  Tab(
    height: 60,
    child: Column(
      children: const [
        FaIcon(
          FontAwesomeIcons.ticketAlt,
          size: 26,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "Mis Boletos",
          style: TextStyle(fontSize: 12),
        ),
      ],
    ),
  ),
];
