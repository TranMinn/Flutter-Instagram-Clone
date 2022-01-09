import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/screens/upload_image_screen.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text(
        "Instagram",
        style: TextStyle(
            fontFamily: 'Signatra', fontSize: 33, color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return UploadImageScreen();
                },
              ),
            );
          },
          child: SvgPicture.asset(
            "assets/icons/upload_icon.svg",
            width: 26,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            "assets/icons/messenger_icon.svg",
            width: 26,
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
