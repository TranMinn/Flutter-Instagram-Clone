import 'package:flutter/material.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/screens/root_screen.dart';

class ProviderWrapper extends StatelessWidget {
  const ProviderWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MyUser?>(
        stream: AuthService().user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RootScreen();
          } else {
            return LoginScreen();
          }
        });
  }
}
