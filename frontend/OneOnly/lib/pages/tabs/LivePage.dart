import 'package:flutter/material.dart';
import '../../pages/livepage/live_page_show.dart';

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  @override
  String location = "上海";
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(8, 11, 32, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(8, 11, 32, 1),
          leading: Container(
              child: Row(
            children: [
              Text(
                location,
                style: TextStyle(color: Color.fromRGBO(161, 189, 245, 1)),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(Icons.room, color: Color.fromRGBO(161, 189, 245, 1)),
                color: Color.fromRGBO(161, 189, 245, 1),
              ),
            ],
          )),
          actions: <Widget>[
            TextButton(
              child: CircleAvatar(
                  backgroundImage: AssetImage('assets/peeps-avatar.png')),
              onPressed: null,
            ),
          ],
          title: Container(
            width: 176,
            height: 29,
            decoration: BoxDecoration(
                color: Color.fromARGB(126, 91, 107, 139),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(161, 189, 245, 0.5),
                    offset: Offset(0, 0),
                    blurStyle: BlurStyle.inner,
                    blurRadius: 5,
                    spreadRadius: 0,
                  )
                ]),
          ),
        ),
        body: const live_page_show(),
        );
  }
}
