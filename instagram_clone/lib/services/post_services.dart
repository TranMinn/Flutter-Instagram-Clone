import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/PostComment.dart';
import 'package:instagram_clone/models/UserPost.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:uuid/uuid.dart';

class PostService {
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('postData');

  final CollectionReference postCommentCollection =
      FirebaseFirestore.instance.collection('postComment');

  String postId = Uuid().v4();
  String commentId = Uuid().v4();

  // Update data to post collection with specific ID
  Future updatePostData(MyUserData currentUser, String postPhotoUrl,
      String caption, String location) async {
    try {
      return await postCollection.doc(postId).set({
        'postId': postId,
        'userId': currentUser.userId,
        'postPhotoUrl': postPhotoUrl,
        'caption': caption,
        'location': location,
        'time': DateTime.now(),
        'likes': [],
        'postOwnerName': currentUser.profileName,
        'postOwnerPhotoUrl': currentUser.photoUrl,
      });
    } catch (e) {
      return e.toString();
    }
  }

  List<PostData> _listPostDataFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostData(
          postPhotoUrl: doc.get('postPhotoUrl') ?? '',
          caption: doc.get('caption') ?? '',
          location: doc.get('location') ?? '',
          time: doc.get('time') ?? '',
          likes: doc.get('likes') ?? [],
          postOwnerName: doc.get('postOwnerName') ?? '',
          postOwnerPhotoUrl: doc.get('postOwnerPhotoUrl') ?? '',
          userId: doc.get('userId') ?? '',
          postId: doc.get('postId'));
    }).toList();
  }

  Stream<List<PostData>> get listPostData {
    return postCollection.orderBy('time', descending: true).snapshots().map(_listPostDataFromSnapShot);
  }

  PostData _postDataFromSnapshot(DocumentSnapshot snapshot) {
    return PostData(
        postPhotoUrl: snapshot.get('postPhotoUrl') ?? '',
        caption: snapshot.get('caption') ?? '',
        location: snapshot.get('location') ?? '',
        time: snapshot.get('time') ?? '',
        likes: snapshot.get('likes') ?? [],
        postOwnerName: snapshot.get('postOwnerName') ?? '',
        postOwnerPhotoUrl: snapshot.get('postOwnerPhotoUrl') ?? '',
        userId: snapshot.get('userId') ?? '',
        postId: snapshot.get('postId') ?? '');
  }

  Stream<PostData> get postData {
    return postCollection.doc(postId).snapshots().map(_postDataFromSnapshot);
  }

  // Like post
  Future likePost(String postId, String userId, List likes) async {
    try {
      if (likes.contains(userId)) {
        postCollection.doc(postId).update({
          'likes': FieldValue.arrayRemove([userId])
        });
      } else {
        postCollection.doc(postId).update({
          'likes': FieldValue.arrayUnion([userId])
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // Upload a comment
  Future uploadComment(
      MyUserData myUserData, String postId, String comment) async {
    try {
      return await postCollection
          .doc(postId)
          .collection('postComment')
          .doc(commentId)
          .set({
        'postId': postId,
        'userId': myUserData.userId,
        'userName': myUserData.userName,
        'userPhotoUrl': myUserData.photoUrl,
        'comment': comment,
        'time': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
  }

  List<PostComment> _listPostCommentFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostComment(
        postId: doc.get('postId') ?? '',
        userId: doc.get('userId') ?? '',
        userName: doc.get('userName') ?? '',
        userPhotoUrl: doc.get('userPhotoUrl') ?? '',
        comment: doc.get('comment') ?? '',
        time: doc.get('time') ?? '',
      );
    }).toList();
  }

  // Get post comments by post ID
  Stream<List<PostComment>> listPostComment(String postId) {
    return postCollection.doc(postId).collection('postComment').orderBy('time', descending: true).snapshots().map(_listPostCommentFromSnapShot);
  }

  // Get list posts by user ID
  Stream<List<PostData>> listUserPost(String userId) {
    return postCollection.where('userId', isEqualTo: userId).snapshots().map(_listPostDataFromSnapShot);
  }

}
