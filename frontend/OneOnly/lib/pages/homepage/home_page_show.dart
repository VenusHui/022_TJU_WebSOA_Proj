import 'package:flutter/material.dart';
import 'package:oneonly/api/api.dart';
import 'package:oneonly/models/locations.dart';
import 'package:oneonly/pages/homepage/address_details.dart';
import '../../models/api_response.dart';
import '../../models/home.dart';
import '../performance/PerformanceDetail.dart';

Gradient gradient = const LinearGradient(
  colors: [
    Color.fromRGBO(238, 72, 120, 1),
    Color.fromRGBO(246, 9, 78, 1),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
Shader shader = gradient.createShader(Rect.fromLTWH(0, 0, 60, 20));

class home_page_show extends StatefulWidget {
  String title;

  home_page_show({Key? key, required this.title}) : super(key: key);

  @override
  State<home_page_show> createState() => _home_page_showState();
}

class _home_page_showState extends State<home_page_show> {
  List<Home> homeList = [];

  List<Location> locationList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    //获取演出数据
    APIResponse entity = APIResponse.fromJson(await Api.home('电影'));

    HomeListResponse homeRes = HomeListResponse.fromJson(entity.data);
    setState(() {
      homeList.clear();
      homeList.addAll(homeRes.content!);
    });

    LocationsResponse locaRes =
        LocationsResponse.fromJson(await Api.getLocations());
    setState(() {
      locationList.clear();
      locationList.addAll(locaRes.data!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          width: 310,
          height: 133,
          margin: const EdgeInsets.all(18.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(161, 189, 245, 0.5),
                offset: Offset(0, 0),
                blurStyle: BlurStyle.normal,
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
            image: DecorationImage(
                image: AssetImage('assets/IMG_1737.JPG'), fit: BoxFit.cover),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
          child: Text(
            "近期上演",
            style:
                TextStyle(foreground: Paint()..shader = shader, fontSize: 13),
          ),
        ),
        SizedBox(
            height: 110,
            child: Wrap(
              spacing: 2, //主轴上子控件的间距
              runSpacing: 5,
              children: homeItem(),
            )),
        Container(
          height: 20,
        ),

        ///演出地点
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
          child: Text(
            "演出地点",
            style:
                TextStyle(foreground: Paint()..shader = shader, fontSize: 13),
          ),
        ),
        SizedBox(
            child: Wrap(
          spacing: 2,
          runSpacing: 5,
          children: locationItem(),
        )),
      ],
    ));
  }

  List<Widget> homeItem() => List.generate(homeList.length, (index) {
        return TextButton(
            child: Container(
              width: 78,
              height: 101,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                image: DecorationImage(
                    image: NetworkImage(homeList[index].image!),
                    fit: BoxFit.cover),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => PerformanceDetail(
                    showId: homeList[index].showId ?? 1,
                  ),
                ),
              );
            });
      });

  List<Widget> locationItem() => List.generate(locationList.length, (index) {
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
                              locationList[index].name ?? '',
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
                                '地址: ${locationList[index].description ?? ''}'),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    child: Image.network(
                      locationList[index].image ??
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
                    locationId: locationList[index].locationId ?? 0,
                    latitude: locationList[index].lng ?? 0.0,
                    longitude: locationList[index].lat ?? 0.0,
                  ),
                ),
              );
            });
      });
}
