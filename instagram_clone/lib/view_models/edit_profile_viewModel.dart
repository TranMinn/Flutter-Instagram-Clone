
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/helper/image_processing.dart';
import 'package:instagram_clone/services/user_services.dart';

class EditProfileViewModel {

  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  Future<String> getProfilePhotoUrl() async {
    XFile? pickedFile = await ImageProcessing().pickPhoto('Gallery');
    final filePath = pickedFile?.path;
    final fileName = pickedFile?.name;

    await ImageProcessing().uploadPhoto(filePath!, fileName!);

    String photoUrl = await ImageProcessing().downloadUrl(fileName);
    return photoUrl;
  }

  // Update User Profile info
  Future updateUserData(String userName, String profileName, String bio, String photoUrl) async {

    await UserService(uid: currentUserId).updateUserProfile(userName, profileName, bio, photoUrl);
  }

}