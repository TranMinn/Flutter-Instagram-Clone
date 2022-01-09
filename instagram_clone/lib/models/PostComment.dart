import 'package:cloud_firestore/cloud_firestore.dart';

class PostComment {
  final String? postId;
  final String? userId;
  final String? userName;
  final String? userPhotoUrl;
  final String? comment;
  final Timestamp? time;

  PostComment(
      {this.postId, this.userId, this.userName, this.userPhotoUrl, this.comment, this.time});
}
