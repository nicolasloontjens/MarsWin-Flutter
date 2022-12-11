import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';

class liveRaceDetailPage extends StatefulWidget {
  const liveRaceDetailPage({Key? key}) : super(key: key);

  @override
  _liveRaceDetailPageState createState() => _liveRaceDetailPageState();
}

class _liveRaceDetailPageState extends State<liveRaceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Color(0xFFF1EBE6)),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text('Live race detail page'),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: YoYoPlayer(
                  aspectRatio: 16 / 9,
                  url: "https://stream.aronbuffel.be/hls/race.m3u8",
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
            ],
          )),
    );
  }
}
