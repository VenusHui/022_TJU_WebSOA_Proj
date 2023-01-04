import 'package:flutter/material.dart';
import 'package:oneonly/pages/tabs/OrderSpecific.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../models/api_response.dart';
import '../../models/order.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  var imgUrl = "https://pic.imgdb.cn/item/63b26f945d94efb26fceee69.jpg";

  List<Order> temporderList = [];
  List<Order> orderList = [];
  late Map userInfo = {};
  @override
  void initState() {
    super.initState();
    //查询订单信息
    getData();
    getUserInfo();
  }

  getUserInfo() async {
    var userId = await getUserId();
    Response entity =
        Response.fromJson(await Api.getUserInfo(int.parse(userId)));
    setState(() {
      userInfo = entity.data;
    });
  }

  getData() async {
    var userId = await getUserId();
    APIResponse realViewerRes =
        APIResponse.fromJson(await Api.getUserOrder(int.parse(userId)));

    OrderListResponse orderRes = OrderListResponse.fromJson(realViewerRes.data);
    setState(() {
      orderList.clear();
      temporderList.clear();
      temporderList.addAll(orderRes.content!);
      temporderList.forEach((i) {
        if (i.status == 1) {
          orderList.add(i);
        }
      });
    });
    orderList.forEach((e) async {
      APIResponse entity = APIResponse.fromJson(
          await Api.getHistrionicShow(e.histrionicsId.toString()));
      setState(() {
        e.histrionics = entity.data['histrionics'];
        e.shows = entity.data['shows'];
      });
    });
  }

  Future<String> getUserId() async {
    String? userId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    return userId ?? '';
  }

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
            padding: const EdgeInsets.only(top: 53, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.network(userInfo['avatar'] ?? imgUrl,
                        width: 70, height: 70, fit: BoxFit.fill)),
              ],
            ),
          ),
          // 用户名
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              '${userInfo['userName'] ?? ''}',
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          // 我的订单-观演人-个人信息，信誉分
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
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
                  height: 50,
                  width: 40,
                  child: Image.asset(
                    "assets/images/mine-home-1.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ),
          // 我的订单列表
          Expanded(
              child: orderList.isEmpty
                  ? Container()
                  : ListView.builder(
                      itemCount: orderList.length,
                      itemBuilder: ((context, index) {
                        return _item(index);
                      })))
        ],
      ),
    );
  }

  Widget _item(int index) {
    return GestureDetector(
      child: FractionallySizedBox(
        alignment: Alignment.center,
        // 宽度因子 1为占满整行
        widthFactor: 0.9,
        child: Container(
          margin: const EdgeInsets.only(
            top: 12,
          ),
          padding: const EdgeInsets.only(left: 20, right: 20),
          height: 92,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
            color: Color(0x0cA1BDF5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderList[index].shows?['title'] ?? '',
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: Color(0xFFE5EDFE),
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 3,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderList[index].histrionics?['startTime'] ??
                                      '',
                                  style: const TextStyle(
                                    fontSize: 8.0,
                                    color: Color(0xFF5E7092),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                Text(
                                  orderList[index]
                                          .histrionics?['description'] ??
                                      '',
                                  style: const TextStyle(
                                    fontSize: 8.0,
                                    color: Color(0xFF5E7092),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '¥${orderList[index].price ?? ''}',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const Text(
                            '/共1张',
                            style: TextStyle(
                              fontSize: 8.0,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 交易信息
                  const Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Text(
                      '交易成功',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Color(0xFFA1BDF5),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  // 海报图片
                  Container(
                    padding: const EdgeInsets.only(bottom: 2),
                    height: 53,
                    width: 40,
                    child: Image.network(
                      orderList[index].shows?['image'] ?? '',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const OrderSpecific();
        }));
      },
    );
  }
}
