import 'package:flutter/material.dart';

class OrderSpecific extends StatefulWidget {
  const OrderSpecific({super.key});

  @override
  State<OrderSpecific> createState() => _OrderSpecificState();
}

class _OrderSpecificState extends State<OrderSpecific> {
  var imgUrl = "https://pic.imgdb.cn/item/63b26f945d94efb26fceee69.jpg";

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
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
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
                  child: Text(
                    '订单详情',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFFE5EDFE),
                      decoration: TextDecoration.none,
                    ),
                  ),
                )
              ],
              // 标题-订单详情
            ),
          ),
          // 订单详情盒子
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 2),
            height: 97,
            child: FractionallySizedBox(
              alignment: Alignment.center,
              // 宽度因子 1为占满整行
              widthFactor: 0.9,
              child:
                  // 剧场介绍
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.center,
                    // 宽度因子 1为占满整行
                    heightFactor: 1,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '环境式驻演音乐剧《灯塔》\n「48小时内核酸入场」',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Color(0xFFE5EDFE),
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '2022.11.27 19:30',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xFF5E7092),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Text(
                                '上海｜星空间小剧场66号',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xFF5E7092),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 2),
                    height: 75,
                    width: 56,
                    child: Image.asset(
                      "assets/images/mine-order-1.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 订单数据盒子
          Container(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: FractionallySizedBox(
              alignment: Alignment.center,
              // 宽度因子 1为占满整行
              widthFactor: 0.9,
              child:
                  // 订单数据
                  Column(
                children: [
                  // 分割线
                  Container(
                    height: 1.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      color: Color(0xCC5E7092),
                    ),
                  ),
                  // 价格
                  SizedBox(
                    height: 29.0,
                    child: Stack(
                      children: const <Widget>[
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            '价格',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFFA8C5FF),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.centerRight,
                          child: Text(
                            '¥280',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFFA8C5FF),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        )
                      ],
                      // 标题-订单详情
                    ),
                  ),
                  // 分割线
                  Container(
                    height: 1.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      color: Color(0xCC5E7092),
                    ),
                  ),
                  // 数量
                  SizedBox(
                    height: 29.0,
                    child: Stack(
                      children: const <Widget>[
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            '数量',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFFA8C5FF),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.centerRight,
                          child: Text(
                            '1',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFFA8C5FF),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        )
                      ],
                      // 标题-订单详情
                    ),
                  ),
                  // 分割线
                  Container(
                    height: 1.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      color: Color(0xCC5E7092),
                    ),
                  ),
                  // 商品总额
                  SizedBox(
                    height: 29.0,
                    child: Stack(
                      children: const <Widget>[
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            '商品总额',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFFA8C5FF),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.centerRight,
                          child: Text(
                            '¥280',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFFA8C5FF),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        )
                      ],
                      // 标题-订单详情
                    ),
                  ),
                  // 分割线
                  Container(
                    height: 1.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      color: Color(0xCC5E7092),
                    ),
                  ),
                  // 订单编号
                  SizedBox(
                    height: 29.0,
                    child: Stack(
                      children: const <Widget>[
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            '订单编号',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFF536383),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.centerRight,
                          child: Text(
                            '1649387669545',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFF536383),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        )
                      ],
                      // 标题-订单详情
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
