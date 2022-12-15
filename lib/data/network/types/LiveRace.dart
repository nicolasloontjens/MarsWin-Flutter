import 'package:marswin/data/network/types/Race.dart';

class LiveRace {
  bool success;
  int? id;
  Race? race;
  String? url;

  LiveRace(this.id, this.race, this.url, this.success);
  LiveRace.failed(this.success)
      : id = null,
        race = null,
        url = null;

  factory LiveRace.fromJson(Map<String, dynamic> json) {
    LiveRace race =
        LiveRace(json['id'], Race.fromJson(json['race']), json['url'], true);
    race.race!.drivers.sort((a, b) => b.laps - a.laps);
    return race;
  }
}
