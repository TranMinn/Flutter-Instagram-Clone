import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/models/UserPost.dart';
import 'package:instagram_clone/services/post_services.dart';
import 'package:instagram_clone/services/user_services.dart';

class UserProfileViewModel {

  Stream<MyUserData?> fetchUserById(String userId) {
    return UserService().getUserById(userId);
  }

  Stream<List<PostData>> fetchUserPosts(String userId) {
    return PostService().listUserPost(userId);
  }

  Future followUser(String currentUserId, String followedUserId) async {
    await UserService().followUser(currentUserId, followedUserId);
  }
}
