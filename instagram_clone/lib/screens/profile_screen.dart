import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/color_constants.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/screens/edit_profile_screen.dart';
import 'package:instagram_clone/services/database.dart';
import 'package:instagram_clone/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<MyUserData?>(
        stream: DatabaseService(uid: currentUserId).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingWidget();
          } else {
            MyUserData? myUserData = snapshot.data;
            // print(myUserData.profileName);

            return Scaffold(
              body: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: (size.width - 20) * 0.3,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(width: 1, color: grey),
                                      image: DecorationImage(
                                          image: myUserData!.photoUrl!.isNotEmpty
                                              ? NetworkImage(
                                                  myUserData!.photoUrl!)
                                              : AssetImage(
                                                      'assets/icons/default_profile_image.jpg')
                                                  as ImageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: (size.width - 20) * 0.7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "0",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Posts",
                                        style: TextStyle(
                                            fontSize: 15, height: 1.5),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "0",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Followers",
                                        style: TextStyle(
                                            fontSize: 15, height: 1.5),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "0",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Following",
                                        style: TextStyle(
                                            fontSize: 15, height: 1.5),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(myUserData.userName!.isEmpty ? 'Name' : myUserData.userName!),
                        Text(myUserData.bio!.isEmpty ? 'Bio' : myUserData.bio!),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditProfileScreen(name: myUserData.userName!, username: myUserData.profileName!, bio: myUserData.bio!, photoUrl: myUserData.photoUrl!, )));
                              },
                              child: Container(
                                height: 35,
                                width: (size.width - 20) * 0.9,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: grey),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text("Edit Profile"),
                                ),
                              ),
                            ),
                            Container(
                              height: 35,
                              width: 30,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: grey),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 0.5,
                    width: size.width,
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.8)),
                  ),
                ],
              ),
            );
          }
        });
  }
}
