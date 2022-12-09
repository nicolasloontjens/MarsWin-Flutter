import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marswin/data/network/datafetcher.dart';
import 'package:marswin/data/network/types/Championship.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({Key? key}) : super(key: key);

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  late Future<Championship> _championship;

  @override
  void initState() {
    super.initState();
    _championship = Datafetcher.getCurrentChampionship();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Color(0xFFF1EBE6)),
          child: FutureBuilder(
            future: _championship,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 25),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: Expanded(
                            child: Text(snapshot.data!.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter')),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(50),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return SpinKitFadingCircle(
                color: Colors.black,
                size: 50.0,
              );
            },
          ),
        ),
      ),
    );
  }
}
