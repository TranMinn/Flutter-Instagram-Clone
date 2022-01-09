import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/color_constants.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/models/UserPost.dart';
import 'package:instagram_clone/screens/edit_profile_screen.dart';
import 'package:instagram_clone/view_models/account_viewModel.dart';
import 'package:instagram_clone/widgets/loading_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AccountViewModel accountViewModel = AccountViewModel();
  int selectedIndex = 0;
  int noOfPosts = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<MyUserData?>(
        stream: accountViewModel.fetchCurrentUserData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingWidget();
          } else {
            MyUserData? myUserData = snapshot.data;

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
                                          image: myUserData!
                                                  .photoUrl!.isNotEmpty
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfileScreen(
                                              myUserData: myUserData,
                                            )));
                              },
                              child: Container(
                                height: 35,
                                width: (size.width - 20) * 0.9,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: grey),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: const Center(
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
                              child: const Center(
                                child: Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
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
                          stream: accountViewModel.fetchUserPost(),
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
            );
          }
        });
  }
}
