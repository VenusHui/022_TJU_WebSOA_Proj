import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api.dart';
import '../../models/api_response.dart';
import '../../models/resell.dart';

class MyTickets extends StatefulWidget {
  const MyTickets({Key? key}) : super(key: key);

  @override
  _MyTicketsState createState() => _MyTicketsState();
}

class _MyTicketsState extends State<MyTickets> {
  TextEditingController textEditingController = TextEditingController();
  late List list;

  List<Resell> tempResellList = [];
  List<Resell> resellList = [];
  String price = '';
  int ticketId = 0;

  String codeImg = '';

  String defaultImg =
      'https://bkimg.cdn.bcebos.com/pic/b8389b504fc2d562853519cf964487ef76c6a7efc6c1?x-bce-process=image/resize,m_lfit,w_536,limit_1';

  @override
  void initState() {
    // selectCate = cates[0];
    // queryData();
    //this.queryChatCircle();
    list = [
      {
        "image":
            "https://bkimg.cdn.bcebos.com/pic/b8389b504fc2d562853519cf964487ef76c6a7efc6c1?x-bce-process=image/resize,m_lfit,w_536,limit_1",
        "name": "Mr.Miss2022《枕边迷航》全国巡演-南京站",
        "time": "2022.11.27 19:30",
        "address": "上海 | 星空间小剧场66号",
        "price": 228,
        "status": "交易成功",
        "num": 1
      },
      {
        "image":
            "https://bkimg.cdn.bcebos.com/pic/b8389b504fc2d562853519cf964487ef76c6a7efc6c1?x-bce-process=image/resize,m_lfit,w_536,limit_1",
        "name": "Mr.Miss2022《枕边迷航》全国巡演-南京站",
        "time": "2022.11.27 19:30",
        "address": "上海 | 星空间小剧场66号",
        "price": 228,
        "status": "交易成功",
        "num": 1
      },
      {
        "image":
            "https://bkimg.cdn.bcebos.com/pic/b8389b504fc2d562853519cf964487ef76c6a7efc6c1?x-bce-process=image/resize,m_lfit,w_536,limit_1",
        "name": "Mr.Miss2022《枕边迷航》全国巡演-南京站",
        "time": "2022.11.27 19:30",
        "address": "上海 | 星空间小剧场66号",
        "price": 228,
        "status": "交易成功",
        "num": 1
      }
    ];
    initData();
  }

  initData() async {
    var userId = await getUserId();
    ResellListResponse entity = ResellListResponse.fromJson(
        await Api.getValidTicket(int.parse(userId)));
    setState(() {
      tempResellList.clear();
      tempResellList.addAll(entity.data!);
      resellList.clear();
      tempResellList.forEach((i) {
        if (i.status == 1) {
          resellList.add(i);
        }
      });
    });
    resellList.forEach((e) async {
      APIResponse entity = APIResponse.fromJson(
          await Api.getTicketsDetails(userId, e.ticketId.toString()));
      setState(() {
        e.histrionics = entity.data['histrionics'];
        e.shows = entity.data['shows'];
        e.ticketStall = entity.data['ticket_stall'];
      });
    });
  }

  postResell() async {
    if (price.isEmpty) {
      print('请输入转售价格');
      return;
    }
    var userId = await getUserId();

    Response res = Response.fromJson(
        await Api.postResells(int.parse(userId), ticketId, int.parse(price)));
    if (res.status == 'success') {
      print('发布转卖成功');
      initData();
    } else {
      print(res.message);
    }
  }

  postCode() async {
    var userId = await getUserId();
    Response res = Response.fromJson(
        await Api.ticketsCode(userId.toString(), ticketId.toString()));
    if (res.status == 'success') {
      setState(() {
        codeImg = res.data['base64_image'];
      });
      showCode();
    } else {
      EasyLoading.showError(res.message!);
    }
  }

  Future<String> getUserId() async {
    String? userId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    return userId ?? '';
  }

  showInfo() {
    //iOS
    showDialog<void>(
        context: context,
        useSafeArea: false,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MaterialApp(
              title: "loging",
              home: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: TextField(
                                    controller: textEditingController,
                                    onChanged: (value) {
                                      setState(() {
                                        price = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "请输入转售价格"),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          // EasyLoading.showSuccess("支付成功");
                                          //调用接口
                                          postResell();
                                        },
                                        child: const Text("转卖")),
                                    const SizedBox(width: 50),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("关闭"))
                                  ],
                                )
                              ],
                            ),
                          )))));
        });
  }

  showCode() {
    showDialog<void>(
        context: context,
        useSafeArea: false,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MaterialApp(
              home: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  child: Image.memory(base64Decode(codeImg)),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("关闭"))
                              ],
                            ),
                          )))));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: Colors.transparent),
          // title: Text(user != null ? user["nickname"] : "",style:TextStyle(color: Colors.white),),
          centerTitle: true,
          elevation: 0.0,
          toolbarHeight: 50,
          title: const Text("我的票据"),
        ),
        backgroundColor: const Color(0xff0a0a20),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: resellList
                .map((e) => GestureDetector(
                      onTap: () {
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (context) {
                        //   //返回要跳转的目标页面
                        //   return const OrderDetail();
                        // }));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(40, 20, 10, 20),
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/piao.png"),
                              fit: BoxFit.fill),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  e.shows?['image'] ?? defaultImg,
                                  width: 60,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.shows?['title'] ?? '',
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 13),
                                      ),
                                      const SizedBox(height: 5),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: const [
                                              Text(
                                                "ROW排",
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Color(0xffffffff),
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                "10",
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Color(0xffaaaaaa),
                                                    fontSize: 11),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: const [
                                              Text(
                                                "SEAT座",
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Color(0xffffffff),
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                "5",
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Color(0xffaaaaaa),
                                                    fontSize: 11),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${e.ticketStall?['price']}',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: Color(0xffaaaaaa),
                                                fontSize: 16),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 100,
                              width: 70,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // const Text(
                                  //   '1111',
                                  //   maxLines: 2,
                                  //   style: TextStyle(
                                  //       color: Color(0xffaaaaaa), fontSize: 12),
                                  // ),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          ticketId = e.ticketId!;
                                        });
                                        showInfo();
                                      },
                                      child: const Text("转卖")),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          ticketId = e.ticketId!;
                                        });
                                        postCode();
                                      },
                                      child: const Text("验票")),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        )));
  }
}
