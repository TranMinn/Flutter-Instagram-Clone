import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String? uid;
  MyUser({this.uid});
}

class MyUserData {
  final String? userId;
  final String? email;
  final String? userName;
  final String? profileName;
  final String? bio;
  final String? photoUrl;

  MyUserData(
      {this.profileName,
      this.email,
      this.userName,
      this.bio,
      this.photoUrl,
      this.userId});

  factory MyUserData.fromDocument(DocumentSnapshot doc) {
    return MyUserData(
        // email: document['email'] ?? '',
        // userName: document['userName'] ?? '',
        // profileName: document['profileName'] ?? '',
        // photoUrl: document['photoUrl'] ?? '',
        // bio: document['bio'] ?? '',
        // userId: document.id

        email: doc.get('email') ?? '',
        profileName: doc.get('profileName') ?? '',
        userName: doc.get('userName') ?? '',
        bio: doc.get('bio') ?? '',
        photoUrl: doc.get('photoUrl') ?? '',
        userId: doc.get('userId') ?? '');
  }
}
