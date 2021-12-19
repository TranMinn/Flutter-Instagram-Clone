
import 'package:flutter/material.dart';
import 'package:instagram_clone/color_constants.dart';
import 'package:instagram_clone/components/text_field_container.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final String errorText;
  final TextEditingController controller;
  final bool obscureText;
  const InputField({Key? key, required this.hintText, required this.controller, required this.obscureText, required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
        color: inputFieldBgColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: TextStyle(
                fontSize: size.width * 0.03,
              ),
              decoration: InputDecoration(hintText: hintText, errorText: errorText, border: InputBorder.none),

              //InputDecoration.collapsed()
            ),
          ),
        ),
    );
  }
}
