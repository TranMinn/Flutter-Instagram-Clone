import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/services/database.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final String photoUrl, bio, username, name;
  const EditProfileScreen(
      {Key? key,
      required this.photoUrl,
      required this.bio,
      required this.username,
      required this.name})
      : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController.text = widget.name;
    usernameController.text = widget.username;
    bioController.text = widget.bio;
  }

  late File _imageFile;
  late String _imageFileName;
  late String _imagePath;

  Future _pickPhoto() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFileName = pickedFile.name;
        _imagePath = pickedFile.path;
        _imageFile = File(_imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:
            const Text('Edit Profile', style: TextStyle(color: Colors.black)),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.close,
            color: Colors.black,
            size: 40,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              // Update here
              await DatabaseService(uid: currentUserId).updateUserProfile(
                  usernameController.text,
                  nameController.text,
                  bioController.text);
              print('Updated');
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.done,
                color: Colors.blue,
                size: 40,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _showImageDialog,
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        image: DecorationImage(
                          image: widget.photoUrl.isNotEmpty
                              ? NetworkImage(widget.photoUrl)
                              : AssetImage(
                                      'assets/icons/default_profile_image.jpg')
                                  as ImageProvider,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _showImageDialog,
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Change profile photo',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name',
                  ),
                  controller: nameController,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    labelText: 'Username',
                  ),
                  controller: usernameController,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Bio',
                    labelText: 'Bio',
                  ),
                  controller: bioController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _showImageDialog() {
    return showDialog(
        context: context,
        builder: ((context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                child: Text('New Profile Photo'),
                onPressed: () async {
                  await _pickPhoto();
                  await DatabaseService().uploadPhoto(_imagePath, _imageFileName);
                  print(_imageFileName);
                  dynamic url = await DatabaseService().downloadUrl(_imageFileName);
                  print(url);
                  await DatabaseService(uid: currentUserId).updatePhoto(url);
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text('Import From Facebook'),
                onPressed: () {},
              ),
            ],
          );
        }));
  }
}
