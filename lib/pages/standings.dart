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
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              FutureBuilder(
                future: _championship,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    snapshot.data!.drivers
                        .sort((a, b) => b.points.compareTo(a.points));
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
                                      fontFamily: 'InterSemiBold')),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.drivers.length,
                                itemBuilder: ((context, index) {
                                  return Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 40),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 0,
                                              spreadRadius: 3.5,
                                              offset: Offset(1, 1),
                                            ),
                                            BoxShadow(
                                              color: Color(0xFFF1EBE6),
                                              blurRadius: 0,
                                              offset: Offset(0, 0),
                                            )
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              child: Row(
                                            children: [
                                              Text(
                                                (index + 1).toString(),
                                                style: TextStyle(
                                                    fontFamily: 'InterSemiBold',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                  snapshot.data!.drivers[index]
                                                      .name,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'InterSemiBold',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20)),
                                            ],
                                          )),
                                          Text(
                                            snapshot.data!.drivers[index].points
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: 'InterSemiBold',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          )
                                        ],
                                      ));
                                }),
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
