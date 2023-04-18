import 'package:cine_app/src/pages/home_page/custom_drawer_header.dart';
import 'package:cine_app/src/pages/home_page/drawer_list.dart';
import 'package:cine_app/src/pages/main_page/main_page.dart';
import 'package:cine_app/src/pages/promo_page/promo_page.dart';
import 'package:cine_app/src/pages/release_movies_page/release_movies_page.dart';
import 'package:cine_app/src/pages/schedule_page/schedule_page.dart';
import 'package:cine_app/src/pages/tickets_page/tickets_page.dart';
import 'package:cine_app/src/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int index = 0;
  String title = "Inicio";

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final UserProvider user = context.watch<UserProvider>();
    //print(user.signInMethod);
    return SafeArea(
      child: Scaffold(
          appBar: MainAppBar(
            onTap: (int value) {
              setState(() {
                index = value;
              });
            },
            tabController: tabController,
            preferredSize: const Size.fromHeight(130.0),
          ),
          body: TabBarView(controller: tabController, children: const [
            MainPage(),
            SchedulePage(),
            ReleaseMoviesPage(),
            PromoPage(),
            TicketsPage(),
          ]),
          drawerEnableOpenDragGesture: user.userInfo == "" ? false : true,
          drawer: GestureDetector(
            onHorizontalDragUpdate: (_) {
              if (user.userInfo == '') {
                // ignore: avoid_returning_null_for_void
                return null;
              }
            },
            child: Drawer(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomDrawerHeader(),
                    DrawerList(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
