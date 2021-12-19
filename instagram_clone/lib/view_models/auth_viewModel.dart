import 'dart:async';

import 'package:instagram_clone/helper/email_password_validation.dart';
import 'package:instagram_clone/services/auth.dart';

class AuthViewModel {

  final AuthService _auth = AuthService();

  final _emailSubject = StreamController<String>.broadcast();
  final _passwordSubject = StreamController<String>.broadcast();

  Sink<String> get emailSink => _emailSubject;
  Sink<String> get passwordSink => _passwordSubject;

  Stream<String> get emailStream => _emailSubject.stream
      .map((email) => EmailPasswordValidation.validateEmail(email));

  Stream<String> get passwordStream => _passwordSubject.stream
      .map((password) => EmailPasswordValidation.validatePassword(password));

  // Login
  Future loginUser(String email, String password) async {
    return await _auth.logInWithEmailAndPassword(email, password);
  }

  // Sign Up
  Future signUpUser(String username, String password, String userName, String profileName) async {
    return await _auth.registerWithEmailAndPassword(username, password, userName, profileName);
  }

  dispose() {
    _emailSubject.close();
    _passwordSubject.close();
  }
}
