import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../models/api_response.dart';

class ChangeSale extends StatefulWidget {
  int showId;

  ChangeSale({Key? key, required this.showId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChangeSaleState createState() => _ChangeSaleState();
}

class _ChangeSaleState extends State<ChangeSale> {
  TextEditingController textEditingController = TextEditingController();
  late List list;
  Map? selectSession;
  Map? selectPrice;

  int resaleId = 0;

  @override
  void initState() {
    // list = [
    //   {
    //     "image":
    //         "https://bkimg.cdn.bcebos.com/pic/b8389b504fc2d562853519cf964487ef76c6a7efc6c1?x-bce-process=image/resize,m_lfit,w_536,limit_1",
    //     "name": "[南京]Mr.Miss2022《枕边迷航》全国巡演-南京站",
    //     "time": "2022.11.27 19:30",
    //     "address": "上海 | 星空间小剧场66号",
    //     "price": 228,
    //     "status": "交易成功",
    //     "num": 1
    //   },
    //   {
    //     "image":
    //         "https://bkimg.cdn.bcebos.com/pic/b8389b504fc2d562853519cf964487ef76c6a7efc6c1?x-bce-process=image/resize,m_lfit,w_536,limit_1",
    //     "name": "[南京]Mr.Miss2022《枕边迷航》全国巡演-南京站",
    //     "time": "2022.11.27 19:30",
    //     "address": "上海 | 星空间小剧场66号",
    //     "price": 228,
    //     "status": "交易成功",
    //     "num": 1
    //   },
    //   {
    //     "image":
    //         "https://bkimg.cdn.bcebos.com/pic/b8389b504fc2d562853519cf964487ef76c6a7efc6c1?x-bce-process=image/resize,m_lfit,w_536,limit_1",
    //     "name": "[南京]Mr.Miss2022《枕边迷航》全国巡演-南京站",
    //     "time": "2022.11.27 19:30",
    //     "address": "上海 | 星空间小剧场66号",
    //     "price": 228,
    //     "status": "交易成功",
    //     "num": 1
    //   }
    // ];

    initData();
  }

  initData() async {
    APIResponse entity =
        APIResponse.fromJson(await Api.resaleList(widget.showId));
    setState(() {
      list = entity.data;
    });
  }

  postResales(String resaleId) async {
    var userId = await getUserId();
    Response entity =
        Response.fromJson(await Api.postResales(resaleId, userId));
    print(entity.message);
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
                                          EasyLoading.showSuccess("支付成功");
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
          title: const Text("转卖市场"),
        ),
        backgroundColor: const Color(0xff0a0a20),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: list
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
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            color: selectSession == e
                                ? const Color(0xffaaaa00)
                                : const Color(0xff2c2f47),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '唐人街探案',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Color(0xffffffff), fontSize: 16),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    e["publishTime"],
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Color(0xffaaaaaa), fontSize: 14),
                                  ),
                                  const Text(
                                    '地址',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Color(0xffaaaaaa), fontSize: 16),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        e["price"].toString(),
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 20),
                                      ),
                                      const Text(
                                        "/共1张",
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Color(0xffaaaaaa),
                                            fontSize: 16),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: [
                                Text(
                                  e['status'] == 1 ? '交易成功' : '交易失败',
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Color(0xffaaaaaa), fontSize: 12),
                                ),
                                const SizedBox(height: 10),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      // 'https://bkimg.cdn.bcebos.com/pic/b8389b504fc2d562853519cf964487ef76c6a7efc6c1?x-bce-process=image/resize,m_lfit,w_536,limit_1',
                                      'https://5b0988e595225.cdn.sohucs.com/images/20191218/baeb8aea4d8446a4850417b30ffd7abe.jpeg',
                                      width: 80,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )),
                                const SizedBox(height: 5),
                                ElevatedButton(
                                    onPressed: () {
                                      // EasyLoading.showSuccess("支付成功");
                                      postResales(e['resaleId'].toString());
                                    },
                                    child: const Text("购买"))
                              ],
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
