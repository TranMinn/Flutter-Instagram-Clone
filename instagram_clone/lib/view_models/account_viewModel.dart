import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/models/UserPost.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/services/post_services.dart';
import 'package:instagram_clone/services/user_services.dart';

class AccountViewModel {
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  Stream<MyUserData?> get fetchCurrentUserData {
    return UserService(uid: currentUserId).userData;
  }

  Stream<List<PostData>> fetchUserPost() {
    return PostService().listUserPost(currentUserId!);
  }

  Future logOut() async {
    return await AuthService().logOut();
  }
}
