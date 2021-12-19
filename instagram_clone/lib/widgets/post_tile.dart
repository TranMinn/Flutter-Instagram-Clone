import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/models/UserPost.dart';

class PostTile extends StatefulWidget {
  final PostData post;
  const PostTile({Key? key, required this.post}) : super(key: key);

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                          image: NetworkImage(widget.post.postOwnerPhotoUrl!),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.post.postOwnerName!,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                image: NetworkImage(widget.post.postPhotoUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      splashRadius: 25,
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/icons/love_icon.svg',
                          width: 40, height: 40, color: Colors.black87),
                    ),
                    IconButton(
                      splashRadius: 25,
                      onPressed: () {},
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
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '0 like',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text.rich(TextSpan(
                  children: [
                    TextSpan(
                      text: widget.post.postOwnerName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' '),
                    TextSpan(text: widget.post.caption, style: TextStyle(height: 1.5)),
                  ],
                )
                ),
                SizedBox(height: 8,),
                Text('View all comments', style: TextStyle(color: Colors.grey),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
