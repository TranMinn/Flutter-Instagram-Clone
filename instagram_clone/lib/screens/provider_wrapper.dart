import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/screens/wrapper.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:provider/provider.dart';

import 'authenticate.dart';
import 'home_screen.dart';
class ProviderWrapper extends StatelessWidget {
  const ProviderWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return StreamProvider<MyUser?>.value(
    //   catchError: (_,__) => null,
    //   value: AuthService().user,
    //   initialData: null,
    //   child: Container(
    //     child: Wrapper(),
    //   ),
    // );
    
    return StreamBuilder<MyUser?>(
      stream: AuthService().user,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return HomeScreen();
        }else{
          return Authenticate();
        }

      }
    );
  }
}
