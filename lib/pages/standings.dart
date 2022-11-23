import "package:flutter/material.dart";

class StandingsPage extends StatefulWidget {
  const StandingsPage({Key? key}) : super(key: key);

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("2052 Formula Mars
               Championship",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter')),
            ]),
          ],
        ),
      ),
    );
  }
}
