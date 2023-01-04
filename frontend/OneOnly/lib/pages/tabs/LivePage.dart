import 'package:flutter/material.dart';
import 'package:oneonly/pages/livepage/add_share.dart';
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
        backgroundColor: const Color.fromRGBO(8, 11, 32, 1),
        leading: Container(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Text(
                  location,
                  style:
                      const TextStyle(color: Color.fromRGBO(161, 189, 245, 1)),
                ),
                const SizedBox(
                  width: 12,
                ),
                const Icon(
                  Icons.room,
                  size: 22,
                ),
              ],
            )),
        leadingWidth: 75,
        actions: <Widget>[
          TextButton(
            child: const CircleAvatar(
                backgroundImage: AssetImage('assets/peeps-avatar.png')),
            onPressed: () {
              print('点击了头像');
            },
          ),
        ],
        centerTitle: true,
        title: Container(
          height: 29,
          child: Row(
            children: [
              Container(
                width: 220,
                height: 29,
                decoration: const BoxDecoration(
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
                child: TextField(
                  cursorColor: Colors.green,
                  autofocus: false,
                  onChanged: ((value) {
                    print(value);
                  }),
                  textInputAction: TextInputAction.search,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10, bottom: 12),
                    border: InputBorder.none,
                    hintText: '搜索',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: const live_page_show(),
      floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const AddSharePage(),
              ),
            );
          }),
          // backgroundColor: const Color.fromRGBO(240, 38, 96, 1),
          child: const Icon(
            Icons.add,
            size: 32,
          )),
    );
  }
}
