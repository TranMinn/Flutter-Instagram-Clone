import 'package:flutter/material.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/services/database.dart';
import 'package:instagram_clone/widgets/root_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //   return StreamProvider<List<MyUserData>>.value(
    //     value: DatabaseService().userData,
    //     initialData: [],
    //     child: Scaffold(
    //       body: Center(
    //         child: RootScreen(),
    //       ),
    //     ),
    //   );
    // }

    return Scaffold(
      body: RootScreen(),
    );
  }
}
