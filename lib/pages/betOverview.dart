import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marswin/data/network/datafetcher.dart';
import 'package:marswin/data/network/types/Bet.dart';
import 'package:marswin/data/network/types/BetResponse.dart';

class BetOverview extends StatefulWidget {
  @override
  _BetOverviewState createState() => _BetOverviewState();
}

class _BetOverviewState extends State<BetOverview> {
  late Future<List<BetResponse>> bets;

  @override
  void initState() {
    super.initState();
    bets = Datafetcher.getBets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFE87470),
        title: Text('Your bet history: ',
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
        decoration: BoxDecoration(
            color: Color(0xFFFFF9F3),
            border: Border(top: BorderSide(color: Colors.black, width: 1))),
        child: FutureBuilder<List<BetResponse>>(
          future: bets,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.8,
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
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFFFFF9F3)),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            color: Color(0xFFfaeee7),
                            border: Border(
                                top: BorderSide(color: Colors.black),
                                bottom: BorderSide(color: Colors.black))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                  "${snapshot.data![index].driver.name}",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(CarbonIcons.currency, size: 24),
                                Text(
                                  "${snapshot.data![index].bet.amount}",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                      // ListTile(
                    },
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
                child: SpinKitWave(
              color: Colors.black,
              size: 40,
              itemCount: 6,
            ));
          },
        ),
      ),
    );
  }
}
