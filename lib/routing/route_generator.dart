import "package:flutter/material.dart";
import 'package:marswin/login.dart';
import 'package:marswin/register.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
        backgroundColor: Color(0xFFF1EBE6),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Image.asset('assets/images/mando-error.jpg'),
                ),
                Text("This is not the way",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Inter",
                        fontSize: 32,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 40),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 75.0),
                    child: GestureDetector(
                      onTap: () {
                        debugPrint("test submit");
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFFE87470),
                            border: Border.all(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                          'Lets get back on track!',
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 16),
                        )),
                      ),
                    )),
              ]),
            ),
          ),
        ));
  });
}
