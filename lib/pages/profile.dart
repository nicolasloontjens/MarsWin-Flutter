import "package:flutter/material.dart";
import "../routing/route_generator.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1EBE6),
        body: SafeArea(
          child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  color: Color(0xFFFFF9F3)),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Image.asset('assets/images/marswin-no-text.png',
                            height: 75, width: 75),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Column(
                            children: [
                              Text('John Doe',
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Nasalization'))
                            ],
                          ))
                    ],
                  )
                ],
              )),
        ));
  }
}
