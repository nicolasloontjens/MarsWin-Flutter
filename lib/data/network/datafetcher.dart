import 'dart:convert';
import 'package:marswin/data/network/types/AuthResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:marswin/data/network/types/Championship.dart';
import 'package:marswin/data/network/types/Race.dart';
import 'package:http/http.dart' as http;
import 'package:marswin/data/network/types/RaceDriver.dart';

class Datafetcher {
  static String url = "https://go-api-lgafo.ondigitalocean.app/api";

  static Future<List<Race>> getRaces() async {
    try {
      final response = await http.get(Uri.parse("$url/races/"), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRob3JpemVkIjp0cnVlLCJ1c2VyX2lkIjoyfQ.qIgRASSAdFCWz2dPCgh1MOwlIeabuJWg68MuyIhsClQ"
      });
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        List<Race> races = list.map((model) => Race.fromJson(model)).toList();
        return races;
      } else {
        await Future.delayed(Duration(seconds: 1));
        List<RaceDriver> drivers = [
          RaceDriver(id: 1, driver: "Michael Schumacher", place: 1)
        ];
        List<Race> races = [
          Race(
              name: "Martian Loop",
              id: 1,
              championship_id: 1,
              drivers: drivers,
              finished: false,
              date: "2052-03-12 00:00:00+00")
        ];
        return races;
        //throw Exception("Failed to load races");
      }
    } catch (e) {
      print(e);
      throw Exception("failed");
    }
  }

  static Future<int> getBalance() async {
    try {
      //final response = await http.get(
      //    Uri.parse(
      //        "https://goapi-aicomyllevillestudent.koyeb.app/api/balance/"),
      //    headers: {
      //      "Content-Type": "application/json",
      //      "Accept": "*/*",
      //      "Authorization": ""
      //    });
      //if (response.statusCode == 200) {
      //  return 1000;
      //} else {
      //  return 1000;
      //}
      await Future.delayed(Duration(seconds: 1));
      return 420;
    } catch (e) {
      print(e);
      throw Exception("failed");
    }
  }

  static Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = await prefs.getInt("isLoggedIn");
      if (isLoggedIn != null || isLoggedIn == 0) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<AuthResponse> register(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$url/register"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, String>{
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return await login(username, password);
      }
      if (response.statusCode == 400) {
        return AuthResponse(success: false, error: "Username already taken");
      }
    } catch (e) {
      print(e);
      throw Exception("failed");
    }
    return AuthResponse(
        success: false, error: "Something went wrong registering");
  }

  static Future<AuthResponse> login(String username, String password) async {
    try {
      final response = await http.post(Uri.parse("$url/login"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
          },
          body: jsonEncode(<String, String>{
            "username": username,
            "password": password,
          }));

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt("isLoggedIn", 1);
        await prefs.setString("token", jsonDecode(response.body)["token"]);
        return AuthResponse(success: true, error: "");
      }
      if (response.statusCode == 400) {
        return AuthResponse(success: false, error: "Invalid credentials");
      }
    } catch (e) {
      print(e);
      throw Exception("failed");
    }
    return AuthResponse(
        success: false, error: "Something went wrong logging in");
  }

  static Future<String> getUsername() async {
    try {
      final response = await http.get(Uri.parse("$url/user/"), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer " + await getToken()
      });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["username"];
      }
      return "";
    } catch (e) {
      print(e);
      throw Exception("failed");
    }
  }

  static Future<String> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = await prefs.getString("token").toString();
      return token;
    } catch (e) {
      print(e);
      throw Exception("failed");
    }
  }
}
