import 'package:flutter/material.dart';
import 'package:instagram_clone/color_constants.dart';

class BlueButton extends StatelessWidget {
  final Widget child;
  const BlueButton({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.08,
      decoration: const BoxDecoration(
        color: inputFieldBgColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: child,
    );
  }
}
