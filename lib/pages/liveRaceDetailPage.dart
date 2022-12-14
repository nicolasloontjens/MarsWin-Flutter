import 'dart:async';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
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
  final TextEditingController _amountController = TextEditingController();
  late Future<LiveRace> liveRace;
  final List<bool> isSelected = [true, false];
  bool vertical = false;
  late int selectedValue = 1;

  Future _placeBet(int driverId, int raceId, int amount) async {
    var res = await Datafetcher.placeBet(driverId, raceId, amount);
    showToast(
      res ? "Bet placed!" : "Could not place bet",
      context: context,
      position: StyledToastPosition.top,
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.fade,
      alignment: Alignment.bottomCenter,
      backgroundColor: res ? Colors.greenAccent : Colors.redAccent,
      duration: Duration(seconds: 3),
      shapeBorder: ShapeBorder.lerp(
          Border(
            top: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 3.0),
            bottom: BorderSide(color: Colors.black, width: 3.0),
          ),
          Border(
            top: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 3.0),
            bottom: BorderSide(color: Colors.black, width: 3.0),
          ),
          0.5),
    );
  }

  @override
  void initState() {
    super.initState();
    liveRace = Datafetcher.getLiveRace();
    Timer.periodic(
        Duration(seconds: 10),
        (Timer t) => setState(() {
              liveRace = Datafetcher.getLiveRace();
            }));
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
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color(0xFFFFF9F3)),
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
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Color(0xFFFFF9F3)),
                                            margin: EdgeInsets.only(top: 20),
                                            child: Column(
                                              children: [
                                                DropdownButton<int>(
                                                    style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    underline: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 4),
                                                      height: 1,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 2)),
                                                    ),
                                                    icon: Icon(
                                                        CarbonIcons.person),
                                                    hint: Text('Your driver'),
                                                    dropdownColor:
                                                        Color(0xFFf1ebe6),
                                                    items: snapshot
                                                        .data!.race!.drivers
                                                        .map((e) {
                                                      return DropdownMenuItem<
                                                              int>(
                                                          value: e.id,
                                                          child: Text(e.name));
                                                    }).toList(),
                                                    value: selectedValue,
                                                    onChanged: (int? newValue) {
                                                      setState(() {
                                                        selectedValue =
                                                            int.parse(newValue
                                                                .toString());
                                                      });
                                                    }),
                                                SizedBox(height: 20),
                                                TextFormField(
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  validator: (value) {},
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: _amountController,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.black,
                                                            width: 2.0),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.black,
                                                            width: 2.0),
                                                      ),
                                                      hintText: 'Amount'),
                                                ),
                                                SizedBox(height: 10),
                                                GestureDetector(
                                                  onTap: () async {
                                                    await _placeBet(
                                                        selectedValue,
                                                        snapshot.data!.race!.id,
                                                        int.parse(
                                                            _amountController
                                                                .text));
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black,
                                                            blurRadius: 0,
                                                            spreadRadius: 3.5,
                                                            offset:
                                                                Offset(1, 1),
                                                          ),
                                                          BoxShadow(
                                                            color: Color(
                                                                0xFFE75657),
                                                            blurRadius: 0,
                                                            offset:
                                                                Offset(0, 0),
                                                          )
                                                        ]),
                                                    child: Text(
                                                      'Place bet!',
                                                      style: TextStyle(
                                                          letterSpacing: 0.2,
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'Nasalization',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
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
