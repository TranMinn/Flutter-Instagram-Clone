import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/services/user_services.dart';

class ProfileViewModel {
  Stream<MyUserData?> get fetchUserData {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    return UserService(uid: currentUserId).userData;
  }

  Future logOut() async{
    return await AuthService().logOut();
  }
}
