class Race {
  final int id;
  final int championship_id;
  final String name;
  final String date;
  final bool finished;

  const Race({
    required this.id,
    required this.championship_id,
    required this.name,
    required this.date,
    required this.finished,
  });

  factory Race.fromJson(Map<String, dynamic> json) {
    return Race(
      id: json['id'],
      championship_id: json['championshipId'],
      name: json['name'],
      date: json['date'],
      finished: json['finished'],
    );
  }
}
