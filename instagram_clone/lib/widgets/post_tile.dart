import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/models/UserPost.dart';
import 'package:instagram_clone/screens/comment_screen.dart';
import 'package:instagram_clone/view_models/postTile_viewModel.dart';
import 'package:instagram_clone/view_models/account_viewModel.dart';

class PostTile extends StatefulWidget {
  final PostData post;
  const PostTile({Key? key, required this.post}) : super(key: key);

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  PostTileViewModel postTileViewModel = PostTileViewModel();
  AccountViewModel profileViewModel = AccountViewModel();

  @override
  Widget build(BuildContext context) {
    PostData widgetPost = widget.post;
    return StreamBuilder<MyUserData?>(
        stream: profileViewModel.fetchCurrentUserData,
        builder: (context, snapshot) {
          String? currentUserId = snapshot.data?.userId;

          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(widgetPost.postOwnerPhotoUrl!),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widgetPost.postOwnerName!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/icons/menu_vertical.png',
                        width: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widgetPost.postPhotoUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            splashRadius: 25,
                            onPressed: () async {
                              await postTileViewModel.likePost(
                                  widgetPost.postId!,
                                  currentUserId!,
                                  widgetPost.likes!);
                            },
                            icon: widgetPost.likes!.contains(currentUserId)
                                ? SvgPicture.asset(
                                    'assets/icons/loved_icon.svg')
                                : SvgPicture.asset('assets/icons/love_icon.svg',
                                    width: 40,
                                    height: 40,
                                    color: Colors.black87),
                          ),
                          IconButton(
                            splashRadius: 25,
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CommentScreen(
                                    postData: widgetPost,
                                  ),
                                )),
                            icon: Image.asset(
                              'assets/icons/comment_icon.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          IconButton(
                            splashRadius: 25,
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/icons/share_icon.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        splashRadius: 25,
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/bookmark_icon.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widgetPost.likes!.length} likes',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text.rich(TextSpan(
                        children: [
                          TextSpan(
                            text: widgetPost.postOwnerName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(
                              text: widgetPost.caption,
                              style: const TextStyle(height: 1.5)),
                        ],
                      )),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CommentScreen(postData: widgetPost),
                            )),
                        child: const Text(
                          'View all comments',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
