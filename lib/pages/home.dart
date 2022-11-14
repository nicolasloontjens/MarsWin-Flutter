import "package:flutter/material.dart";
import 'package:carbon_icons/carbon_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> widgets = [
    Icon(CarbonIcons.home),
    Icon(CarbonIcons.trophy_filled),
    TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Search',
      ),
    ),
    Icon(CarbonIcons.user)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: widgets),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          unselectedItemColor: Colors.black,
          selectedItemColor: Color(0xFFF1EBE6),
          backgroundColor: Color(0xFFE87470),
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: (Icon(CarbonIcons.home)), label: "Home"),
            BottomNavigationBarItem(
                icon: (Icon(CarbonIcons.trophy_filled)), label: "Standings"),
            BottomNavigationBarItem(
                icon: (Icon(CarbonIcons.wallet)), label: "Wallet"),
            BottomNavigationBarItem(
                icon: (Icon(CarbonIcons.user)), label: "Profile"),
          ]),
    );
  }
}
