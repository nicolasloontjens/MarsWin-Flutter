import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marswin/data/network/datafetcher.dart';
import 'package:marswin/data/network/types/Championship.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';

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
              YoYoPlayer(
                aspectRatio: 16 / 9,
                url:
                    // 'https://dsqqu7oxq6o1v.cloudfront.net/preview-9650dW8x3YLoZ8.webm',
                    // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                    // "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
                    "http://172.104.247.19/hls/race.m3u8",
                allowCacheFile: true,
                onCacheFileCompleted: (files) {
                  print('Cached file length ::: ${files?.length}');

                  if (files != null && files.isNotEmpty) {
                    for (var file in files) {
                      print('File path ::: ${file.path}');
                    }
                  }
                },
                onCacheFileFailed: (error) {
                  print('Cache file error ::: $error');
                },
                videoStyle: const VideoStyle(
                  qualityStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  forwardAndBackwardBtSize: 30.0,
                  playButtonIconSize: 40.0,
                  playIcon: Icon(
                    Icons.add_circle_outline_outlined,
                    size: 40.0,
                    color: Colors.white,
                  ),
                  pauseIcon: Icon(
                    Icons.remove_circle_outline_outlined,
                    size: 40.0,
                    color: Colors.white,
                  ),
                  videoQualityPadding: EdgeInsets.all(5.0),
                ),
                videoLoadingStyle: VideoLoadingStyle(
                  loading: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(height: 16.0),
                        Text("Loading video..."),
                      ],
                    ),
                  ),
                ),
                onFullScreen: (value) {
                  setState(() {
                    if (fullscreen != value) {
                      fullscreen = value;
                    }
                  });
                },
              ),
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
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
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
