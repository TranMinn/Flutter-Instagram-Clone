import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/color_constants.dart';
import 'package:instagram_clone/components/text_field_container.dart';

class InputField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  const InputField({Key? key, required this.onChanged, required this.hintText, required this.controller, required this.obscureText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
        color: inputFieldBgColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: TextField(
              onChanged: onChanged,
              controller: controller,
              obscureText: obscureText,
              style: TextStyle(
                fontSize: size.width * 0.03,
              ),
              decoration: InputDecoration.collapsed(hintText: hintText),
            ),
          ),
        ),
    );
  }
}
