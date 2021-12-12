import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/Post.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('userData');
  final CollectionReference postCollection = FirebaseFirestore.instance.collection('postData');

  // Firebase Storage
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  // Update data to user collection with specific ID
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

  Future updateUserProfile(String userName,
      String profileName, String bio) async {
    Map<String, dynamic> map = Map();
    map['userName'] = userName;
    map['profileName'] = profileName;
    map['bio'] = bio;

    return userCollection.doc(uid).update(map);
  }

  Future<void> updatePhoto(String photoUrl) async {
    Map<String, dynamic> map = Map();
    map['photoUrl'] = photoUrl;
    return userCollection.doc(uid).update(map);
  }

  // Upload photo to FirebaseStorage
  Future uploadPhoto(String filePath, String fileName) async{
    File file = File(filePath);
    try{
      await storage.ref('photoUrl/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch(e){
      print(e);
    }
  }

  Future<String> downloadUrl(String fileName) async {
    String downloadURL = await storage.ref('photoUrl/$fileName').getDownloadURL();
    return downloadURL;
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
  Stream<List<MyUserData>> get listUserData {
    return userCollection.snapshots().map(_listUserDataFromSnapShot);
  }

  MyUserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return MyUserData(
      userId: uid,
      email: snapshot.get('email') ?? '',
      profileName: snapshot.get('profileName') ?? '',
      userName: snapshot.get('userName') ?? '',
      bio: snapshot.get('bio') ?? '',
      photoUrl: snapshot.get('photoUrl') ?? '',
    );
  }

  Stream<MyUserData?> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // ========== POST ==========
  // Update data to post collection with specific ID
  Future updatePostData(User currentUser, String postPhotoUrl, String caption,
      String location) async {
    return await userCollection.doc(uid).set({
      'userId': currentUser.uid,
      'postPhotoUrl': postPhotoUrl,
      'caption': caption,
      'location': location,
      'time': FieldValue.serverTimestamp(),
      'postOwnerName': currentUser.displayName,
      'postOwnerPhotoUrl': currentUser.photoURL,
    });
  }

  // Post data list from Snapshot
  List<Post> _listPostDataFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Post(
          postPhotoUrl: doc.get('postPhotoUrl') ?? '',
          caption: doc.get('caption') ?? '',
          location: doc.get('location') ?? '',
          time: doc.get('time') ?? '',
          postOwnerName: doc.get('postOwnerName') ?? '',
          postOwnerPhotoUrl: doc.get('postOwnerPhotoUrl') ?? '',
          userId: doc.get('userId') ?? '');
    }).toList();
  }

  Stream<List<Post>> get listPostData {
    return postCollection.snapshots().map(_listPostDataFromSnapShot);
  }

}
