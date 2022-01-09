import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/models/UserPost.dart';
import 'package:instagram_clone/screens/upload_image_screen.dart';
import 'package:instagram_clone/view_models/feed_viewModel.dart';
import 'package:instagram_clone/widgets/appBars/homeScreen_appBar.dart';
import 'package:instagram_clone/widgets/loading_widget.dart';
import 'package:instagram_clone/widgets/post_tile.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  FeedViewModel feedViewModel = FeedViewModel();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostData>>(
        stream: feedViewModel.fetchListPost,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          } else {
            final posts = snapshot.data;

            return ListView.builder(
                itemCount: posts?.length,
                itemBuilder: (context, index) {
                  return PostTile(post: posts![index]);
                });
          }
        });
  }
}
