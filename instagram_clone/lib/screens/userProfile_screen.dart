import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/models/UserPost.dart';
import 'package:instagram_clone/view_models/userProfile_viewModel.dart';
import 'package:instagram_clone/widgets/loading_widget.dart';

import '../color_constants.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;
  const UserProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserProfileViewModel userProfileViewModel = UserProfileViewModel();
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  int selectedIndex = 0;
  int noOfPosts = 0;
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<MyUserData?>(
        stream: userProfileViewModel.fetchUserById(widget.userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingWidget();
          }

          final MyUserData? myUserData = snapshot.data;
          isFollowing = myUserData!.followers!.contains(currentUserId);

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 26,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                myUserData.profileName ?? '',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    "assets/icons/menu_icon.svg",
                    width: 26,
                  ),
                )
              ],
            ),
            body: Container(
              child: ListView(
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
                                          image: myUserData.photoUrl!.isNotEmpty
                                              ? NetworkImage(
                                                  myUserData.photoUrl ?? '')
                                              : const AssetImage(
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
                                        noOfPosts.toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        "Posts",
                                        style: TextStyle(
                                            fontSize: 15, height: 1.5),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${myUserData.followers?.length}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        "Followers",
                                        style: TextStyle(
                                            fontSize: 15, height: 1.5),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${myUserData.following?.length}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
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
                        const SizedBox(height: 15),
                        Text(myUserData.userName ?? 'Name'),
                        Text(myUserData.bio ?? 'Bio'),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: isFollowing
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    await userProfileViewModel
                                                        .followUser(
                                                            currentUserId!,
                                                            widget.userId)
                                                        .then((value) =>
                                                            Navigator.pop(
                                                                context));
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 20,
                                                        horizontal: 60),
                                                    child:
                                                        const Text('Unfollow'),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  'Following',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Icon(Icons.keyboard_arrow_down),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(width: 1, color: grey),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Message',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      height: 35,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: grey),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.keyboard_arrow_down),
                                      ),
                                    ),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    await userProfileViewModel.followUser(
                                        currentUserId!, widget.userId);
                                  },
                                  child: Container(
                                    height: 35,
                                    width: size.width - 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: grey),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.blue,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Follow",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 0.5,
                    width: size.width,
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.8)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        Container(
                          width: size.width * 0.5,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                            icon: Image.asset(
                              'assets/icons/grid_icon.png',
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.5,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                            icon: Image.asset(
                              'assets/icons/idBadge_icon.png',
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 1,
                        width: (size.width * 0.5),
                        decoration: BoxDecoration(
                            color: selectedIndex == 0
                                ? Colors.black
                                : Colors.transparent),
                      ),
                      Container(
                        height: 1,
                        width: (size.width * 0.5),
                        decoration: BoxDecoration(
                            color: selectedIndex == 1
                                ? Colors.black
                                : Colors.transparent),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  selectedIndex == 0
                      ? StreamBuilder<List<PostData>>(
                          stream: userProfileViewModel
                              .fetchUserPosts(widget.userId),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              final List<PostData>? listPosts = snapshot.data;
                              noOfPosts = listPosts?.length ?? 0;

                              return GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 1,
                                ),
                                itemCount: listPosts?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Image.network(
                                      listPosts?[index].postPhotoUrl ?? '',
                                      fit: BoxFit.cover);
                                },
                              );
                            }
                          })
                      : Container()
                ],
              ),
            ),
          );
        });
  }
}
