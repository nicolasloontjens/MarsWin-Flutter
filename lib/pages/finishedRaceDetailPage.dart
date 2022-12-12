import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marswin/data/network/datafetcher.dart';
import 'package:marswin/data/network/types/Race.dart';
import 'package:intl/intl.dart';

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
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFFE87470),
          title: Text('Race Results:',
              style: TextStyle(
                  fontFamily: 'Nasalization',
                  fontSize: 24,
                  fontWeight: FontWeight.w400)),
          automaticallyImplyLeading: false,
          leadingWidth: 100,
          leading: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(CarbonIcons.undo),
            label: Text('', style: TextStyle(fontFamily: 'Inter')),
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
                textStyle: TextStyle(
                    fontFamily: 'Nasalization',
                    fontSize: 32,
                    fontWeight: FontWeight.w500),
                animationDuration: Duration(milliseconds: 0)),
          ),
        ),
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(color: Color(0xFFF1EBE6)),
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: _race,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: [
                      Text(
                        snapshot.data!.name,
                        style: TextStyle(
                            fontFamily: 'Nasalization',
                            fontSize: 32,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 12),
                      Text(
                        DateFormat('yyyy-MM-dd – kk:mm')
                            .format(snapshot.data!.date),
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.drivers.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Text(
                                snapshot.data!.drivers[index].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Inter',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          },
                        ),
                      )
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
