import 'package:carbon_icons/carbon_icons.dart';
import "package:flutter/material.dart";
import "../routing/route_generator.dart";
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  launchSupportPage() async {
    final Uri _supportUrl =
        Uri(host: "https://www.gamblingtherapy.org", path: "/");
    if (await canLaunchUrl(_supportUrl)) {
      await launchUrl(_supportUrl);
    } else {
      throw 'Could not launch $_supportUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1EBE6),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  height: 150,
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
                                  height: 100,
                                  width: 100),
                            ),
                            SizedBox(width: 20),
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('John Doe',
                                            style: TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Nasalization')),
                                        IconButton(
                                            onPressed: () => {},
                                            icon: Icon(CarbonIcons.edit))
                                      ],
                                    ),
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
                padding: EdgeInsets.only(top: 50),
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
              Spacer(),
              Container(
                padding: EdgeInsets.only(bottom: 40),
                child: GestureDetector(
                  onTap: () async {
                    await launchSupportPage();
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
