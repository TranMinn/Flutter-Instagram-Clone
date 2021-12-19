import 'package:flutter/material.dart';
import 'package:instagram_clone/models/User.dart';
import 'package:instagram_clone/view_models/edit_profile_viewModel.dart';

class EditProfileScreen extends StatefulWidget {
  final MyUserData myUserData;
  const EditProfileScreen({Key? key, required this.myUserData})
      : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileViewModel editProfileViewModel = EditProfileViewModel();

  final userNameController = TextEditingController();
  final profileNameController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void initState() {
    super.initState();

    userNameController.text = widget.myUserData.userName!;
    profileNameController.text = widget.myUserData.profileName!;
    bioController.text = widget.myUserData.bio!;
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
              await editProfileViewModel.updateUserData(userNameController.text,
                  profileNameController.text, bioController.text);
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
                          image: widget.myUserData.photoUrl!.isNotEmpty
                              ? NetworkImage(widget.myUserData.photoUrl!)
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
                child: const Padding(
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name',
                  ),
                  controller: userNameController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    labelText: 'Username',
                  ),
                  controller: profileNameController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: TextField(
                  decoration: const InputDecoration(
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
                onPressed: () {
                  editProfileViewModel.updateProfilePhoto();
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
