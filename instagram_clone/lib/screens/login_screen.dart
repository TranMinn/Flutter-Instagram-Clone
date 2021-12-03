import 'package:flutter/material.dart';
import 'package:instagram_clone/color_constants.dart';
import 'package:instagram_clone/components/already_have_account_check.dart';
import 'package:instagram_clone/components/input_field.dart';
import 'package:instagram_clone/components/text_field_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String dropdownValue = 'English (United Kingdom)';
  List listItems = ['English (United Kingdom)', 'Vietnamese', 'French'];

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool inputTextNotNull = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height - 60,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: size.width,
                  alignment: Alignment.topCenter,
                  child: DropdownButton<String>(
                    icon: const Icon(Icons.arrow_drop_down, size: 24),
                    elevation: 10,
                    style: const TextStyle(color: Colors.black54),
                    value: dropdownValue,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: listItems.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Instagram',
                      style: TextStyle(
                        fontSize: size.width * 0.15,
                        fontFamily: 'Signatra',
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    InputField(
                      onChanged: (text) {
                        setState(() {
                          if (usernameController.text.length >= 2 &&
                              passwordController.text.length >= 2) {
                            inputTextNotNull = true;
                          } else {
                            inputTextNotNull = false;
                          }
                        });
                      },
                      controller: usernameController,
                      obscureText: false,
                      hintText: 'Phone number , email or username',
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InputField(
                      onChanged: (text) {
                        setState(() {
                          if (usernameController.text.length >= 2 &&
                              passwordController.text.length >= 2) {
                            inputTextNotNull = true;
                          } else {
                            inputTextNotNull = false;
                          }
                        });
                      },
                      controller: passwordController,
                      obscureText: true,
                      hintText: 'Password',
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const TextFieldContainer(
                        color: buttonBgColor,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Forgot your login details?',
                          style: TextStyle(
                              fontSize: size.width * 0.03,
                              color: primaryTextColor),
                        ),
                        Text(
                          ' Get help',
                          style: TextStyle(
                            fontSize: size.width * 0.03,
                            fontWeight: FontWeight.bold,
                            color: highlightText,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: size.width * 0.4,
                          color: primaryTextColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'OR',
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: primaryTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 1,
                          width: size.width * 0.4,
                          color: primaryTextColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const TextFieldContainer(
                        color: buttonBgColor,
                        child: Center(
                          child: Text(
                            'Login with Facebook',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width,
                        height: 1,
                        color: primaryTextColor,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      AlreadyHaveAccountCheck(login: true, press: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
