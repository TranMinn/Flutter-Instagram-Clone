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
    });
  }

  Future updateUserProfile(
      String userName, String profileName, String bio) async {
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
}
