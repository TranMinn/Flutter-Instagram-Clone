import 'package:flutter/material.dart';
import 'package:instagram_clone/components/already_have_account_check.dart';
import 'package:instagram_clone/components/input_field.dart';
import 'package:instagram_clone/components/text_field_container.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/root_screen.dart';
import 'package:instagram_clone/view_models/auth_viewModel.dart';
import 'package:instagram_clone/view_models/signUp_viewModel.dart';

import '../color_constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthViewModel authViewModel = AuthViewModel();
  SignUpViewModel signUpViewModel = SignUpViewModel();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController profileNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    emailController
        .addListener(() => authViewModel.emailSink.add(emailController.text));
    passwordController.addListener(
        () => authViewModel.passwordSink.add(passwordController.text));
  }

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
                    StreamBuilder<String>(
                        stream: authViewModel.emailStream,
                        builder: (context, snapshot) {
                          return InputField(
                            controller: emailController,
                            obscureText: false,
                            hintText: 'Email address',
                            errorText: snapshot.data ?? '',
                          );
                        }),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    StreamBuilder<String>(
                        stream: authViewModel.passwordStream,
                        builder: (context, snapshot) {
                          return InputField(
                            controller: passwordController,
                            obscureText: true,
                            hintText: 'Password',
                            errorText: snapshot.data ?? '',
                          );
                        }),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InputField(
                      controller: nameController,
                      obscureText: false,
                      hintText: 'Your name',
                      errorText: '',
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InputField(
                      controller: profileNameController,
                      obscureText: false,
                      hintText: 'Profile name',
                      errorText: '',
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () async {
                        dynamic result = await signUpViewModel.signUpUser(
                            emailController.text,
                            passwordController.text,
                            nameController.text,
                            profileNameController.text);
                        if (result != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RootScreen()));
                        }
                        print('Signed Up');
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
