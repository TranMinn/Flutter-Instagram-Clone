import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:image_picker/image_picker.dart';

class ImageProcessing {
  // Firebase Storage
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  // Upload photo to FirebaseStorage
  Future uploadPhoto(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await storage.ref('photoUrl/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  // Download photo URL
  Future<String> downloadUrl(String fileName) async {
    String downloadURL =
        await storage.ref('photoUrl/$fileName').getDownloadURL();
    return downloadURL;
  }

  // Pick Photo from Gallery or Camera
  Future<XFile?> pickPhoto(String action) async {
    var pickedFile;
    action == 'Gallery'
        ? pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery)
        : await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      return pickedFile;
    } else {
      return null;
    }
  }
}
