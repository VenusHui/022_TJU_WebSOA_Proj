import 'package:flutter/material.dart';
import 'package:oneonly/pages/tabs/MyInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../models/api_response.dart';
import 'MyOrders.dart';
import 'Viewer.dart';

class Mine extends StatefulWidget {
  const Mine({super.key});

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> {
  late Map userInfo = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var userId = await getUserId();
    Response entity =
        Response.fromJson(await Api.getUserInfo(int.parse(userId)));
    setState(() {
      userInfo = entity.data;
    });
  }

  Future<String> getUserId() async {
    String? userId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    return userId ?? '';
  }

  var imgUrl = "https://pic.imgdb.cn/item/63b26f945d94efb26fceee69.jpg";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Gradient gradient =
        const LinearGradient(colors: [Colors.blueAccent, Colors.redAccent]);
    Shader shader =
        gradient.createShader(Rect.fromLTWH(100, 100, size.width, size.height));

    return Container(
      // 背景图片
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/mine-bg.png'),
        ),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 头像
          Padding(
            padding: const EdgeInsets.only(top: 80, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(userInfo['avatar'] ??
                        'https://pic.imgdb.cn/item/63b26f945d94efb26fceee69.jpg')),
              ],
            ),
          ),
          // 用户名
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              userInfo['userName'] ?? '',
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ),
          // 我的订单-观演人-个人信息，信誉分
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 我的订单-观演人-个人信息
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: 230,
                  height: 80,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    color: Color(0x0cA1BDF5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 我的订单
                      GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 2),
                              height: 40,
                              width: 25,
                              child: Image.asset(
                                "assets/images/mine-home-1.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            const Text(
                              '我的订单',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const MyOrders();
                          }));
                        },
                      ),
                      // 观演人
                      GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 2),
                              height: 40,
                              width: 25,
                              child: Image.asset(
                                "assets/images/mine-home-2.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            const Text(
                              '观演人',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Viewer();
                          }));
                        },
                      ),
                      // 个人信息
                      GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 2),
                              height: 40,
                              width: 35,
                              child: Image.asset(
                                "assets/images/mine-home-3.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            const Text(
                              '个人信息',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const MyInfo();
                          }));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // 信誉分
              Container(
                width: 120,
                height: 80,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  color: Color(0x0cA1BDF5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      // 信誉分
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            '信誉分',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            userInfo['credit'].toString(),
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = shader),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 370,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
                color: Colors.black12,
              ),
            ),
          )
        ],
      ),
    );
    //...
  }
}
