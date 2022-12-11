import "package:flutter/material.dart";
import 'package:marswin/data/network/datafetcher.dart';
import 'package:marswin/data/network/types/Race.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RaceOverviewPage extends StatefulWidget {
  const RaceOverviewPage({Key? key}) : super(key: key);

  @override
  State<RaceOverviewPage> createState() => _RaceOverviewPageState();
}

class _RaceOverviewPageState extends State<RaceOverviewPage> {
  late Future<List<Race>> finishedRaces;
  late Future<List<Race>> plannedRaces;
  final List<bool> isSelected = [true, false];
  bool vertical = false;

  @override
  initState() {
    super.initState();
    finishedRaces = Datafetcher.getFinishedRaces();
    plannedRaces = Datafetcher.getPlannedRaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFF1EBE6)),
        child: Column(
          children: [
            SizedBox(height: 30),
            Text("Race schedule",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Nasalization")),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width * 0.60,
              child: ToggleButtons(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.red[700],
                selectedColor: Colors.white,
                fillColor: Colors.red[400],
                color: Colors.black,
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.29,
                    minHeight: 50),
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
            Expanded(
              child: Column(children: [
                if (isSelected[0]) ...[
                  Expanded(
                    child: FutureBuilder<List<Race>>(
                        future: finishedRaces,
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data);
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black, width: 2)),
                                    child: ListTile(
                                        title: Text(
                                          snapshot.data![index].name,
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Inter'),
                                        ),
                                        onTap: () {
                                          int id = snapshot.data![index].id;
                                          Navigator.pushNamed(
                                              context, '/race/$id');
                                        },
                                        subtitle: Text(
                                            snapshot.data![index].date
                                                .toString(),
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
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              image: const DecorationImage(
                                            fit: BoxFit.fitHeight,
                                            image: AssetImage(
                                                "assets/images/marswin-no-text.png"),
                                          )),
                                        )),
                                  );
                                }));
                          } else {
                            return Center(
                                child: SpinKitWave(
                              color: Colors.black,
                              size: 40,
                              itemCount: 6,
                            ));
                          }
                        })),
                  )
                ] else if (isSelected[1]) ...[
                  Expanded(
                    child: FutureBuilder<List<Race>>(
                        future: plannedRaces,
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data);
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black, width: 2)),
                                    child: ListTile(
                                        title: Text(
                                          snapshot.data![index].name,
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Inter'),
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/races/live');
                                        },
                                        subtitle: Text(
                                            snapshot.data![index].date
                                                .toString(),
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
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              image: const DecorationImage(
                                            fit: BoxFit.fitHeight,
                                            image: AssetImage(
                                                "assets/images/marswin-no-text.png"),
                                          )),
                                        )),
                                  );
                                }));
                          } else {
                            return Center(
                                child: SpinKitWave(
                              color: Colors.black,
                              size: 40,
                              itemCount: 6,
                            ));
                          }
                        })),
                  )
                ]
              ]),
            )
          ],
        ),
      ),
    );
  }
}
