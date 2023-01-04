import 'dart:ui';
import 'dart:math';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter/material.dart';
import 'package:oneonly/models/sharing.dart';
import '../../api/api.dart';
import '../../models/api_response.dart';
import 'live_detail.dart';

class live_page_show extends StatefulWidget {
  const live_page_show({super.key});

  @override
  State<live_page_show> createState() => _live_page_showState();
}

class _live_page_showState extends State<live_page_show> {
  @override
  List<Shar> waterFallList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    Response entity = Response.fromJson(await Api.getsharings());

    SharListResponse res = SharListResponse.fromJson(entity.data);
    setState(() {
      waterFallList.clear();
      waterFallList.addAll(res.content!);
    });

    ///根据 histrionicsId 查询show
    waterFallList.forEach((e) async {
      APIResponse entity = APIResponse.fromJson(
          await Api.getHistrionicShow(e.histrionicsId.toString()));
      setState(() {
        e.shows = entity.data['shows'];
      });
    });
  }

  Future<bool> updataShareLink(String id, int likes) async {
    Response response =
        Response.fromJson(await Api.updataSharings(id, likes + 1));
    if (response.status == 'success') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: waterFallList.isEmpty
            ? const SizedBox()
            : MasonryGridView.count(
                // 展示几列
                crossAxisCount: 2,
                // 元素总个数
                itemCount: waterFallList.length,
                // 单个子元素
                itemBuilder: (BuildContext context, int index) =>
                    waterCard(waterFallList[index], index),
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

  Widget waterCard(Shar item, int index) {
    return GestureDetector(
        onTap: (() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => live_detail(
                sharId: item.id ?? '',
              ),
            ),
          );
        }),
        child: Container(
          padding: EdgeInsets.only(
              top: index % 2 == 0 ? 20 : 30, bottom: index % 2 == 0 ? 20 : 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromRGBO(161, 189, 245, 0.05),
          ),
          child: Column(children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(item.imageUrl!),
              )),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(item.context!,
                style: const TextStyle(
                  color: Color.fromRGBO(229, 237, 254, 1),
                  fontSize: 11,
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
              //链接到相关剧目
              height: 38,
              alignment: Alignment.center,
              width: 150,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(8, 11, 32, 1),
              ),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: 21,
                    height: 27,
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(item.shows?['image'] ?? ''),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.shows?['title'] ?? '',
                          style: const TextStyle(
                            color: Color.fromRGBO(94, 112, 146, 1),
                            fontSize: 8,
                          )),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Row(children: const [
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
            ),
            InkWell(
                onTap: (() async {
                  if (item.isLike) return;
                  var isBool = false;
                  isBool = await updataShareLink(item.id!, item.likes!);
                  if (isBool) {
                    setState(() {
                      item.isLike = true;
                    });
                  }
                }),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 12, top: 12),
                  child: Image.asset(
                    item.isLike ? 'assets/dz_select.png' : 'assets/dz_icon.png',
                    width: 22,
                    height: 22,
                  ),
                ))
          ]),
        ));
  }
}
