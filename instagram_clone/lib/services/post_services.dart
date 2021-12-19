import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/UserPost.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:uuid/uuid.dart';

class PostService {
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('postData');

  String postId = Uuid().v4();

  // Update data to post collection with specific ID
  Future updatePostData(MyUserData currentUser, String postPhotoUrl,
      String caption, String location) async {
    return await postCollection.doc(postId).set({
      'postId': postId,
      'userId': currentUser.userId,
      'postPhotoUrl': postPhotoUrl,
      'caption': caption,
      'location': location,
      'time': DateTime.now(),
      'postOwnerName': currentUser.profileName,
      'postOwnerPhotoUrl': currentUser.photoUrl,
    });
  }

  List<PostData> _listPostDataFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostData(
          postPhotoUrl: doc.get('postPhotoUrl') ?? '',
          caption: doc.get('caption') ?? '',
          location: doc.get('location') ?? '',
          time: doc.get('time') ?? '',
          postOwnerName: doc.get('postOwnerName') ?? '',
          postOwnerPhotoUrl: doc.get('postOwnerPhotoUrl') ?? '',
          userId: doc.get('userId') ?? '',
          postId: doc.get('postId'));
    }).toList();
  }

  Stream<List<PostData>> get listPostData {
    return postCollection.snapshots().map(_listPostDataFromSnapShot);
  }

  PostData _postDataFromSnapshot(DocumentSnapshot snapshot) {
    return PostData(
        postPhotoUrl: snapshot.get('postPhotoUrl') ?? '',
        caption: snapshot.get('caption') ?? '',
        location: snapshot.get('location') ?? '',
        time: snapshot.get('time') ?? '',
        postOwnerName: snapshot.get('postOwnerName') ?? '',
        postOwnerPhotoUrl: snapshot.get('postOwnerPhotoUrl') ?? '',
        userId: snapshot.get('userId') ?? '',
        postId: snapshot.get('postId') ?? '');
  }

  Stream<PostData> get postData {
    return postCollection.doc(postId).snapshots().map(_postDataFromSnapshot);
  }
}
