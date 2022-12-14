import "package:flutter/material.dart";
import 'package:marswin/pages/betOverview.dart';
import 'package:marswin/pages/finishedRaceDetailPage.dart';
import 'package:marswin/pages/liveRaceDetailPage.dart';
import '../pages/login.dart';
import '../pages/register.dart';
import '../pages/home.dart';
import 'package:get_storage/get_storage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final page = getWidget(settings.name);
    return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c));
  }

  static Widget getWidget(String? name) {
    List<String> pathComponents = name!.split('/');
    if (pathComponents.get(1) == 'race') {
      return pathComponents.get(2) != null
          ? FinishedRaceDetailPage(id: int.parse(pathComponents.get(2)!))
          : ErrorPage();
    } else {
      switch (name) {
        case '/login':
          return LoginPage();
        case '/register':
          return RegisterPage();
        case '/home':
          return HomePage();
        case '/races/live':
          return liveRaceDetailPage();
        case '/bets':
          return BetOverview();
        default:
          return ErrorPage();
      }
    }
  }

  //function that protects the widget from being accessed without logging in
  static Widget protectWidget(Widget widget) {
    if (GetStorage().read("loggedin") == 1) {
      return widget;
    }
    return ErrorPage();
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

extension ListGetExtension<T> on List<T> {
  T? get(int index) => index < 0 || index >= this.length ? null : this[index];
}
