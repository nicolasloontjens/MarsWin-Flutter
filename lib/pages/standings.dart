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
  bool fullscreen = false;

  @override
  void initState() {
    super.initState();
    _championship = Datafetcher.getCurrentChampionship();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Color(0xFFF1EBE6)),
          child: Column(
            children: [
              FutureBuilder(
                future: _championship,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 25),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Text(snapshot.data!.name,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter')),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.drivers.length,
                                itemBuilder: ((context, index) {
                                  return Container(
                                      child: Text(
                                          snapshot.data!.drivers[index].name));
                                }),
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
