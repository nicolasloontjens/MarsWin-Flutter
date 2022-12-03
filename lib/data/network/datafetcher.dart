import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marswin/data/network/types/Championship.dart';
import 'package:marswin/data/network/types/Race.dart';
import 'package:http/http.dart' as http;

class Datafetcher {
  static String url = "https://goapi-aicomyllevillestudent.koyeb.app";

  static Future<List<Race>> getRaces() async {
    try {
      final response = await http.get(
          Uri.parse("https://goapi-aicomyllevillestudent.koyeb.app/api/races/"),
          headers: {
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
        List<Race> races = [
          Race(
              name: "Martian Loop",
              id: 1,
              championship_id: 1,
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
}
