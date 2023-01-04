import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oneonly/pages/performance/ChangeSale.dart';
import 'package:oneonly/pages/performance/SelectSit.dart';

import '../../api/api.dart';
import '../../models/api_response.dart';

class PerformanceDetail extends StatefulWidget {
  int showId;

  PerformanceDetail({Key? key, required this.showId}) : super(key: key);

  @override
  _PerformanceDetailState createState() => _PerformanceDetailState();
}

class _PerformanceDetailState extends State<PerformanceDetail> {
  TextEditingController textEditingController = TextEditingController();
  late Map detail;
  late Map selectStation;
  late Map showDetail;

  List stations = [];

  List histrionicsList = [];

  List ticketStall = [];

  int histrionicsId = 1;

  int ticketStallId = 1;

  @override
  void initState() {
    // selectCate = cates[0];
    // queryData();
    //this.queryChatCircle();
    detail = {
      "image":
          "https://bkimg.cdn.bcebos.com/pic/b8389b504fc2d562853519cf964487ef76c6a7efc6c1?x-bce-process=image/resize,m_lfit,w_536,limit_1",
      "name": "[南京]Mr.Miss2022《枕边迷航》全国巡演-南京站",
      "stations": [
        {
          "name": "郑州站",
          "time": "2022.12.02",
          "time1": "2022.12.02 周五 20:00",
          "time2": "约90分钟(以现场为准)",
          "address1": "郑州市|稻香大麦Livehouse",
          "address2": "郑州站郑州站"
        },
        {
          "name": "南京站",
          "time": "2023.01.02",
          "time1": "2022.12.02 周五 20:00",
          "time2": "约90分钟(以现场为准)",
          "address1": "南京市|稻香大麦Livehouse",
          "address2": "南京站"
        },
        {
          "name": "杭州站",
          "time": "2022.02.22",
          "time1": "2022.12.02 周五 20:00",
          "time2": "约90分钟(以现场为准)",
          "address1": "杭州|稻香大麦Livehouse",
          "address2": "杭州站"
        },
        {
          "name": "长沙站",
          "time": "2022.03.12",
          "time1": "2022.12.02 周五 20:00",
          "time2": "约90分钟(以现场为准)",
          "address1": "长沙|稻香大麦Livehouse",
          "address2": "长沙"
        },
      ],
      "jieshao": "你做过这样的梦吗?\n沉沉睡去,发现你已不是你.",
      "minPrice": 228,
      "maxPrice": 228
    };
    selectStation = detail["stations"][0];

    initData();
  }

  initData() async {
    //获取数据
    APIResponse entity =
        APIResponse.fromJson(await Api.showDetails(widget.showId));
    setState(() {
      showDetail = entity.data['show'];
      histrionicsList = entity.data['histrionics'];
      histrionicsId = histrionicsList[0]['histrionicsId'];
      getHistrion();
    });
  }

  getHistrion() async {
    APIResponse res2 =
        APIResponse.fromJson(await Api.histrionicsDetails(histrionicsId));
    setState(() {
      // stations = res2.data['histrionics'];
      ticketStall = res2.data['ticket_stall'];
    });
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
                height: 200,
                decoration: BoxDecoration(
                    color: const Color(0xff2c2f47),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          showDetail["image"],
                          width: 120,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          showDetail["title"],
                          maxLines: 5,
                          style: const TextStyle(
                              color: Color(0xffcccccc), fontSize: 16),
                        ),
                        Text(
                          // "¥${detail["minPrice"]}-¥${detail["maxPrice"]}",
                          ticketStall.isNotEmpty
                              ? '¥${ticketStall[0]['price'] ?? '￥0'}'
                              : '0',
                          maxLines: 5,
                          style: const TextStyle(
                              color: Color.fromRGBO(241, 7, 75, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                children: histrionicsList
                    .map((e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              histrionicsId = e['histrionicsId'];
                              getHistrion();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: histrionicsId == e['histrionicsId']
                                    ? Color.fromARGB(255, 84, 89, 97)
                                    : const Color(0xff2c2f47),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Text(
                                  e["description"],
                                  maxLines: 5,
                                  style: const TextStyle(
                                      color: Color(0xffffffff), fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  e["startTime"],
                                  maxLines: 5,
                                  style: const TextStyle(
                                      color: Color(0xffcccccc), fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xff2c2f47),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectStation["time1"],
                      maxLines: 5,
                      style: const TextStyle(
                          color: Color(0xffffffff), fontSize: 16),
                    ),
                    Text(
                      selectStation["time2"],
                      maxLines: 5,
                      style: const TextStyle(
                          color: Color(0xffaaaaaa), fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 1,
                      color: const Color(0xffaaaaaa),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      selectStation["address1"],
                      maxLines: 5,
                      style: const TextStyle(
                          color: Color(0xffffffff), fontSize: 16),
                    ),
                    Text(
                      selectStation["address2"],
                      maxLines: 5,
                      style: const TextStyle(
                          color: Color(0xffaaaaaa), fontSize: 14),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xff2c2f47),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/jieshao.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: Text(
                    detail["jieshao"],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        //返回要跳转的目标页面
                        return ChangeSale(
                          showId: widget.showId,
                        );
                      }));
                    },
                    style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(color: Colors.black)),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(161, 189, 245, 0.7))),
                    child: const Text("看看转卖"),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              //返回要跳转的目标页面
                              return SelectSit(
                                histrionicsId: histrionicsId,
                                title: showDetail['title'],
                                showPrice: '',
                                image: showDetail['image'],
                              );
                            }));
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(240, 22, 85, 1))),
                          child: const Text("选座购票")))
                ],
              )
            ],
          ),
        )));
  }
}
