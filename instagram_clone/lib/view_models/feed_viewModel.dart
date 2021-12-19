
import 'package:instagram_clone/models/UserPost.dart';
import 'package:instagram_clone/services/post_services.dart';

class FeedViewModel {

  Stream<List<PostData>> get fetchListPost {
    return PostService().listPostData;
  }
}