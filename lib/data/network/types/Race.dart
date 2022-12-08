import 'package:marswin/data/network/types/RaceDriver.dart';
import 'package:intl/intl.dart';

class Race {
  final int id;
  final int championship_id;
  final String name;
  final List<RaceDriver> drivers;
  final DateTime date;
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
      date: DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(json['date']),
      finished: json['finished'],
    );
    //List.from(json['drivers'])
    //      .map((model) => RaceDriver.fromJson(Map.from(model)))
    //      .toList(),
  }
}
