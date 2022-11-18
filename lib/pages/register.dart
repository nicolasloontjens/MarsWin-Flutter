import "package:flutter/material.dart";
import "../routing/route_generator.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void register() {
    debugPrint(_usernameController.text);
    debugPrint(_passwordController.text);
    Navigator.of(context).pushNamed('/home');
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
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 75.0),
                  child: GestureDetector(
                    onTap: () {
                      register();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFFE87470),
                          border: Border.all(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        'Create an account!',
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16),
                      )),
                    ),
                  )),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/login');
                        },
                        child: Text(
                          "Log In!",
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
