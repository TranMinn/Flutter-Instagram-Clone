import 'package:flutter/material.dart';
import 'package:instagram_clone/color_constants.dart';
import 'package:instagram_clone/components/already_have_account_check.dart';
import 'package:instagram_clone/components/input_field.dart';
import 'package:instagram_clone/components/text_field_container.dart';
import 'package:instagram_clone/screens/sign_up_screen.dart';
import 'package:instagram_clone/view_models/auth_viewModel.dart';
import 'package:instagram_clone/view_models/login_viewModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthViewModel authViewModel = AuthViewModel();
  LoginViewModel loginViewModel = LoginViewModel();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    emailController
        .addListener(() => authViewModel.emailSink.add(emailController.text));
    passwordController.addListener(
        () => authViewModel.passwordSink.add(passwordController.text));
  }

  // final AuthService _auth = AuthService();

  String dropdownValue = 'English (United Kingdom)';
  List listItems = ['English (United Kingdom)', 'Vietnamese', 'French'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height - 30,
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
                    StreamBuilder<String>(
                        stream: authViewModel.emailStream,
                        builder: (context, snapshot) {

                            return InputField(
                              controller: emailController,
                              obscureText: false,
                              hintText: 'Phone number , email or username',
                              errorText: snapshot.data??'',
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
                            errorText: snapshot.data??'',
                          );
                        }),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await loginViewModel.loginUser(
                            emailController.text, passwordController.text);
                        print('Logged in');
                      },
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
                      AlreadyHaveAccountCheck(
                          login: true,
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUpScreen();
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
