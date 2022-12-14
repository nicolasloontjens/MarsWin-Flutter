import 'package:marswin/data/network/types/RaceDriver.dart';
import 'package:intl/intl.dart';

class Race {
  final int id;
  final int championship_id;
  final String name;
  List<RaceDriver> drivers;
  final DateTime date;
  final bool finished;

  Race({
    required this.id,
    required this.championship_id,
    required this.name,
    this.drivers = const [],
    required this.date,
    required this.finished,
  });

  factory Race.fromJson(Map<String, dynamic> json) {
    if (json['drivers'] != null) {
      Race race = Race(
        id: json['id'],
        championship_id: json['championship_id'],
        name: json['name'],
        drivers: List.from(json['drivers'])
            .map((model) => RaceDriver.fromJson(Map.from(model)))
            .toList(),
        date: DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(json['date']),
        finished: json['finished'],
      );
      race.drivers.sort((a, b) => b.position - a.position);
      return race;
    }
    return Race(
      id: json['id'],
      championship_id: json['championship_id'],
      name: json['name'],
      date: DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(json['date']),
      finished: json['finished'],
    );
  }
}
