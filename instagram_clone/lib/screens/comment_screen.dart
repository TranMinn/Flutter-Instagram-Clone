import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/PostComment.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/models/UserPost.dart';
import 'package:instagram_clone/view_models/comment_viewModel.dart';
import 'package:instagram_clone/view_models/account_viewModel.dart';
import 'package:instagram_clone/widgets/comment_line.dart';

class CommentScreen extends StatefulWidget {
  final PostData postData;
  const CommentScreen({Key? key, required this.postData}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  CommentViewModel commentViewModel = CommentViewModel();
  AccountViewModel accountViewModel = AccountViewModel();
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PostData widgetPost = widget.postData;

    return StreamBuilder<MyUserData?>(
        stream: accountViewModel.fetchCurrentUserData,
        builder: (context, snapshot) {
          MyUserData? myUserData = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Comments',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  icon: Image.asset(
                    'assets/icons/share_icon.png',
                    width: 35,
                    height: 35,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(widgetPost.postOwnerPhotoUrl!),
                          radius: 18,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: '${widgetPost.postOwnerName}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      TextSpan(
                                        text: ' ${widgetPost.caption}',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    '4h',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  StreamBuilder<List<PostComment>>(
                      stream: commentViewModel
                          .fetchListPostComment(widgetPost.postId!),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }

                        if (snapshot.hasData) {
                          final List<PostComment> comments = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: comments.length,
                            itemBuilder: (context, index) => CommentLine(
                              postComment: comments[index],
                            ),
                          );
                        }
                        return Container();
                      }),
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: kToolbarHeight,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(myUserData?.photoUrl ?? ''),
                        radius: 18,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: TextField(
                            controller: commentController,
                            decoration: const InputDecoration(
                              hintText: 'Add a comment ...',
                              hintStyle: TextStyle(fontSize: 12),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (commentController.text.isNotEmpty) {
                            await commentViewModel
                                .uploadComment(myUserData!, widgetPost.postId!,
                                    commentController.text)
                                .then((value) {
                              setState(() {
                                commentController.text = '';
                              });
                            });
                          }
                        },
                        child: Container(
                          child: Text(
                            'Post',
                            style: commentController.text.isNotEmpty
                                ? const TextStyle(
                                    color: Colors.blue, fontSize: 12)
                                : TextStyle(
                                    color: Colors.blue[100], fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
