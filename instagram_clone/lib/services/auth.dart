import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  Future registerWithEmailAndPassword(String email, String password, String userName, String profileName) async {
    try {

      // Create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // get user back
      User? user = userCredential.user;
      
      // create a new doc for the user
      await DatabaseService(uid: user!.uid).updateUserData(user.uid, email, userName, profileName, '', '');
      
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Login with email & password
  Future logInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Logout
  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
