import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/User.dart';

class UserService {
  final String? uid;
  UserService({this.uid});

  // Collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('userData');

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
      'following': [],
      'followers': []
    });
  }

  // Update user profile (Used for Edit profile function)
  Future updateUserProfile(
      String userName, String profileName, String bio, String photoUrl) async {
    Map<String, dynamic> map = Map();
    map['userName'] = userName;
    map['profileName'] = profileName;
    map['bio'] = bio;
    map['photoUrl'] = photoUrl;

    return userCollection.doc(uid).update(map);
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
          userId: doc.get('userId') ?? '',
          following: doc.get('following') ?? [],
          followers: doc.get('followers') ?? []);
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
        following: snapshot.get('following') ?? [],
        followers: snapshot.get('followers') ?? []);
  }

  Stream<MyUserData?> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Get user data by ID
  Stream<MyUserData> getUserById(String userId) {
    return userCollection.doc(userId).snapshots().map(_userDataFromSnapshot);
  }

  // Get user data by profileName
  Stream<List<MyUserData>> getUserByProfileName(String profileName) {
    return userCollection
        .orderBy('profileName')
        .startAt([profileName])
        .endAt([profileName + '\uf8ff'])
        .snapshots()
        .map(_listUserDataFromSnapShot);
  }

  // Follow user
  Future followUser(String currentUserId, String followedUserId) async {
    try {
      // Get following of current user
      DocumentSnapshot snap = await userCollection.doc(currentUserId).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followedUserId)) {
        await userCollection.doc(followedUserId).update({
          'followers': FieldValue.arrayRemove([currentUserId])
        });
        await userCollection.doc(currentUserId).update({
          'following': FieldValue.arrayRemove([followedUserId])
        });
      } else {
        await userCollection.doc(followedUserId).update({
          'followers': FieldValue.arrayUnion([currentUserId])
        });
        await userCollection.doc(currentUserId).update({
          'following': FieldValue.arrayUnion([followedUserId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
