class EmailPasswordValidation {
  static String validatePassword(String password) {
    if (password == null) {
      return 'Invalid password!';
    }
    if (password.length < 6) {
      return 'Password require minimum 6 characteres';
    }
    return '';
  }

  static String validateEmail(String email) {
    if (email == null) {
      return 'Invalid email!';
    }
    var validEmail = RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(email);
    if (!validEmail) {
      return 'Invalid email!';
    }
    return '';
  }
}
