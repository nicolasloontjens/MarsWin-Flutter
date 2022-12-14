import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marswin/data/network/datafetcher.dart';
import 'package:marswin/data/network/types/Bet.dart';

class BetOverview extends StatefulWidget {
  @override
  _BetOverviewState createState() => _BetOverviewState();
}

class _BetOverviewState extends State<BetOverview> {
  late Future<List<Bet>> bets;

  @override
  void initState() {
    super.initState();
    bets = Datafetcher.getBets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: FutureBuilder<List<Bet>>(
        future: bets,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].raceId.toString()),
                  subtitle: Text(snapshot.data![index].driverId.toString()),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    ));
  }
}
