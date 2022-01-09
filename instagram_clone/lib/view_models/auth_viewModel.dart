import 'dart:async';

import 'package:instagram_clone/helper/email_password_validation.dart';
import 'package:instagram_clone/services/auth.dart';

class AuthViewModel {

  final _emailSubject = StreamController<String>.broadcast();
  final _passwordSubject = StreamController<String>.broadcast();

  Sink<String> get emailSink => _emailSubject;
  Sink<String> get passwordSink => _passwordSubject;

  Stream<String> get emailStream => _emailSubject.stream
      .map((email) => EmailPasswordValidation.validateEmail(email));

  Stream<String> get passwordStream => _passwordSubject.stream
      .map((password) => EmailPasswordValidation.validatePassword(password));

  dispose() {
    _emailSubject.close();
    _passwordSubject.close();
  }
}
