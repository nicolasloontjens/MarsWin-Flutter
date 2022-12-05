import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_html/flutter_html.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({Key? key}) : super(key: key);

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Color(0xFFF1EBE6)),
          child: Column(
            children: [
              SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("2052 Formula Mars\nChampionship",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter')),
              ]),
              Container(
                margin: EdgeInsets.all(50),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1)),
              ),
              Html(
                data:
                    '<iframe id="video" src=https://www.youtube.com/embed/jfKfPfyJRdk frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"/>',
              )
            ],
          ),
        ),
      ),
    );
  }
}
