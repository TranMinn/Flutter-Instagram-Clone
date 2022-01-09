
import 'package:instagram_clone/models/PostComment.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/services/post_services.dart';

class CommentViewModel {
  Future uploadComment(MyUserData myUserData, String postId, String comment) async {
    await PostService().uploadComment(myUserData, postId, comment);
  }

  Stream<List<PostComment>> fetchListPostComment(String postId) {
    return PostService().listPostComment(postId);
  }

}