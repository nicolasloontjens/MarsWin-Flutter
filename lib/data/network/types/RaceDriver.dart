import 'package:marswin/data/network/types/Driver.dart';

class RaceDriver extends Driver {
  final int position;
  final int laps;

  RaceDriver(
      {required int id,
      required String name,
      required this.position,
      required this.laps})
      : super(id: id, name: name);

  factory RaceDriver.fromJson(Map<String, dynamic> json) {
    return RaceDriver(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      laps: json['laps'],
    );
  }
}
