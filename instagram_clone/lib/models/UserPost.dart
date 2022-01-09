
import 'package:cloud_firestore/cloud_firestore.dart';

class PostData{
  final String? postId;
  final String? userId;
  final String? postPhotoUrl;
  final String? caption;
  final String? location;
  final Timestamp? time;
  final String? postOwnerName;
  final String? postOwnerPhotoUrl;
  final List? likes;

  PostData({this.postId, this.userId, this.postPhotoUrl, this.caption, this.location, this.time, this.postOwnerName, this.postOwnerPhotoUrl, this.likes});

}