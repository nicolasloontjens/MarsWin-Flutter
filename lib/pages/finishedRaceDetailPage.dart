import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marswin/data/network/datafetcher.dart';
import 'package:marswin/data/network/types/Race.dart';

class FinishedRaceDetailPage extends StatefulWidget {
  final int id;
  const FinishedRaceDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _FinishedRaceDetailPageState createState() => _FinishedRaceDetailPageState();
}

class _FinishedRaceDetailPageState extends State<FinishedRaceDetailPage> {
  late Future<Race> _race;

  @override
  void initState() {
    super.initState();
    _race = Datafetcher.getRaceResults(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          decoration: BoxDecoration(color: Color(0xFFF1EBE6)),
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: _race,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  Text(snapshot.data!.name),
                ]);
              }
              return Center(
                  child: SpinKitWave(
                color: Colors.black,
                size: 40,
                itemCount: 6,
              ));
            },
          )),
    ));
  }
}
