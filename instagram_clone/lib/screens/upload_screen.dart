import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:instagram_clone/services/database.dart';

class UploadScreen extends StatefulWidget {
  final File imageFile;
  final String imagePath;
  final String imageFileName;

  const UploadScreen(
      {Key? key,
      required this.imagePath,
      required this.imageFileName,
      required this.imageFile})
      : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final captionController = TextEditingController();
  final locationController = TextEditingController();

  late Position _currentPosition;
  String _currentLatLong = '';

  _getCurrentLocation() async {
    try {
      Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((Position position) {
        setState(() {
          _currentPosition = position;
          _currentLatLong = "${_currentPosition.latitude}, ${_currentPosition.longitude}";
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('New post',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
              await DatabaseService().uploadPhoto(widget.imagePath, widget.imageFileName);
              dynamic url = await DatabaseService().downloadUrl(widget.imageFileName);
              print(url);
              await DatabaseService(uid: currentUser!.uid).updatePostData(currentUser!, url, captionController.text, _currentLatLong);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: Colors.blue,
                size: 40,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(widget.imageFile))),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                  child: TextField(
                    controller: captionController,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Write a caption...',
                    ),
                    onChanged: ((value) {
                      setState(() {
                        captionController.text = value;
                      });
                    }),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: (_currentPosition != null)
                ? Text(
                    "Location: ${_currentLatLong}")
                : Text('Can not define location!'),
          )
        ],
      ),
    );
  }
}
