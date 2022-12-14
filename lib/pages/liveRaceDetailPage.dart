import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:marswin/data/network/datafetcher.dart';
import 'package:marswin/data/network/types/LiveRace.dart';
import 'package:marswin/data/network/types/RaceDriver.dart';

class liveRaceDetailPage extends StatefulWidget {
  const liveRaceDetailPage({Key? key}) : super(key: key);

  @override
  _liveRaceDetailPageState createState() => _liveRaceDetailPageState();
}

class _liveRaceDetailPageState extends State<liveRaceDetailPage> {
  late Future<LiveRace> liveRace;
  final List<bool> isSelected = [true, false];
  bool vertical = false;

  @override
  void initState() {
    super.initState();
    liveRace = Datafetcher.getLiveRace();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFE87470),
        title: Text('Live race: ',
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
      body: Container(
          decoration: BoxDecoration(color: Color(0xFFF1EBE6)),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              FutureBuilder<LiveRace>(
                  future: liveRace,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Text(snapshot.data!.race!.name,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Nasalization')),
                              SizedBox(height: 15),
                              Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: YoYoPlayer(
                                  aspectRatio: 16 / 9,
                                  url:
                                      "https://stream.aronbuffel.be/hls/race.m3u8",
                                  videoStyle: VideoStyle(
                                      allowScrubbing: true,
                                      forwardIcon: Container(
                                        child: Icon(
                                          CarbonIcons.forward_10,
                                          color: Colors.white,
                                        ),
                                      ),
                                      forwardIconColor: Colors.white),
                                  videoLoadingStyle: VideoLoadingStyle(),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: [
                                      ToggleButtons(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        selectedBorderColor: Colors.red[700],
                                        selectedColor: Colors.white,
                                        fillColor: Colors.red[400],
                                        borderWidth: 2,
                                        borderColor: Colors.black,
                                        color: Colors.black,
                                        constraints: BoxConstraints(
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.20,
                                            minHeight: 35),
                                        direction: vertical
                                            ? Axis.vertical
                                            : Axis.horizontal,
                                        isSelected: isSelected,
                                        onPressed: ((index) {
                                          setState(() {
                                            for (int i = 0;
                                                i < isSelected.length;
                                                i++) {
                                              isSelected[i] = i == index;
                                            }
                                          });
                                        }),
                                        children: [
                                          Text(
                                            'The race',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Nasalization"),
                                          ),
                                          Text('Place bet',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Nasalization"))
                                        ],
                                      ),
                                      if (isSelected[0]) ...[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2,
                                                  style: BorderStyle.solid),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          margin: EdgeInsets.only(top: 20),
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: snapshot
                                                .data!.race!.drivers.length,
                                            itemBuilder: (context, index) {
                                              return Center(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Text(
                                                    '${index + 1}: ${snapshot.data!.race!.drivers[index].name}',
                                                    style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ] else if (isSelected[1]) ...[
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 2,
                                                    style: BorderStyle.solid),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            margin: EdgeInsets.only(top: 20),
                                            child: Column(
                                              children: [
                                                DropdownButton<int>(
                                                    items: snapshot
                                                        .data!.race!.drivers
                                                        .map((e) {
                                                      return DropdownMenuItem<
                                                              int>(
                                                          value: e.id,
                                                          child: Text(e.name));
                                                    }).toList(),
                                                    onChanged: (newValue) {})
                                              ],
                                            ))
                                      ]
                                    ],
                                  ))
                            ],
                          ));
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                        child: SpinKitWave(
                      color: Colors.black,
                      size: 40,
                      itemCount: 6,
                    ));
                  }),
            ],
          )),
    );
  }
}
