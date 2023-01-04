import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:oneonly/api/api.dart';

import '../../models/api_response.dart';

class AddRessDetailsPage extends StatefulWidget {
  int locationId;
  double latitude = 31.358886;
  double longitude = 121.271698;

  AddRessDetailsPage(
      {Key? key,
      required this.locationId,
      required this.latitude,
      required this.longitude})
      : super(key: key);

  @override
  State<AddRessDetailsPage> createState() => _AddRessDetailsPageState();
}

class _AddRessDetailsPageState extends State<AddRessDetailsPage> {
  Map address = {};

  late BMFMapOptions mapOptions = BMFMapOptions(
    center: BMFCoordinate(widget.latitude, widget.longitude),
    zoomLevel: 18,
    zoomEnabledWithTap: true,
    scrollEnabled: true,
    showMapScaleBar: true,
  );

  List<dynamic> showList = [];
  List<dynamic> histrionics = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    Response response = Response.fromJson(
        await Api.getLocationDetails(widget.locationId.toString()));
    setState(() {
      address = response.data;
    });

    APIResponse showRes = APIResponse.fromJson(
        await Api.getLocationShows(widget.locationId.toString()));
    setState(() {
      showList.addAll(showRes.data);
    });
  }

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('地点详情')),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: [
                //图片
                Container(
                  height: 160,
                  width: 160,
                  margin: const EdgeInsets.all(8),
                  child: Image.network(
                    address['image'] ??
                        'https://pic.imgdb.cn/item/63b261bb5d94efb26fbe93aa.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(
                  children: [
                    //标题
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        address['name'] ?? '名称',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    //地点详情
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        address['description'] ?? '地址:',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ))
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            //相关演出
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 12),
              child: const Text(
                "相关演出",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
                child: Wrap(
              spacing: 2,
              runSpacing: 5,
              children: showItem(),
            )),
            //地图
            const SizedBox(
              height: 12,
            ),

            Container(
              height: 200,
              child: BMFMapWidget(
                onBMFMapCreated: (controller) {
                  BMFMarker marker = BMFMarker.icon(
                      position: BMFCoordinate(32.0520493, 118.8132045),
                      isOpenCollisionDetection: true,
                      collisionDetectionPriority: 10,
                      subtitle: 'test',
                      identifier: 'flutter_marker',
                      icon: 'images/icon_ugc_end.png');
                  controller.addMarker(marker);
                },
                mapOptions: mapOptions,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        )));
  }

  List<Widget> showItem() => List.generate(showList.length, (index) {
        return TextButton(
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
                              showList[index][0]['title'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              showList[index][0]['description'] ?? '',
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                showList[index][1]['startTime'] ?? '00:00:00'),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    child: Image.network(
                      showList[index][0]['image'] ??
                          'https://pic.imgdb.cn/item/63b261bb5d94efb26fbe93aa.jpg',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
            onPressed: () {
              print('点击了演出');
            });
      });
}
