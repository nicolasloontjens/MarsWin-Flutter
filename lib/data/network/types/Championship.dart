import 'package:marswin/data/network/types/Race.dart';
import 'package:marswin/data/network/types/RaceDriver.dart';

class Championship {
  final int id;
  final String name;

  const Championship({required this.id, required this.name});

  factory Championship.fromJson(Map<String, dynamic> json) {
    return Championship(id: json['id'], name: json['name']);
    //races: List.from(json['races'])
    //    .map((model) => Race.fromJson(Map.from(model)))
    //    .toList());
  }
}
