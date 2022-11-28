import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marswin/data/network/types/Race.dart';
import 'package:http/http.dart' as http;

class Datafetcher {
  static String url = "https://goapi-aicomyllevillestudent.koyeb.app";

  static Future<List<Race>> getRaces() async {
    try {
      final response = await http.get(
          Uri.parse("https://goapi-aicomyllevillestudent.koyeb.app/races"),
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
}
