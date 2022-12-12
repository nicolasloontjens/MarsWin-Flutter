class RaceDriver {
  final int id;
  final String name;

  const RaceDriver({required this.id, required this.name});

  factory RaceDriver.fromJson(Map<String, dynamic> json) {
    return RaceDriver(
      id: json['id'],
      name: json['name'],
    );
  }
}
