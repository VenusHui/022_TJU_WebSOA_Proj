import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyTickets extends StatefulWidget {
  const MyTickets({Key? key}) : super(key: key);

  @override
  _MyTicketsState createState() => _MyTicketsState();
}

class _MyTicketsState extends State<MyTickets> {
  TextEditingController textEditingController = TextEditingController();
  late List list;
  Map? selectSession;
  Map? selectPrice;

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
  }

  initData() async {}

  void queryData() async {
    // var res = await ApiService.searchUserByCcid(textEditingController.text);
    // setState(() {
    //   list = [res];
    // });
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

  void _onPageChange(int index) {
    setState(() {});
    // _tabController?.animateTo(index);
  }

  void MyTickets(Map item) {}

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
                                  e["image"],
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
                                        e["name"],
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
                                            e["price"].toString(),
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
                                  Text(
                                    e["time"],
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: Color(0xffaaaaaa), fontSize: 12),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        showInfo();
                                      },
                                      child: const Text("转卖")),
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
