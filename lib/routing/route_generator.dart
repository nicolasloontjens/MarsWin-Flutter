import "package:flutter/material.dart";
import '../pages/login.dart';
import '../pages/register.dart';
import '../pages/home.dart';
import 'package:get_storage/get_storage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(builder: (_) => ErrorPage());
    }
  }

  static Route<dynamic> protectRoute(Route<dynamic> widget) {
    if (GetStorage().read("loggedin") == 1) {
      return widget;
    }
    return MaterialPageRoute(builder: (_) => ErrorPage());
  }
}

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
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
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset('assets/images/mando-error.png')),
                ),
                Text("This is not the way",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Inter",
                        fontSize: 32,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 30),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 75.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/login');
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
  }
}
