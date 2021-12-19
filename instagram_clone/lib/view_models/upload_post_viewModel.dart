import 'package:instagram_clone/helper/image_processing.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/services/post_services.dart';

class UploadPostViewModel {
  Future uploadPost(MyUserData myUserData, String filePath, String fileName,
      String caption) async {
    await ImageProcessing().uploadPhoto(filePath, fileName);
    print('Image uploaded');
    dynamic postPhotoUrl = await ImageProcessing().downloadUrl(fileName);
    print(postPhotoUrl);
    await PostService()
        .updatePostData(myUserData, postPhotoUrl, caption, 'location');
  }
}
