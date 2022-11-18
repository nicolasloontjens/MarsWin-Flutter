import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import "routing/route_generator.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Phoenix(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/register",
      onGenerateRoute: RouteGenerator.generateRoute,
    ));
  }
}
