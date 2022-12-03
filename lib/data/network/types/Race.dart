import 'package:marswin/data/network/types/RaceDriver.dart';

class Race {
  final int id;
  final int championship_id;
  final String name;
  final List<RaceDriver> drivers;
  final String date;
  final bool finished;

  const Race({
    required this.id,
    required this.championship_id,
    required this.name,
    required this.drivers,
    required this.date,
    required this.finished,
  });

  factory Race.fromJson(Map<String, dynamic> json) {
    return Race(
      id: json['id'],
      championship_id: json['championshipId'],
      name: json['name'],
      drivers: List.from(json['drivers'])
          .map((model) => RaceDriver.fromJson(Map.from(model)))
          .toList(),
      date: json['date'],
      finished: json['finished'],
    );
  }
}
