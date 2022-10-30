import "package:flutter/material.dart";

class LoginPage extends StatefulWidget{
  const LoginPage({Key?key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF1EBE6),
      body: SafeArea(child:
      Center(
        child: Column(children:[
          //logo
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Image.asset('assets/images/onboarding-logo.png', height: 300, width: 300),
          ),
          //title login
          SizedBox(height: 10),
          Text("Hello again!", style: TextStyle(fontFamily: "Inter", fontSize: 18, fontWeight: FontWeight.w500)),
          SizedBox(height: 20),
          //input username
          FractionallySizedBox(
            widthFactor: 0.7,
            child: TextField(decoration:
              InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0)
                ),
                hintText: "Username:",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500
                )
              )
            ),
          )
          //input password
          //dont have an account yet?

        ]),
      )
      )
    );
  }
}