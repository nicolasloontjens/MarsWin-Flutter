import 'dart:async';

import 'package:carbon_icons/carbon_icons.dart';
import "package:flutter/material.dart";
import 'package:marswin/data/network/datafetcher.dart';
import 'package:marswin/data/network/types/LiveRace.dart';
import 'package:marswin/data/network/types/Race.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class RaceOverviewPage extends StatefulWidget {
  const RaceOverviewPage({Key? key}) : super(key: key);

  @override
  State<RaceOverviewPage> createState() => _RaceOverviewPageState();
}

class _RaceOverviewPageState extends State<RaceOverviewPage> {
  late Future<List<Race>> finishedRaces;
  late Future<List<Race>> plannedRaces;
  late Future<LiveRace> liveRace;
  final List<bool> isSelected = [true, false];
  bool vertical = false;

  @override
  initState() {
    super.initState();
    finishedRaces = Datafetcher.getFinishedRaces();
    plannedRaces = Datafetcher.getPlannedRaces();
    liveRace = Datafetcher.getLiveRace();
    Timer.periodic(
        Duration(seconds: 10),
        (Timer t) => setState(() {
              liveRace = Datafetcher.getLiveRace();
              finishedRaces = Datafetcher.getFinishedRaces();
              plannedRaces = Datafetcher.getPlannedRaces();
            }));
  }

  Future refresh() async {
    setState(() {
      finishedRaces = Datafetcher.getFinishedRaces();
      plannedRaces = Datafetcher.getPlannedRaces();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1EBE6),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Color(0xFFF1EBE6)),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text("Race schedule",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Nasalization")),
              SizedBox(height: 15),
              FutureBuilder<LiveRace>(
                  future: liveRace,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.success) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.50,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
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
                          child: Column(
                            children: [
                              Text(
                                "Currently live!",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFFFF0000)),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "${snapshot.data!.race!.name}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed("/races/live");
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 0,
                                          spreadRadius: 3.5,
                                          offset: Offset(1, 1),
                                        ),
                                        BoxShadow(
                                          color: Color(0xFFE75657),
                                          blurRadius: 0,
                                          offset: Offset(0, 0),
                                        )
                                      ]),
                                  child: Text(
                                    'Check it out!',
                                    style: TextStyle(
                                        letterSpacing: 0.2,
                                        fontSize: 18,
                                        fontFamily: 'Baloo2',
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.70,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
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
                          child: Column(
                            children: [
                              Text(
                                "Currently no live race, \nwhy don't you look around for a bit?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              GestureDetector(
                                onTap: () async {
                                  int raceId =
                                      await Datafetcher.getRandomRaceId();
                                  Navigator.of(context)
                                      .pushNamed("/race/${raceId}");
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 0,
                                          spreadRadius: 3.5,
                                          offset: Offset(1, 1),
                                        ),
                                        BoxShadow(
                                          color: Color(0xFFE75657),
                                          blurRadius: 0,
                                          offset: Offset(0, 0),
                                        )
                                      ]),
                                  child: Text(
                                    'Take me to a random race!',
                                    style: TextStyle(
                                        letterSpacing: 0.2,
                                        fontSize: 18,
                                        fontFamily: 'Baloo2',
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    }
                    return Container();
                  })),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width * 0.60,
                child: Center(
                  child: ToggleButtons(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.red[400],
                    borderWidth: 2,
                    borderColor: Colors.black,
                    color: Colors.black,
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.20,
                        minHeight: 35),
                    direction: vertical ? Axis.vertical : Axis.horizontal,
                    isSelected: isSelected,
                    onPressed: ((index) {
                      setState(() {
                        for (int i = 0; i < isSelected.length; i++) {
                          isSelected[i] = i == index;
                        }
                      });
                    }),
                    children: [
                      Text(
                        'Finished',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Nasalization"),
                      ),
                      Text('Planned',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Nasalization"))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Column(children: [
                if (isSelected[0]) ...[
                  FutureBuilder<List<Race>>(
                      future: finishedRaces,
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return RefreshIndicator(
                            color: Color(0xFFE75657),
                            onRefresh: () async {
                              await refresh();
                            },
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: ((context, index) {
                                  snapshot.data!
                                      .sort((a, b) => b.date.compareTo(a.date));
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 45, vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
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
                                    child: ListTile(
                                        title: Text(
                                          snapshot.data![index].name,
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'InterSemiBold'),
                                        ),
                                        onTap: () {
                                          int id = snapshot.data![index].id;
                                          Navigator.pushNamed(
                                              context, '/race/$id');
                                        },
                                        subtitle: Text(
                                            "${DateFormat('yyyy-MM-dd – kk:mm').format(snapshot.data![index].date)} \nView results",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w400)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.5)),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        leading: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              image: const DecorationImage(
                                            fit: BoxFit.fitHeight,
                                            image: AssetImage(
                                                "assets/images/marswin-no-text.png"),
                                          )),
                                        )),
                                  );
                                })),
                          );
                        } else {
                          return Center(
                              child: SpinKitWave(
                            color: Colors.black,
                            size: 40,
                            itemCount: 6,
                          ));
                        }
                      })),
                ] else if (isSelected[1]) ...[
                  FutureBuilder<List<Race>>(
                      future: plannedRaces,
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return RefreshIndicator(
                            color: Color(0xFFE75657),
                            onRefresh: () async {
                              await refresh();
                            },
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: ((context, index) {
                                  snapshot.data!
                                      .sort((a, b) => a.date.compareTo(b.date));
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 45, vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
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
                                    child: ListTile(
                                        title: Text(
                                          snapshot.data![index].name,
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'InterSemiBold'),
                                        ),
                                        subtitle: Text(
                                            DateFormat('yyyy-MM-dd – kk:mm')
                                                .format(
                                                    snapshot.data![index].date),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w400)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.5)),
                                        contentPadding: EdgeInsets.all(0.5),
                                        leading: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              image: const DecorationImage(
                                            fit: BoxFit.fitHeight,
                                            image: AssetImage(
                                                "assets/images/marswin-no-text.png"),
                                          )),
                                        )),
                                  );
                                })),
                          );
                        } else {
                          return Center(
                              child: SpinKitWave(
                            color: Colors.black,
                            size: 40,
                            itemCount: 6,
                          ));
                        }
                      })),
                ]
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
