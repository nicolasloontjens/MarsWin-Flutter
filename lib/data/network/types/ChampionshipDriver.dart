import 'package:marswin/data/network/types/Driver.dart';

class ChampionshipDriver extends Driver {
  final int points;

  ChampionshipDriver(
      {required int id, required String name, required this.points})
      : super(id: id, name: name);

  factory ChampionshipDriver.fromJson(Map<String, dynamic> json) {
    return ChampionshipDriver(
      id: json['id'],
      name: json['name'],
      points: json['points'],
    );
  }
}
