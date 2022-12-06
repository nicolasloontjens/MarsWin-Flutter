import 'package:carbon_icons/carbon_icons.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marswin/data/network/datafetcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../routing/route_generator.dart";
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<String> _username;
  Future<void> _launchSupportPage() async {
    final Uri _supportUrl = Uri.parse("https://www.gamblingtherapy.org/");
    if (!await launchUrl(_supportUrl)) {
      throw 'Could not launch $_supportUrl';
    }
  }

  Future _logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('isLoggedIn', 0);
    Navigator.of(context).pushNamed('/register');
  }

  @override
  void initState() {
    super.initState();
    _username = Datafetcher.getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1EBE6),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      color: Color(0xFFFFF9F3)),
                  child: Column(
                    children: [
                      SizedBox(height: 25),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Row(
                          children: [
                            Container(
                              child: Image.asset(
                                  'assets/images/marswin-no-text.png',
                                  height: 75,
                                  width: 75),
                            ),
                            SizedBox(width: 10),
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                  children: [
                                    FutureBuilder<String>(
                                        future: _username,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(snapshot.data!,
                                                style: TextStyle(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily:
                                                        'Nasalization'));
                                          } else if (snapshot.hasError) {
                                            return Text('${snapshot.error}');
                                          }
                                          return SpinKitFadingCircle();
                                        }),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(CarbonIcons.currency),
                                        Text('  1000',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Nasalization')),
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        ),
                      )
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(top: 60),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: BoxDecoration(
                        color: Color(0xFFE87470),
                        border: Border.all(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Bet history',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16),
                    )),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 25),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: BoxDecoration(
                        color: Color(0xFFE87470),
                        border: Border.all(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Change password',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16),
                    )),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 25),
                child: GestureDetector(
                  onTap: () async {
                    _logoutUser();
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: BoxDecoration(
                        color: Color(0xFFE87470),
                        border: Border.all(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Log out',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16),
                    )),
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(bottom: 50),
                child: GestureDetector(
                  onTap: _launchSupportPage,
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: BoxDecoration(
                        color: Color(0xFFE87470),
                        border: Border.all(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Get support',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
