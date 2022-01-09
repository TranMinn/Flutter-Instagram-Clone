class MyUser {
  final String? uid;
  MyUser({this.uid});
}

class MyUserData {
  final String? userId;
  final String? email;
  final String? userName;
  final String? profileName;
  final String? bio;
  final String? photoUrl;
  final List? following;
  final List? followers;

  MyUserData(
      {this.profileName,
      this.email,
      this.userName,
      this.bio,
      this.photoUrl,
      this.userId,
      this.following,
      this.followers});
}
