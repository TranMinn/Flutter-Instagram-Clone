import 'package:flutter/material.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/screens/authenticate.dart';
import 'package:instagram_clone/screens/home_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  // return either Authenticate or Home screen
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);

    if(user == null) {
      return Authenticate();
    }else{
      return HomeScreen();
    }
  }
}
