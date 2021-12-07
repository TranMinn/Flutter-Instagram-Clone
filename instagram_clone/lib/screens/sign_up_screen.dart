import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/already_have_account_check.dart';
import 'package:instagram_clone/components/input_field.dart';
import 'package:instagram_clone/components/text_field_container.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/services/auth.dart';

import '../color_constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController profileNameController = TextEditingController();

  final AuthService _auth = AuthService();

  bool inputTextNotNull = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height - 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: size.width * 0.15,
                        fontFamily: 'Signatra',
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    InputField(
                      onChanged: (text) {},
                      controller: usernameController,
                      obscureText: false,
                      hintText: 'Email address',
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InputField(
                      onChanged: (text) {},
                      controller: passwordController,
                      obscureText: true,
                      hintText: 'Password',
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InputField(
                      onChanged: (text) {},
                      controller: nameController,
                      obscureText: false,
                      hintText: 'Your name',
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InputField(
                      onChanged: (text) {},
                      controller: profileNameController,
                      obscureText: false,
                      hintText: 'Profile name',
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () async {
                        dynamic result = await _auth.registerWithEmailAndPassword(usernameController.text, passwordController.text);
                        Navigator.pop(context);
                      },
                      child: const TextFieldContainer(
                        color: buttonBgColor,
                        child: Center(
                          child: Text(
                            'Sign Up',
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
                      AlreadyHaveAccountCheck(
                          login: false,
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          }),
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
