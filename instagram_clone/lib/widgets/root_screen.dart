import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/screens/activity_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/reels_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';
import 'package:instagram_clone/screens/upload_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/services/database.dart';
import 'package:instagram_clone/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import 'feed.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(child: getAppBar())),
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    List<Widget> screens = [
      Feed(),
      SearchScreen(),
      ReelsScreen(),
      ActivityScreen(),
      ProfileScreen(),
    ];
    return IndexedStack(
      index: pageIndex,
      children: screens,
    );
  }

  Widget? getAppBar() {
    if (pageIndex == 0) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Instagram",
          style: TextStyle(
              fontFamily: 'Signatra', fontSize: 33, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UploadScreen();
                  },
                ),
              );
            },
            child: SvgPicture.asset(
              "assets/icons/upload_icon.svg",
              width: 26,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              "assets/icons/messenger_icon.svg",
              width: 26,
            ),
          ),
          SizedBox(width: 10),
        ],
      );
    } else if (pageIndex == 1) {
      return AppBar(
        title: Text("Search"),
      );
    } else if (pageIndex == 2) {
      return AppBar(
        title: Text("Upload"),
      );
    } else if (pageIndex == 3) {
      return AppBar(
        title: Text("Activity"),
      );
    } else {
      return profileScreenAppbar();
    }
  }

  Widget getFooter() {
    List bottomItems = [
      pageIndex == 0
          ? "assets/icons/home_active_icon.svg"
          : "assets/icons/home_icon.svg",
      pageIndex == 1
          ? "assets/icons/search_active_icon.svg"
          : "assets/icons/search_icon.svg",
      pageIndex == 2
          ? "assets/icons/reels_active_icon.svg"
          : "assets/icons/reels_icon.svg",
      pageIndex == 3
          ? "assets/icons/love_active_icon.svg"
          : "assets/icons/love_icon.svg",
      pageIndex == 4
          ? "assets/icons/account_active_icon.svg"
          : "assets/icons/account_icon.svg",
    ];
    return Container(
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: SvgPicture.asset(
                  bottomItems[index],
                  color: Colors.black,
                  width: 26,
                ));
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }

  // Profile screen Appbar
  Widget profileScreenAppbar(){
    return StreamBuilder<MyUserData?>(
      stream : DatabaseService(uid: currentUserId).userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingWidget();
        } else {
          MyUserData? myUserData = snapshot.data;
          return AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 3, right: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${myUserData!.profileName}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down, color: Colors.black)
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/upload_icon.svg",
                          width: 26,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        SvgPicture.asset(
                          "assets/icons/menu_icon.svg",
                          width: 26,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

      }
    );
  }
}
