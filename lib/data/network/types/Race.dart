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
    List<RaceDriver> drivers = [
      RaceDriver(id: 1, driver: "Michael Schumacher", place: 1)
    ];
    return Race(
      id: json['id'],
      championship_id: json['championshipId'],
      name: json['name'],
      drivers: drivers,
      date: json['date'],
      finished: json['finished'],
    );
    //List.from(json['drivers'])
    //      .map((model) => RaceDriver.fromJson(Map.from(model)))
    //      .toList(),
  }
}
