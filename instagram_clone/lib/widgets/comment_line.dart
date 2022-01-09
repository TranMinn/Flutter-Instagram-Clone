import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/models/PostComment.dart';

class CommentLine extends StatefulWidget {
  final PostComment postComment;
  const CommentLine({Key? key, required this.postComment}) : super(key: key);

  @override
  State<CommentLine> createState() => _CommentLineState();
}

class _CommentLineState extends State<CommentLine> {
  @override
  Widget build(BuildContext context) {
    PostComment comment = widget.postComment;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(comment.userPhotoUrl!),
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
                            text: comment.userName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                          text: ' ${comment.comment}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          '4h',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 16),
                        Text('0 likes',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 16),
                        Text('Reply',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              'assets/icons/love_icon.svg',
              color: Colors.grey,
              width: 15,
              height: 15,
            ),
          )
        ],
      ),
    );
  }
}
