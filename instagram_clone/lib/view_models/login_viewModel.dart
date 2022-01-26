
import 'package:instagram_clone/services/auth.dart';

class LoginViewModel {
  final AuthService _auth = AuthService();

  Future loginUser(String email, String password) async {
    return await _auth.logInWithEmailAndPassword(email, password);
  }

  Future loginWithGoogle() async {
    return await _auth.logInWithGoogle();
  }

  Future loginWithFacebook() async {
    return await _auth.loginWithFacebook();
  }

}