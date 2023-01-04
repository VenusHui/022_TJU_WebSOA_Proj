import 'package:flutter/material.dart';
import 'package:oneonly/models/comments.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../models/api_response.dart';
import '../homepage/address_details.dart';

class live_detail extends StatefulWidget {
  String sharId;

  live_detail({Key? key, required this.sharId}) : super(key: key);

  @override
  State<live_detail> createState() => _live_detailState();
}

class _live_detailState extends State<live_detail> {
  _live_detailState();

  List<Comment> commentList = [];

  String commentsValue = '';

  late Map sharDetails = {};
  Map shows = {};

  late Map addressInfo = {};

  String histrionicsId = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    ///获取 shar详情
    Response detailsRes =
        Response.fromJson(await Api.getsharDetails(widget.sharId));
    setState(() {
      sharDetails = detailsRes.data;
      histrionicsId = sharDetails['histrionicsId'].toString();
    });

    ///查询show详情
    APIResponse showDetails = APIResponse.fromJson(
        await Api.getHistrionicShow(sharDetails['histrionicsId'].toString()));
    setState(() {
      shows = showDetails.data['shows'];
    });

    ///获取评论
    Response entity =
        Response.fromJson(await Api.getsharComments(widget.sharId));

    CommentListResponse res = CommentListResponse.fromJson(entity.data);
    setState(() {
      commentList.clear();
      commentList.addAll(res.content!);
    });

    ///查询演出地点
    Response addressRes =
        Response.fromJson(await Api.histrionicLocation(histrionicsId));
    setState(() {
      addressInfo = addressRes.data!;
    });
  }

  ///新增评论
  addSharComment() async {
    if (commentsValue.isEmpty) return;
    var userId = await getUserId();
    Response entity = Response.fromJson(await Api.addSharComment(
        widget.sharId, int.parse(userId), commentsValue));
    if (entity.status == 'success') {
      print(entity.message);
      getData();
    } else {
      print(entity.message);
    }
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
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(8, 11, 32, 1),
        title: const Text(
          '演出详情',
          style: TextStyle(fontSize: 16),
        ),
        leadingWidth: 60,
        leading: Row(
          children: [
            Container(
                child: IconButton(
              color: const Color.fromRGBO(161, 189, 245, 1),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color.fromRGBO(161, 189, 245, 1),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
            // TextButton(
            //   child: CircleAvatar(
            //       backgroundImage: AssetImage('assets/peeps-avatar.png')),
            //   onPressed: null,
            // ),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(8, 11, 32, 1),
        child: Column(children: [
          Container(
            height: 240,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(sharDetails['imageUrl'] ?? ''),
                    fit: BoxFit.cover)),
          ),
          Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 12),
            color: const Color.fromRGBO(161, 189, 245, 0.05),
            child: Text(
              sharDetails['context'] ?? '',
              style: const TextStyle(
                  color: Color.fromARGB(255, 116, 137, 183),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            //链接到相关剧目
            height: 61,
            margin:
                const EdgeInsets.only(left: 12, top: 6, bottom: 12, right: 12),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(161, 189, 245, 0.35),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 61,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(shows['image'] ?? ''),
                          fit: BoxFit.cover)),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(shows['title'] ?? '',
                          style: const TextStyle(
                            color: Color.fromRGBO(229, 234, 245, 1),
                            fontSize: 11,
                          )),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(children: const [
                        Text("评分",
                            style: TextStyle(
                              color: Color.fromRGBO(229, 234, 245, 1),
                              fontSize: 11,
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
          //演出地点
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 12),
            child: const Text(
              "演出地点",
              style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
            ),
          ),
          TextButton(
              child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 234,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                addressInfo['name'] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(addressInfo['description'] ?? ''),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      child: Image.network(
                        addressInfo['image'] ??
                            'https://pic.imgdb.cn/item/63b261bb5d94efb26fbe93aa.jpg',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => AddRessDetailsPage(
                      locationId: addressInfo['locationId'] ?? 0,
                      latitude: addressInfo['lng'] ?? 0.0,
                      longitude: addressInfo['lat'] ?? 0.0,
                    ),
                  ),
                );
              }),
          const SizedBox(
            height: 12,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 12),
            child: const Text(
              "精彩评论",
              style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: commentList.length,
                  itemBuilder: ((context, i) {
                    var item = commentList[i];
                    return _commentItem(item);
                  })))
          // SingleChildScrollView(
          //   child: Column(children: [
          //     for (int i = 0; i < commentList.length; i++)
          //       _commentItem(
          //         commentList[i].context!,
          //       ), //此处传入参数
          //   ]),
          // ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDi,
        backgroundColor: const Color.fromRGBO(240, 38, 96, 1),
        child: const Text(
          '评论',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
      ),
    );
  }

  void _showDi() {
    final top = 12.0;
    final txBottom = 40.0;
    final txHeight = 100.0;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx2, state) {
          return Container(
            height: MediaQuery.of(ctx2).viewInsets.bottom +
                txHeight +
                top +
                txBottom,
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Positioned(
                    left: 12,
                    bottom: (MediaQuery.of(ctx2).viewInsets.bottom < 0)
                        ? 0
                        : MediaQuery.of(ctx2).viewInsets.bottom,
                    right: 0,
                    top: top,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.all(8),
                                height: txHeight,
                                color: const Color.fromRGBO(229, 237, 254, 1),
                                child: TextField(
                                  // scrollPadding: EdgeInsets.zero,
                                  autofocus: true,
                                  maxLines: 4,
                                  onChanged: (value) {
                                    setState(() {
                                      commentsValue = value;
                                    });
                                  },
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(35, 35, 35, 1)),
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                      border: InputBorder.none),
                                ),
                              )),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                child: TextButton(
                                  //按钮点击发送
                                  onPressed: (() {
                                    Navigator.pop(context);
                                    addSharComment();
                                  }),
                                  child: const Text("发送",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color.fromRGBO(8, 11, 32, 1))),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          );
        });
      },
    );
  }
}

Widget _commentItem(Comment item) {
  return Container(
      width: 370,
      height: 60,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(161, 189, 245, 0.1),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: AssetImage('assets/peeps-avatar.png')),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              const Text(
                '昵称',
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1), fontSize: 14),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                item.context ?? '',
                style: const TextStyle(
                    color: Color.fromARGB(255, 186, 89, 89), fontSize: 12),
              ),
            ],
          )
        ],
      ));
}
