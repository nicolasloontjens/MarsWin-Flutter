import 'package:marswin/data/network/types/Race.dart';
import 'package:marswin/data/network/types/RaceDriver.dart';

class Championship {
  final int id;
  final String name;
  List<RaceDriver> drivers;

  Championship({required this.id, required this.name, this.drivers = const []});

  factory Championship.fromJson(Map<String, dynamic> json) {
    return Championship(
      id: json['id'],
      name: json['name'],
      drivers: List.from(json['drivers'])
          .map((model) => RaceDriver.fromJson(Map.from(model)))
          .toList(),
    );
  }
}
