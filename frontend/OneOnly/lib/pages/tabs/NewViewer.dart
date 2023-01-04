import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../models/api_response.dart';

class NewViewer extends StatefulWidget {
  const NewViewer({super.key});

  @override
  State<NewViewer> createState() => _NewViewerState();
}

class _NewViewerState extends State<NewViewer> {
  var imgUrl = "https://pic.imgdb.cn/item/63b26f945d94efb26fceee69.jpg";

  String userName = '';
  String number = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 背景图片
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/mine-bg.png'),
          ),
        ),
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 返回按钮和标题
                SizedBox(
                  height: 30.0,
                  child: Stack(
                    // 返回按钮
                    children: <Widget>[
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: GestureDetector(
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                            color: Color(0xFFA8C5FF),
                          ),
                          onTap: () {
                            // 返回上一步
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const Align(
                        alignment: FractionalOffset.center,
                        child: Text(
                          '新增实名观演人',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFFE5EDFE),
                            decoration: TextDecoration.none,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // 新增实名观演人盒子
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 5),
                  child: FractionallySizedBox(
                    alignment: Alignment.center,
                    // 宽度因子 1为占满整行
                    widthFactor: 0.9,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      height: 49,
                      decoration: const BoxDecoration(
                        color: Color(0x0cA1BDF5),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            userName = value;
                          });
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: "姓名",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF536383),
                            decoration: TextDecoration.none,
                          ),
                        ),
                        autofocus: false,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: FractionallySizedBox(
                    alignment: Alignment.center,
                    // 宽度因子 1为占满整行
                    widthFactor: 0.9,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      height: 49,
                      decoration: const BoxDecoration(
                        color: Color(0x0cA1BDF5),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.datetime,
                        onChanged: (value) {
                          setState(() {
                            number = value;
                          });
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: "身份证号",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF536383),
                            decoration: TextDecoration.none,
                          ),
                        ),
                        autofocus: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 26),
              child: GestureDetector(
                child: FractionallySizedBox(
                  alignment: Alignment.center,
                  // 宽度因子 1为占满整行
                  widthFactor: 0.9,
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      color: Color(0xFFF1074B),
                    ),
                    child: const Text(
                      '确认增加',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFFE5EDFE),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  addViewer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///点击新增按钮调用
  addViewer() async {
    if (userName.isEmpty) return;
    if (number.isEmpty) return;
    var userId = await getUserId();
    // 从input框中取值
    Response entity = Response.fromJson(
        await Api.addRealviewers(int.parse(userId), number, userName));
    if (entity.status == 'success') {
      print(entity.message);
      Navigator.pop(context);
    } else {
      print('新增失败');
    }
  }

  Future<String> getUserId() async {
    String? userId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    return userId ?? '';
  }
}
