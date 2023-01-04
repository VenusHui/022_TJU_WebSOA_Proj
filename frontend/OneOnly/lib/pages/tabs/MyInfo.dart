import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oneonly/models/file.dart';
import 'package:oneonly/pages/tabs/OrderSpecific.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../models/api_response.dart';
import '../../utils/assets_picker.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({super.key});

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  var imgUrl = "https://7n.w3cschool.cn/statics/images/logonew2.png";

  late Map userInfo = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var userId = await getUserId();
    Response entity =
        Response.fromJson(await Api.getUserInfo(int.parse(userId)));
    setState(() {
      userInfo = entity.data;
    });
  }

  //修改用户名
  updataUserName(String userName) async {
    var userId = await getUserId();
    Response entity = Response.fromJson(
        await Api.updataUserName(int.parse(userId), userName));
    print(entity.message);
  }

  //修改城市
  updataCity(String city) async {
    var userId = await getUserId();
    Response entity =
        Response.fromJson(await Api.updataUserAddress(int.parse(userId), city));
    print(entity.message);
  }

  ///修改头像
  updataAvatar(String avatar) async {
    var userId = await getUserId();
    Response entity = Response.fromJson(
        await Api.updataUserAvatar(int.parse(userId), avatar));
    if (entity.status == 'success') {
      EasyLoading.showSuccess(entity.message!);
      getData();
    } else {}
    print(entity.message);
  }

  Future<String> getUserId() async {
    String? userId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    return userId ?? '';
  }

  ///相册
  void _upload() async {
    final assets = await AssetsPickers.image(
      context: context,
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
    );
    if (assets == null) return;
    FileResponse fileResponse =
        FileResponse.fromJson(await Api.upload(assets[0]));
    if (fileResponse.err == 0) {
      print('上传成功');
      print(fileResponse.url);
      updataAvatar(fileResponse.url!);
    } else {
      EasyLoading.showError(fileResponse.msg!);
    }
  }

  ///相机
  void _uploadCamera() async {
    final assets = await AssetsPickers.cameraImage(
      context: context,
      source: ImageSource.camera,
      maxWidth: 512,
      maxHeight: 512,
    );
    if (assets == null) return;
    FileResponse fileResponse = FileResponse.fromJson(await Api.upload(assets));
    if (fileResponse.err == 0) {
      print('上传成功');
      print(fileResponse.url);
      updataAvatar(fileResponse.url!);
    } else {
      EasyLoading.showError(fileResponse.msg!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 背景图片
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/mine-bg.png'),
        ),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 头像
          GestureDetector(
            onTap: () {
              _selectImgDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 53, bottom: 10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.network(userInfo['avatar'] ?? imgUrl,
                      width: 70, height: 70, fit: BoxFit.fill)),
            ),
          ),
          // 用户名
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              '${userInfo['userName'] ?? ''}',
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          // 我的订单-观演人-个人信息，信誉分
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              // 返回上一页
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 返回按钮
                GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Color(0xFFA8C5FF),
                  ),
                  onTap: () {
                    // 返回上一步
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // 我的订单列表
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 昵称盒子
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: FractionallySizedBox(
                  alignment: Alignment.center,
                  // 宽度因子 1为占满整行
                  widthFactor: 0.9,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 49,
                    decoration: const BoxDecoration(
                      color: Color(0x0cA1BDF5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 昵称、昵称内容
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // 昵称
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 85,
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text(
                                '昵称',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xFF536383),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            // 昵称内容
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${userInfo['userName']}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // 箭头按钮
                        GestureDetector(
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Color(0xFFA8C5FF),
                          ),
                          onTap: () {
                            // 返回上一步
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 登录密码
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: FractionallySizedBox(
                  alignment: Alignment.center,
                  // 宽度因子 1为占满整行
                  widthFactor: 0.9,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 49,
                    decoration: const BoxDecoration(
                      color: Color(0x0cA1BDF5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 登录密码
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // 登录密码
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 85,
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text(
                                '登录密码',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xFF536383),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            // 登录密码内容
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                ' ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // 箭头按钮
                        GestureDetector(
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Color(0xFFA8C5FF),
                          ),
                          onTap: () {
                            // 返回上一步
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 常驻城市
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: FractionallySizedBox(
                  alignment: Alignment.center,
                  // 宽度因子 1为占满整行
                  widthFactor: 0.9,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 49,
                    decoration: const BoxDecoration(
                      color: Color(0x0cA1BDF5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 常驻城市
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // 常驻城市
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 85,
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text(
                                '常驻城市',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xFF536383),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            // 常驻城市内容
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${userInfo['city']}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // 箭头按钮
                        GestureDetector(
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Color(0xFFA8C5FF),
                          ),
                          onTap: () {
                            // 返回上一步
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _selectImgDialog(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: ((context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: (() {
                  Navigator.pop(context);
                  _uploadCamera();
                }),
                child: const Text(
                  "相机",
                  style: TextStyle(
                      fontSize: 12,
                      color: const Color.fromRGBO(50, 50, 51, 1),
                      fontWeight: FontWeight.w400),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: (() {
                  Navigator.pop(context);
                  _upload();
                }),
                child: const Text(
                  "相册",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(50, 50, 51, 1),
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: (() {
                Navigator.pop(context);
              }),
              isDefaultAction: true,
              child: const Text(
                "取消",
                style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(50, 50, 51, 1),
                    fontWeight: FontWeight.w400),
              ),
            ),
          );
        }));
  }
}
