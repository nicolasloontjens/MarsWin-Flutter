import 'dart:convert';
import 'package:marswin/data/network/types/AuthResponse.dart';
import 'package:marswin/data/network/types/Bet.dart';
import 'package:marswin/data/network/types/BetResponse.dart';
import 'package:marswin/data/network/types/Driver.dart';
import 'package:marswin/data/network/types/LiveRace.dart';
import 'package:marswin/data/network/types/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:marswin/data/network/types/Championship.dart';
import 'package:marswin/data/network/types/Race.dart';
import 'package:http/http.dart' as http;
import 'package:marswin/data/network/types/RaceDriver.dart';

class Datafetcher {
  static String url = "https://go-api-lgafo.ondigitalocean.app/api";

  static Future<List<Race>> getRaces({bool retry = false}) async {
    try {
      final response = await http.get(Uri.parse("$url/races/"), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*"
      }).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        List<Race> races = list.map((model) => Race.fromJson(model)).toList();
        return races;
      } else if (response.statusCode == 400) {
        if (!retry) {
          return getRaces(
              retry:
                  true); //the go api has some issues where it will sometimes return 400 on a request, we don't know why, but retrying fixes it.
        }
      }
      throw Exception("Failed to load races");
    } catch (e) {
      print(e);
      throw Exception("Failed to get races");
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
      throw Exception("Failed to get finished races");
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
      throw Exception("Failed to get planned races");
    }
  }

  static Future<int> getBalance({bool retry = false}) async {
    try {
      final response = await http.get(Uri.parse("$url/user/"), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer " + await getToken()
      }).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        int balance = jsonDecode(response.body)["wallet"];
        return balance;
      } else if (response.statusCode == 400) {
        if (!retry) {
          return getBalance(
              retry:
                  true); //the go api has some issues where it will sometimes return 400 on a request, we don't know why, but retrying fixes it.
        }
      }
      return 0;
    } catch (e) {
      print(e);
      throw Exception('Failed to load balance');
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
      final response = await http
          .post(
            Uri.parse("$url/register"),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode(<String, String>{
              "username": username,
              "password": password,
            }),
          )
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        return await login(username, password);
      }
      if (response.statusCode == 400) {
        return AuthResponse(success: false, error: "Username already taken");
      }
    } catch (e) {
      print(e);
      throw Exception("Failed to register");
    }
    return AuthResponse(
        success: false, error: "Something went wrong registering");
  }

  static Future<AuthResponse> login(String username, String password) async {
    try {
      final response = await http
          .post(Uri.parse("$url/login"),
              headers: {
                "Content-Type": "application/json",
                "Accept": "*/*",
              },
              body: jsonEncode(<String, String>{
                "username": username,
                "password": password,
              }))
          .timeout(Duration(seconds: 5));
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
      throw Exception("Failed to login");
    }
    return AuthResponse(
        success: false, error: "Something went wrong logging in");
  }

  static Future<Championship> getCurrentChampionship(
      {bool retry = false}) async {
    try {
      final response =
          await http.get(Uri.parse("$url/championships/1"), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
      }).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return Championship.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        if (!retry) {
          return getCurrentChampionship(
              retry:
                  true); //the go api has some issues where it will sometimes return 400 on a request, we don't know why, but retrying fixes it.
        }
      }
      return Championship(id: 1, name: "2052 Formula Mars Championship");
    } catch (e) {
      print(e);
      return Championship(id: 1, name: "failed to fetch");
    }
  }

  static Future<User> getUser({bool retry = false}) async {
    try {
      final response = await http.get(Uri.parse("$url/user/"), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer " + await getToken()
      }).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        if (!retry) {
          return getUser(
              retry:
                  true); //the go api has some issues where it will sometimes return 400 on a request, we don't know why, but retrying fixes it.
        }
      }
      return User(id: 0, username: "John Doe", wallet: 100);
    } catch (e) {
      print(e);
      throw Exception("Failed to load user");
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

  static Future<Race> getRaceResults(int id, {bool retry = false}) async {
    try {
      final response = await http.get(Uri.parse('$url/races/$id'), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
      }).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return Race.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        if (!retry) {
          return getRaceResults(id,
              retry:
                  true); //the go api has some issues where it will sometimes return 400 on a request, we don't know why, but retrying fixes it.
        }
      }
      List<RaceDriver> drivers = [
        RaceDriver(id: 1, name: "Michael Schumacher", position: 1, laps: 25)
      ];
      return Race(
          id: 1,
          championship_id: 1,
          name: 'The Martian Loop',
          drivers: drivers,
          date: DateTime.now(),
          finished: true);
    } catch (e) {
      print(e);
      List<RaceDriver> drivers = [
        RaceDriver(id: 1, name: "Michael Schumacher", position: 1, laps: 25)
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

  static Future<bool> updateBalance(String withdraw, int amount,
      {bool retry = false}) async {
    try {
      final response = await http
          .put(Uri.parse("$url/user/"),
              headers: {
                "Content-Type": "application/json",
                "Accept": "*/*",
                "Authorization": "Bearer " + await getToken()
              },
              body: jsonEncode(<String, dynamic>{
                "type": withdraw,
                "wallet": amount,
              }))
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        if (!retry) {
          return updateBalance(withdraw, amount,
              retry:
                  true); //the go api has some issues where it will sometimes return 400 on a request, we don't know why, but retrying fixes it.
        }
      }
      return false;
    } catch (e) {
      print(e);
      throw Exception("Failed to update balance");
    }
  }

  static Future<LiveRace> getLiveRace() async {
    try {
      final response = await http.get(Uri.parse("$url/races/live/"), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer " + await getToken()
      }).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return LiveRace.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        return LiveRace.failed(false);
      }
      return LiveRace.failed(false);
    } catch (e) {
      print(e);
      throw Exception("Failed to get live race");
    }
  }

  static Future<List<BetResponse>> getBets({bool retry = false}) async {
    try {
      final betResponse = await http.get(Uri.parse("$url/bets/"), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer " + await getToken()
      }).timeout(Duration(seconds: 5));
      final driverResponse =
          await http.get(Uri.parse("$url/drivers/"), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer " + await getToken()
      }).timeout(Duration(seconds: 5));
      if (betResponse.statusCode == 200 && driverResponse.statusCode == 200) {
        debugPrint('both requests good!');
        List<dynamic> bets = jsonDecode(betResponse.body)
            .map((bet) => Bet.fromJson(bet))
            .toList();
        List<dynamic> drivers = jsonDecode(driverResponse.body)
            .map((driver) => Driver.fromJson(driver))
            .toList();
        return mergeBetsAndDrivers(bets, drivers);
      } else if (betResponse.statusCode == 400 ||
          driverResponse.statusCode == 400) {
        if (!retry) {
          return getBets(retry: true);
        }
        throw Exception("Failed to load bets");
      }
      throw Exception("Failed to get bets");
    } catch (e) {
      print(e);
      throw Exception("Failed to get bets");
    }
  }

  static List<BetResponse> mergeBetsAndDrivers(
      List<dynamic> bets, List<dynamic> drivers) {
    List<BetResponse> betResponses = [];
    bets.forEach((element) {
      betResponses.add(BetResponse(
          bet: element,
          driver:
              drivers.firstWhere((driver) => driver.id == element.driverId)));
    });
    return betResponses;
  }
}
