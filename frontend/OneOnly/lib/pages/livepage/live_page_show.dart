import 'dart:ui';
import 'dart:math';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter/material.dart';
import 'live_detail.dart';

class live_page_show extends StatefulWidget {
  const live_page_show({super.key});

  @override
  State<live_page_show> createState() => _live_page_showState();
}

class _live_page_showState extends State<live_page_show> {
  @override
  List _waterFallList = [];
  List _num = [];
  @override
  void initState() {
    super.initState();
    var randomNum = new Random();
    for (var i = 0; i < 40; i++) {
      _num.add(50 + 150 * randomNum.nextDouble());
    }
    for (var i = 0; i < 40; i++) {
      if (i == 0 || i % 6 == 0)
        _waterFallList.add(216);
      else
        _waterFallList.add(294);
    }
    print(_num);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: MasonryGridView.count(
          // 展示几列
          crossAxisCount: 2,
          // 元素总个数
          itemCount: _waterFallList.length,
          // 单个子元素
          itemBuilder: (BuildContext context, int index) =>
              waterCard(_waterFallList[index]),
          // 纵向元素间距
          mainAxisSpacing: 10,
          // 横向元素间距
          crossAxisSpacing: 10,
          //本身不滚动，让外面的singlescrollview来滚动
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true, //收缩，让元素宽度自适应
        ),
      ),
    );
  }

  Widget waterCard(double item) {
    return Container(
      child: Column(children: [
        TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      live_detail(live_id: "123"),
                ),
              );
            },
            child: Container(
              height: item - 89,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                    'https://bkimg.cdn.bcebos.com/pic/b8389b504fc2d562853519cf964487ef76c6a7efc6c1?x-bce-process=image/resize,m_lfit,w_536,limit_1'),
              )),
            )),
        Container(
          height: 89,
          child: Column(
            children: [
              TextButton(
                  onPressed: null,
                  child: Text('标题',
                      style: TextStyle(
                        color: Color.fromRGBO(229, 237, 254, 1),
                        fontSize: 11,
                      ))),
              Container(
                //链接到相关剧目
                height: 38,
                alignment: Alignment.center,
                width: 150,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(8, 11, 32, 1),
                ),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: null,
                        child: Container(
                          alignment: Alignment.topLeft,
                          width: 21,
                          height: 27,
                          padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://bkimg.cdn.bcebos.com/pic/b8389b504fc2d562853519cf964487ef76c6a7efc6c1?x-bce-process=image/resize,m_lfit,w_536,limit_1'),
                                  fit: BoxFit.cover)),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("音乐剧《四两青春》",
                            style: TextStyle(
                              color: Color.fromRGBO(94, 112, 146, 1),
                              fontSize: 8,
                            )),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                          child: Row(children: [
                            Text("评分",
                                style: TextStyle(
                                  color: Color.fromRGBO(94, 112, 146, 1),
                                  fontSize: 8,
                                )),
                            Text("7.6",
                                style: TextStyle(
                                  color: Color.fromRGBO(240, 38, 96, 1),
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ))
                          ]),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
      height: item,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(161, 189, 245, 0.05),
      ),
    );
  }
}
