
import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  final String? userId;
  final String? postPhotoUrl;
  final String? caption;
  final String? location;
  final FieldValue? time;
  final String? postOwnerName;
  final String? postOwnerPhotoUrl;

  Post({this.userId, this.postPhotoUrl, this.caption, this.location, this.time, this.postOwnerName, this.postOwnerPhotoUrl});

}