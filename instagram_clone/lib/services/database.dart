import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/User.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // Collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('userData');

  // Update data to collection with specific ID
  Future updateUserData(String userId, String email, String userName,
      String profileName, String bio, String photoUrl) async {
    return await userCollection.doc(uid).set({
      'userId': uid,
      'email': email,
      'userName': userName,
      'profileName': profileName,
      'bio': bio,
      'photoUrl': photoUrl,
    });
  }

  // User data list from Snapshot
  List<MyUserData> _listUserDataFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MyUserData(
          email: doc.get('email') ?? '',
          profileName: doc.get('profileName') ?? '',
          userName: doc.get('userName') ?? '',
          bio: doc.get('bio') ?? '',
          photoUrl: doc.get('photoUrl') ?? '',
          userId: doc.get('userId') ?? '');
    }).toList();
  }

  // Create stream - notify changes to database doc -> use & present data
  // Snapshot - object contains current doc
  Stream<List<MyUserData>> get userData {
    return userCollection.snapshots().map(_listUserDataFromSnapShot);
  }
}
