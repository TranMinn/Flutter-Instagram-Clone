import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/provider_wrapper.dart';
import 'package:instagram_clone/screens/wrapper.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  startTimer() async{
    var duration = Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route(){
    Navigator.pushReplacement(context, MaterialPageRoute(
        // builder: (context) => Wrapper()
        builder: (context) => ProviderWrapper()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset(
            'assets/icons/instagram.png',
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }
}
