import 'package:cine_app/src/pages/home_page/home_page.dart';
import 'package:cine_app/src/pages/login_page/login_page.dart';
import 'package:cine_app/src/pages/register_page/register_page.dart';
import 'package:cine_app/src/providers/movie_provider.dart';
import 'package:cine_app/src/providers/show_provider.dart';
import 'package:cine_app/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserProvider user = UserProvider();
  final MovieProvider movies = MovieProvider();
  final ShowProvider shows = ShowProvider();
  @override
  void initState() {
    super.initState();
    user.autologin();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(create: ((context) => user)),
          ChangeNotifierProvider<MovieProvider>(create: ((context) => movies)),
          ChangeNotifierProvider<ShowProvider>(
            create: ((context) => shows),
          )
        ],
        builder: (context, _) {
          var user = context.watch<UserProvider>();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cine App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            routes: {
              "/": (BuildContext context) {
                if (user.isloggedIn) {
                  return const HomePage();
                }
                return LoginPage();
              },
              "/login": (BuildContext context) => LoginPage(),
              "/home": (BuildContext context) => const HomePage(),
              "/register": (_) => const RegisterPage()
            },
          );
        });
  }
}


/*

(BuildContext context) {
                UserProvider user = context.watch<UserProvider>();
                
                if (user.isloggedIn) {
                  return const HomePage();
                }
                return LoginPage();
              },
              "/login": (BuildContext context) => LoginPage(),
              "/home": (BuildContext context) => const HomePage(),
              "/register": (_) => const RegisterPage()

 */