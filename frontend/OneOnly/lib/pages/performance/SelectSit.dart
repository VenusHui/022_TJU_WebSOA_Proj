import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oneonly/models/realviewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../models/api_response.dart';

class SelectSit extends StatefulWidget {
  int histrionicsId;
  String title;
  String showPrice;
  String image;

  SelectSit(
      {Key? key,
      required this.histrionicsId,
      required this.title,
      required this.image,
      required this.showPrice})
      : super(key: key);

  @override
  _SelectSitState createState() => _SelectSitState();
}

class _SelectSitState extends State<SelectSit> {
  TextEditingController textEditingController = TextEditingController();
  late Map detail;
  Map? selectSession;
  Map? selectPrice;

  List prices = [];
  List sessions = [];

  List<Realviewer> realViewerList = [];

  int ticketStallId = 0;
  String price = '';
  List<String> realViewer = []; //观演人
  int purchaseQuantityNum = 0;
  int remaining = 0;

  String inputNums = '';

  @override
  void initState() {
    detail = {
      "image":
          "https://bkimg.cdn.bcebos.com/pic/b8389b504fc2d562853519cf964487ef76c6a7efc6c1?x-bce-process=image/resize,m_lfit,w_536,limit_1",
      "name": "[南京]Mr.Miss2022《枕边迷航》全国巡演-南京站",
      "sessions": [
        {"name": "2022-11-20 星期日 16:00"},
        {"name": "2022-11-25 星期五 19:30"},
        {"name": "2022-11-26 星期六 19:00"},
        {"name": "2022-11-27 星期日 13:00"},
      ],
      "prices": [
        {"price": 180},
        {"price": 280},
        {"price": 380},
        {"price": 480},
        {"price": 680},
      ],
      "minPrice": 228,
      "maxPrice": 228
    };

    initData();
  }

  initData() async {
    ///查询场次时间信息 查询票价
    APIResponse res = APIResponse.fromJson(
        await Api.histrionicsDetails(widget.histrionicsId));
    setState(() {
      sessions.add(res.data['histrionics']['startTime']);
      prices = res.data['ticket_stall'];
      if (prices.isNotEmpty) {
        ticketStallId = prices[0]['ticketStallId'];
        remaining = prices[0]['remaining'];
      }
    });

    ///查询观演人列表
    var userId = await getUserId();
    APIResponse realViewerRes =
        APIResponse.fromJson(await Api.getRealViewer(userId.toString()));

    RealviewerListResponse homeRes =
        RealviewerListResponse.fromJson(realViewerRes.data);
    setState(() {
      realViewerList.clear();
      realViewerList.addAll(homeRes.content!);
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
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
          // title: Text(user != null ? user["nickname"] : "",style:TextStyle(color: Colors.white),),
          centerTitle: true,
          elevation: 0.0,
          toolbarHeight: 50,
        ),
        backgroundColor: const Color(0xff0a0a20),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).padding.top + 20, 20, 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 140,
                decoration: BoxDecoration(
                    color: const Color(0xff2c2f47),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.image,
                          width: 80,
                          height: 120,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 5,
                          style: const TextStyle(
                              color: Color(0xffcccccc), fontSize: 16),
                        ),
                        Text(
                          "¥${detail["minPrice"]}-¥${detail["maxPrice"]}",
                          maxLines: 5,
                          style: const TextStyle(
                              color: Color(0xffaa0000),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: const [
                    Text(
                      "场次",
                      maxLines: 5,
                      style: TextStyle(color: Color(0xffcccccc), fontSize: 17),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "场次时间均为演出当地时间",
                      maxLines: 5,
                      style: TextStyle(color: Color(0xffaaaaaa), fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xff12132b),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: sessions
                      .map((e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectSession = e;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                  color: selectSession == e
                                      ? const Color(0xffaaaa00)
                                      : const Color(0xff2c2f47),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text(
                                    e,
                                    maxLines: 5,
                                    style: const TextStyle(
                                        color: Color(0xffffffff), fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: const [
                    Text(
                      "票档",
                      maxLines: 5,
                      style: TextStyle(color: Color(0xffcccccc), fontSize: 17),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xff12132b),
                    borderRadius: BorderRadius.circular(10)),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: prices
                      .map((e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                price = '';
                                // selectPrice = e;
                                price = e['price'].toString();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin:
                                  const EdgeInsets.only(bottom: 10, right: 20),
                              decoration: BoxDecoration(
                                  color: price == e['price'].toString()
                                      ? const Color(0xffaaaa00)
                                      : const Color(0xff2c2f47),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text(
                                    e["price"].toString(),
                                    maxLines: 5,
                                    style: const TextStyle(
                                        color: Color(0xffffffff), fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: const [
                    Text(
                      "选择观演人",
                      maxLines: 5,
                      style: TextStyle(color: Color(0xffcccccc), fontSize: 17),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              //观演人
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xff12132b),
                    borderRadius: BorderRadius.circular(10)),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: realViewerList
                      .map((e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                e.isSelectFlag = !e.isSelectFlag!;
                                realViewer.add(e.userId.toString());
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin:
                                  const EdgeInsets.only(bottom: 10, right: 20),
                              decoration: BoxDecoration(
                                  color: e.isSelectFlag!
                                      ? const Color(0xffaaaa00)
                                      : const Color(0xff2c2f47),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text(
                                    e.name ?? '',
                                    maxLines: 5,
                                    style: const TextStyle(
                                        color: Color(0xffffffff), fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            // EasyLoading.showSuccess("支付成功");
                            //校验是否有余票
                            if (remaining <= 0) return;
                            _inputNums(context);
                          },
                          child: const Text("去支付")))
                ],
              )
            ],
          ),
        )));
  }

  Future<void> _inputNums(context) async {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Card(
              color: Colors.white,
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        inputNums = value;
                        purchaseQuantityNum = int.parse(value);
                      });
                    },
                    decoration: InputDecoration(
                        hintText: '请输入购票数量',
                        filled: true,
                        fillColor: Colors.grey.shade50),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  if (inputNums.isEmpty) {
                    print('请输入购票数量');
                    return;
                  }
                  Navigator.pop(context);
                  placeOrder();
                },
                child: Text('确定'),
              ),
            ],
          );
        });
  }

  placeOrder() async {
    //校验是否选择票档
    if (price.isEmpty) return;
    //校验是否选择观演人
    if (realViewer.isEmpty) return;
    //校验是否选择购买数量
    if (purchaseQuantityNum == 0) return;
    var userId = await getUserId();
    APIResponse entity = APIResponse.fromJson(await Api.userPlaceOrder(
        int.parse(userId), ticketStallId, purchaseQuantityNum, realViewer));
    if (entity.status == 'success') {
      print('支付失败');
    } else {
      print('支付成功');
    }
  }
}
