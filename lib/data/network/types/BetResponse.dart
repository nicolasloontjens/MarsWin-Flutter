import 'package:marswin/data/network/types/Bet.dart';
import 'package:marswin/data/network/types/Driver.dart';

class BetResponse {
  //no multiple inheritance in dart, :(
  final Driver driver;
  final Bet bet;

  const BetResponse({required this.driver, required this.bet});
}
