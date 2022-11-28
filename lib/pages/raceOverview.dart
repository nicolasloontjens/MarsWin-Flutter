import "package:flutter/material.dart";
import 'package:marswin/data/network/datafetcher.dart';
import 'package:marswin/data/network/types/Race.dart';

class RaceOverviewPage extends StatefulWidget {
  const RaceOverviewPage({Key? key}) : super(key: key);

  @override
  State<RaceOverviewPage> createState() => _RaceOverviewPageState();
}

class _RaceOverviewPageState extends State<RaceOverviewPage> {
  late Future<List<Race>> races;

  @override
  initState() {
    super.initState();
    races = Datafetcher.getRaces();
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
            FutureBuilder<List<Race>>(
                future: races,
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
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            child: ListTile(
                                title: Text(
                                  snapshot.data![index].name,
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter'),
                                ),
                                subtitle: Text(snapshot.data![index].date,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w400)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.5)),
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
                    return CircularProgressIndicator();
                  }
                }))
          ],
        ),
      ),
    );
  }
}
