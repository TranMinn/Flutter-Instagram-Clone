
import 'package:instagram_clone/services/post_services.dart';

class PostTileViewModel {

  Future likePost(String postId, String userId, List likes) async {
    await PostService().likePost(postId, userId, likes);
  }

}