import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralElements {
  static void placeholder() {}

  static Widget getActionButton(
      String content, Function func, BuildContext context,
      {Color color = const Color(0xFFE87470)}) {
    return Container(
      child: GestureDetector(
        onTap: () async {
          func();
        },
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.40,
          decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 0,
                  offset: Offset(1, 1),
                )
              ]),
          child: Center(
              child: Text(
            content,
            style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16),
          )),
        ),
      ),
    );
  }
}
