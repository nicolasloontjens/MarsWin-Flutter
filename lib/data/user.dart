import 'package:get_storage/get_storage.dart';
import "package:flutter/material.dart";
import 'package:flutter_phoenix/flutter_phoenix.dart';

void registerUser(context, username, password) {
  GetStorage().write("loggedin", 1);
  Navigator.of(context).pushNamed('/home');
}

void loginUser(context, username, password) {
  GetStorage().write("loggedin", 1);
  Navigator.of(context).pushNamed('/home');
}

void logoutUser(context) {
  GetStorage().write("loggedin", 0);
  Phoenix.rebirth(context);
}
