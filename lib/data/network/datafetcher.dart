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
      final response = await http.get(Uri.parse("$url/races/"),
          headers: {"Content-Type": "application/json", "Accept": "*/*"});
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        List<Race> races = list.map((model) => Race.fromJson(model)).toList();
        return races;
      } else {
        throw Exception("Failed to load races");
      }
    } catch (e) {
      print(e);
      throw Exception("failed");
    }
  }

  static Future<List<Race>> getFinishedRaces() async {
    try {
      List<Race> races = await getRaces();
      races.retainWhere((element) {
        return element.date
            .isBefore(DateTime(2052, DateTime.now().month, DateTime.now().day));
      });
      return races;
    } catch (e) {
      print(e);
      throw Exception("failed");
    }
  }

  static Future<List<Race>> getPlannedRaces() async {
    try {
      List<Race> races = await getRaces();
      races.retainWhere((element) {
        return element.date
            .isAfter(DateTime(2052, DateTime.now().month, DateTime.now().day));
      });
      return races;
    } catch (e) {
      print(e);
      throw Exception("failed");
    }
  }

  static Future<int> getBalance() async {
    try {
      final response = await http.get(Uri.parse("$url/user/"), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer " + await getToken()
      });
      if (response.statusCode == 200) {
        int balance = jsonDecode(response.body)["wallet"];
        debugPrint(balance.toString());
        return balance;
      }
      return 0;
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

  static Future<Championship> getCurrentChampionship() async {
    try {
      final response =
          await http.get(Uri.parse("$url/championships/1"), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
      });
      if (response.statusCode == 200) {
        return Championship.fromJson(jsonDecode(response.body));
      }
      return Championship(id: 1, name: "2052 Formula Mars Championship");
    } catch (e) {
      print(e);
      return Championship(id: 1, name: "2052 Formula Mars Championship");
    }
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

  static Future<Race> getRaceResults(int id) async {
    try {
      final response = await http.get(Uri.parse('$url/races/$id/'), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
      });
      if (response.statusCode == 200) {
        return Race.fromJson(jsonDecode(response.body));
      }
      List<RaceDriver> drivers = [
        RaceDriver(id: 1, driver: "Michael Schumacher", place: 1)
      ];
      return Race(
          id: 1,
          championship_id: 1,
          name: 'the martian loop',
          drivers: drivers,
          date: DateTime.now(),
          finished: true);
    } catch (e) {
      print(e);
      List<RaceDriver> drivers = [
        RaceDriver(id: 1, driver: "Michael Schumacher", place: 1)
      ];
      return Race(
          id: 1,
          championship_id: 1,
          name: 'the martian loop',
          drivers: drivers,
          date: DateTime.now(),
          finished: true);
    }
  }
}
