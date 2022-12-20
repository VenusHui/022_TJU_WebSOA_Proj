import 'package:flutter/material.dart';
import 'package:oneonly/pages/tabs/OrderSpecific.dart';

import 'NewViewer.dart';

class Viewer extends StatefulWidget {
  const Viewer({super.key});

  @override
  State<Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<Viewer> {
  var imgUrl =
      "https://7n.w3cschool.cn/statics/images/logonew2.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      // 背景图片
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/mine-bg.png'),
        ),
      ),
      padding: const EdgeInsets.all(10.0),
      child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 头像
                  Padding(
                    padding: const EdgeInsets.only(top: 53,bottom: 10),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Image.network(imgUrl,
                                width: 70, height: 70, fit: BoxFit.fill)),
                      ],
                    ),
                  ),
                  // 用户名
                  const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child:
                    Text('在云里爱与歌',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  // 我的订单-观演人-个人信息，信誉分
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Row(
                      // 返回上一页
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // 返回按钮
                        GestureDetector(
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
                        // 我的订单图标
                        Container(
                          padding: const EdgeInsets.only(bottom: 2),
                          height:50,
                          width:30,
                          child:Image.asset("assets/images/mine-home-2.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 观演人列表
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 一个观演人实例
                      FractionallySizedBox(
                        alignment: Alignment.center,
                        // 宽度因子 1为占满整行
                        widthFactor: 0.9,
                        child:Container(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          height: 57,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: Color(0x0cA1BDF5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('*元哲',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFFE5EDFE),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text('身份证 123***********1234',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Color(0xFFA1BDF5),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                child: const Icon(
                                  Icons.delete_outline,
                                  size: 25.0,
                                  color: Colors.white,
                                  semanticLabel: 'label',
                                  textDirection: TextDirection.rtl,
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return const Viewer();
                                      }));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 26),
                child: GestureDetector(
                  child: FractionallySizedBox(
                    alignment: Alignment.center,
                    // 宽度因子 1为占满整行
                    widthFactor: 0.9,
                    child:Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        color: Color(0xFFF1074B),
                      ),
                      child: const Text('增加观演人',
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return const NewViewer();
                        }));
                  },
                ),
              ),
            ],
          ),
    );
  }
}