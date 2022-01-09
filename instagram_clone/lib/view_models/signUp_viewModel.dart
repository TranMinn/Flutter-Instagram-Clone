
import 'package:instagram_clone/services/auth.dart';

class SignUpViewModel {
  final AuthService _auth = AuthService();

  Future signUpUser(String username, String password, String userName, String profileName) async {
    return await _auth.registerWithEmailAndPassword(username, password, userName, profileName);
  }

}