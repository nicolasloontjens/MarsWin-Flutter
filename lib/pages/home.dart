import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("this will be the homepage"),
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Color.fromARGB(0, 0, 0, 0),
          selectedItemColor: Color(0xFFF1EBE6),
          backgroundColor: Color(0xFFE87470),
          items: [
            BottomNavigationBarItem(icon: (Icon(Icons.home)), label: "Home"),
            BottomNavigationBarItem(icon: (Icon(Icons.home)), label: "Test")
          ]),
    );
  }
}
