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
            )
          ],
        ),
      ),
    );
  }
}
