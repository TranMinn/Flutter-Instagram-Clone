
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/models/UserPost.dart';
import 'package:instagram_clone/services/post_services.dart';
import 'package:instagram_clone/services/user_services.dart';

class SearchViewModel {

  Stream<List<MyUserData>> getUserByProfileName(String profileName) {
    return UserService().getUserByProfileName(profileName);
  }

  Stream<List<PostData>> get fetchListPost {
    return PostService().listPostData;
  }

}