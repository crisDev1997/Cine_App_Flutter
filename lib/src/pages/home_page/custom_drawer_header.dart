import 'package:cine_app/src/commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../providers/user_provider.dart';

// ignore: must_be_immutable
class CustomDrawerHeader extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider user = context.watch<UserProvider>();
    final userInfo = user.getProvideUserInfo();

    return FutureBuilder(
      future: userInfo,
      builder: (context, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.hasData) {
          var userData =
              snapshot.data ?? UserModel(uid: "", username: "", email: "");
          return Container(
            color: primary, // reemplaza "primary" con un color válido
            width: double.infinity,
            height: 100,
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10.0),
                CircleAvatar(
                  minRadius: 15.0,
                  maxRadius: 25.0,
                  foregroundColor: Colors.amber,
                  // agregar aquí una imagen o un texto dentro del avatar
                  foregroundImage: userData.photoURL != null
                      ? NetworkImage(userData.photoURL ?? "")
                      : null,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData.username,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        userData.email,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
 /* onForegroundImageError: (exception, stackTrace) =>
                              const Image(
                                image: AssetImage(
                                  'assets/images/no_image.jpg',
                                ),
                              ) */