import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/services/user_services.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  // Create User object based on FirebaseUser
  MyUser? _userFromFirebase(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebase(user!));
  }

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password,
      String userName, String profileName) async {
    try {
      // Create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // get user back
      User? user = userCredential.user;

      // create a new doc for the user
      await UserService(uid: user!.uid)
          .updateUserData(user.uid, email, userName, profileName, '', '');

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Login with email & password
  Future logInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Login with Google
  Future logInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await account?.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      final User? user =
          (await _auth.signInWithCredential(authCredential)).user;

      await UserService(uid: user!.uid).updateUserData(
          user.uid,
          account?.email ?? '',
          account?.displayName ?? '',
          account?.displayName ?? '',
          '',
          '');

      return _userFromFirebase(user);
    } catch (e) {
      return e.toString();
    }
  }

  // Login with Facebook
  Future loginWithFacebook() async {

    try {
      final result = await _facebookAuth.login(permissions: ['public_profile','email']);
      // final result = await _facebookLogin.logIn(permissions: [FacebookPermission.email, FacebookPermission.publicProfile]);

      if(result.status == LoginStatus.success) {
        final credential = FacebookAuthProvider.credential(result.accessToken!.token,);
        final User? user = (await _auth.signInWithCredential(credential)).user;

        Map<String, dynamic> map = await _facebookAuth.getUserData(fields: 'name, email, picture.width(200)');

        await UserService(uid: user!.uid).updateUserData(
            user.uid,
            map['email'] ?? '',
            map['name'] ?? '',
            map['name'] ?? '',
            '',
            map['picture']['data']['url']) ?? '';

        return _userFromFirebase(user);
      }
    } catch(e) {
      return e.toString();
    }

  }

  // Logout
  Future logOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await _facebookAuth.logOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
