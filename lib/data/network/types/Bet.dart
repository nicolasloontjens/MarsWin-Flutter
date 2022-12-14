class Bet {
  final int id;
  final int raceId;
  final int driverId;
  final int amount;

  const Bet(
      {required this.id,
      required this.raceId,
      required this.driverId,
      required this.amount});

  factory Bet.fromJson(Map<String, dynamic> json) {
    return Bet(
        id: json['id'],
        raceId: json['race_id'],
        driverId: json['driver_id'],
        amount: json['amount']);
  }
}
