import 'package:flutter/material.dart';
import 'package:oneonly/pages/tabs/OrderSpecific.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({super.key});

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
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
      child: Column(
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
                  width:40,
                  child:Image.asset("assets/images/mine-home-3.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ),
          // 我的订单列表
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 昵称盒子
              Padding(
                padding: const EdgeInsets.only(top: 5,bottom: 5),
                child: FractionallySizedBox(
                  alignment: Alignment.center,
                  // 宽度因子 1为占满整行
                  widthFactor: 0.9,
                  child:Container(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    height: 49,
                    decoration: const BoxDecoration(
                      color: Color(0x0cA1BDF5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 昵称、昵称内容
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // 昵称
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 85,
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text('昵称',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xFF536383),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            // 昵称内容
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text('在云里爱与歌',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // 箭头按钮
                        GestureDetector(
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Color(0xFFA8C5FF),
                          ),
                          onTap: () {
                            // 返回上一步
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 登录密码
              Padding(
                padding: const EdgeInsets.only(top: 5,bottom: 5),
                child: FractionallySizedBox(
                  alignment: Alignment.center,
                  // 宽度因子 1为占满整行
                  widthFactor: 0.9,
                  child:Container(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    height: 49,
                    decoration: const BoxDecoration(
                      color: Color(0x0cA1BDF5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 登录密码
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // 登录密码
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 85,
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text('登录密码',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xFF536383),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            // 登录密码内容
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(' ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // 箭头按钮
                        GestureDetector(
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Color(0xFFA8C5FF),
                          ),
                          onTap: () {
                            // 返回上一步
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 常驻城市
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: FractionallySizedBox(
                  alignment: Alignment.center,
                  // 宽度因子 1为占满整行
                  widthFactor: 0.9,
                  child:Container(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    height: 49,
                    decoration: const BoxDecoration(
                      color: Color(0x0cA1BDF5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 常驻城市
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // 常驻城市
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 85,
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text('常驻城市',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xFF536383),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            // 常驻城市内容
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text('上海',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // 箭头按钮
                        GestureDetector(
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Color(0xFFA8C5FF),
                          ),
                          onTap: () {
                            // 返回上一步
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}