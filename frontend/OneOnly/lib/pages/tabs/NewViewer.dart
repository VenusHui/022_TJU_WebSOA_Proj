import 'package:flutter/material.dart';

class NewViewer extends StatefulWidget {
  const NewViewer({super.key});

  @override
  State<NewViewer> createState() => _NewViewerState();
}

class _NewViewerState extends State<NewViewer> {
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
      padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
      child: Column(
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
                  child: Text('新增实名观演人',
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
            padding: const EdgeInsets.only(top: 15,bottom: 5),
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
                          child: const Text('姓名',
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
                          child: const Text('身份证号',
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
        ],
      ),
    );
  }
}