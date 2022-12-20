import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

class live_detail extends StatefulWidget {
  const live_detail({super.key});

  @override
  State<live_detail> createState() => _live_detailState();
}

class _live_detailState extends State<live_detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(8, 11, 32, 1),
          leading: Row(
            children: [
              Container(
                  child: IconButton(
                color: Color.fromRGBO(161, 189, 245, 1),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromRGBO(161, 189, 245, 1),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
              TextButton(
                child: CircleAvatar(
                    backgroundImage: AssetImage('assets/peeps-avatar.png')),
                onPressed: null,
              ),
            ],
          ),
        ),
        body: Container(
          color: Color.fromRGBO(8, 11, 32, 1),
          child: Column(children: [
            Container(
              height: 361,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('IMG_1738.JPG'), fit: BoxFit.cover)),
            ),
            Container(
              color: Color.fromRGBO(161, 189, 245, 0.05),
              child: Text(
                "一段内容",
                style: TextStyle(
                    color: Color.fromRGBO(229, 237, 254, 1), fontSize: 12),
              ),
            ),
            Container(
              //链接到相关剧目
              height: 61,
              alignment: Alignment.center,
              width: 319,
              decoration: BoxDecoration(
                color: Color.fromRGBO(161, 189, 245, 0.35),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                children: [
                  TextButton(
                      onPressed: null,
                      child: Container(
                        alignment: Alignment.topLeft,
                        width: 36,
                        height: 47,
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('IMG_1744.JPG'),
                                fit: BoxFit.cover)),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("音乐剧《四两青春》",
                          style: TextStyle(
                            color: Color.fromRGBO(229, 234, 245, 1),
                            fontSize: 11,
                          )),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Row(children: [
                          Text("评分",
                              style: TextStyle(
                                color: Color.fromRGBO(229, 234, 245, 1),
                                fontSize: 11,
                              )),
                          Text("7.6",
                              style: TextStyle(
                                color: Color.fromRGBO(240, 38, 96, 1),
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ))
                        ]),
                      )
                    ],
                  )
                ],
              ),
            )
          ]),
        ));
  }
}
