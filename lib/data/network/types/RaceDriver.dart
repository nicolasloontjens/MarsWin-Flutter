class RaceDriver {
  final int id;
  final String driver;
  final int place;

  const RaceDriver(
      {required this.id, required this.driver, required this.place});

  factory RaceDriver.fromJson(Map<String, dynamic> json) {
    return RaceDriver(
      id: json['id'],
      driver: json['driver'],
      place: json['place'],
    );
  }
}
