class User {
  final int id;
  final String username;
  final int wallet;

  const User({
    required this.id,
    required this.username,
    required this.wallet,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['ID'],
      username: json['username'],
      wallet: json['wallet'],
    );
  }
}
