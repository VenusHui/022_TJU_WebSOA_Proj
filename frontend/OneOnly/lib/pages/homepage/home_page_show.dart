import 'dart:ui';

import 'package:flutter/material.dart';
import '../performance/PerformanceDetail.dart';

Gradient gradient = LinearGradient(
  colors: [
    Color.fromRGBO(238, 72, 120, 1),
    Color.fromRGBO(246, 9, 78, 1),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
Shader shader = gradient.createShader(Rect.fromLTWH(0, 0, 60, 20));

class home_page_show extends StatefulWidget {
  const home_page_show({super.key});

  @override
  State<home_page_show> createState() => _home_page_showState();
}

class _home_page_showState extends State<home_page_show> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 310,
            height: 133,
            margin: EdgeInsets.all(18.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(161, 189, 245, 0.5),
                  offset: Offset(0, 0),
                  blurStyle: BlurStyle.normal,
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
              image: DecorationImage(
                  image: AssetImage('IMG_1737.JPG'), fit: BoxFit.cover),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
            child: Text(
              "近期上演",
              style:
                  TextStyle(foreground: Paint()..shader = shader, fontSize: 13),
            ),
          ),
          Row(
            children: [
              TextButton(
                  child: Container(
                    width: 78,
                    height: 101,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      image: DecorationImage(
                          image: AssetImage('IMG_1738.JPG'), fit: BoxFit.cover),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => PerformanceDetail(),
                      ),
                    );
                  })
            ],
          )
        ],
      ),
    );
  }
}
