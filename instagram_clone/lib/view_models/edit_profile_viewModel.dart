
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/helper/image_processing.dart';
import 'package:instagram_clone/services/user_services.dart';

class EditProfileViewModel {

  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  Future updateProfilePhoto() async {
    XFile? pickedFile = await ImageProcessing().pickPhoto('Gallery');
    final filePath = pickedFile?.path;
    final fileName = pickedFile?.name;

    await ImageProcessing().uploadPhoto(filePath!, fileName!);

    dynamic photoUrl = await ImageProcessing().downloadUrl(fileName);
    print(photoUrl);

    await UserService(uid: currentUserId).updatePhoto(photoUrl);
  }

  // Update User Profile info
  Future updateUserData(String userName, String profileName, String bio) async {
    await UserService(uid: currentUserId).updateUserProfile(userName, profileName, bio);
  }

}