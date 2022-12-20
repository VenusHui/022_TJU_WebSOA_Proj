import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SelectSit extends StatefulWidget {
  const SelectSit({Key? key}) : super(key: key);

  @override
  _SelectSitState createState() => _SelectSitState();
}

class _SelectSitState extends State<SelectSit> {
  TextEditingController textEditingController = TextEditingController();
  late Map detail;
  Map? selectSession;
  Map? selectPrice;

  @override
  void initState() {
    // selectCate = cates[0];
    // queryData();
    //this.queryChatCircle();
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
  }

  initData() async {}

  void queryData() async {
    // var res = await ApiService.searchUserByCcid(textEditingController.text);
    // setState(() {
    //   list = [res];
    // });
  }

  void _onPageChange(int index) {
    setState(() {});
    // _tabController?.animateTo(index);
  }

  void SelectSit(Map item) {}

  @override
  Widget build(BuildContext context) {
    List sessions = detail["sessions"];
    List prices = detail["prices"];

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
                          detail["image"],
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
                          detail["name"],
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
                                    e["name"],
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
                                selectPrice = e;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin:
                                  const EdgeInsets.only(bottom: 10, right: 20),
                              decoration: BoxDecoration(
                                  color: selectPrice == e
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
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            EasyLoading.showSuccess("支付成功");
                          },
                          child: const Text("去支付")))
                ],
              )
            ],
          ),
        )));
  }
}
