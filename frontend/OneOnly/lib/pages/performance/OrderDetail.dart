import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
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
      "time": "2022.11.27 19:30",
      "address": "上海 | 星空间小剧场66号",
      "price": 228,
      "status": "交易成功",
      "num": 1
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

  void OrderDetail(Map item) {}

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
          title: const Text("订单详情"),
        ),
        backgroundColor: const Color(0xff0a0a20),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).padding.top + 20, 20, 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail["name"],
                            maxLines: 1,
                            style: const TextStyle(
                                color: Color(0xffffffff), fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            detail["time"],
                            maxLines: 1,
                            style: const TextStyle(
                                color: Color(0xffaaaaaa), fontSize: 14),
                          ),
                          Text(
                            detail["address"],
                            maxLines: 1,
                            style: const TextStyle(
                                color: Color(0xffaaaaaa), fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        const Text(
                          "交易成功",
                          maxLines: 1,
                          style:
                              TextStyle(color: Color(0xffaaaaaa), fontSize: 12),
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              detail["image"],
                              width: 80,
                              height: 100,
                              fit: BoxFit.cover,
                            )),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${detail["price"]}元",
                      maxLines: 1,
                      style: const TextStyle(
                          color: Color(0xffffffff), fontSize: 20),
                    ),
                    Text(
                      "¥${detail["price"]}",
                      maxLines: 1,
                      style: const TextStyle(
                          color: Color(0xffffffff), fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                    height: 1,
                    width: double.infinity,
                    color: const Color(0xff999999)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "数量",
                      maxLines: 1,
                      style: TextStyle(color: Color(0xffffffff), fontSize: 20),
                    ),
                    Text(
                      "¥${detail["price"]}",
                      maxLines: 1,
                      style: const TextStyle(
                          color: Color(0xffffffff), fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                    height: 1,
                    width: double.infinity,
                    color: const Color(0xff999999)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "商品总额",
                      maxLines: 1,
                      style: TextStyle(color: Color(0xffffffff), fontSize: 20),
                    ),
                    Text(
                      "¥${detail["price"]}",
                      maxLines: 1,
                      style: const TextStyle(
                          color: Color(0xffffffff), fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                    height: 1,
                    width: double.infinity,
                    color: const Color(0xff999999)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "订单编号",
                      maxLines: 1,
                      style: TextStyle(color: Color(0xffaaaaaa), fontSize: 20),
                    ),
                    Text(
                      "16491808009",
                      maxLines: 1,
                      style: TextStyle(color: Color(0xffaaaaaa), fontSize: 20),
                    ),
                  ],
                )
              ]),
        )));
  }
}
