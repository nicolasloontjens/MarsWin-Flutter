import "package:flutter/material.dart";
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:marswin/data/network/datafetcher.dart';
import 'package:marswin/data/network/types/AuthResponse.dart';
import 'package:marswin/pages/generalElements.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future _loginUser(BuildContext context) async {
    AuthResponse response = await Datafetcher.login(
        _usernameController.text, _passwordController.text);
    if (response.success) {
      Navigator.of(context).pushNamed("/home");
    } else {
      showToast(
        response.error,
        context: context,
        position: StyledToastPosition.top,
        animation: StyledToastAnimation.slideFromTopFade,
        reverseAnimation: StyledToastAnimation.fade,
        alignment: Alignment.bottomCenter,
        backgroundColor: Colors.redAccent,
        shapeBorder: ShapeBorder.lerp(
            Border(
              top: BorderSide(color: Colors.black, width: 2.0),
              left: BorderSide(color: Colors.black, width: 2.0),
              right: BorderSide(color: Colors.black, width: 3.0),
              bottom: BorderSide(color: Colors.black, width: 3.0),
            ),
            Border(
              top: BorderSide(color: Colors.black, width: 2.0),
              left: BorderSide(color: Colors.black, width: 2.0),
              right: BorderSide(color: Colors.black, width: 3.0),
              bottom: BorderSide(color: Colors.black, width: 3.0),
            ),
            0.5),
        duration: Duration(seconds: 3),
      );
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1EBE6),
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              //logo
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Image.asset('assets/images/onboarding-logo.png',
                    height: 250, width: 250),
              ),
              //title login
              SizedBox(height: 10),
              //input username
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0)),
                        hintText: "Username",
                        hintStyle: TextStyle(fontWeight: FontWeight.w500))),
              ),
              SizedBox(height: 15),
              //input password
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0)),
                        hintText: "Password",
                        hintStyle: TextStyle(fontWeight: FontWeight.w500)),
                  )),
              SizedBox(height: 20),
              //submit
              GeneralElements.getActionButton("Sign in", () async {
                await _loginUser(context);
              }, context, width: 0.70),
              SizedBox(height: 15),
              //register text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/register');
                        },
                        child: Text(
                          "Register Now!",
                          style: TextStyle(
                              color: Color(0xFFF26267),
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ))
                  ],
                ),
              )
            ]),
          ),
        )));
  }
}
