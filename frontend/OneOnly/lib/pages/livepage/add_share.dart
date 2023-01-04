import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oneonly/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/api_response.dart';
import '../../models/file.dart';
import '../../utils/assets_picker.dart';

class AddSharePage extends StatefulWidget {
  const AddSharePage({super.key});

  @override
  State<AddSharePage> createState() => _AddSharePageState();
}

class _AddSharePageState extends State<AddSharePage> {
  List<dynamic> hisList = [];

  int hisId = 0;
  String hisName = '选择相关演出';
  String content = '';
  String imgUrl =
      'https://bkimg.cdn.bcebos.com/pic/b8389b504fc2d562853519cf964487ef76c6a7efc6c1?x-bce-process=image/resize,m_lfit,w_536,limit_1';

  List<String> accessory = [];

  @override
  void initState() {
    super.initState();
    getAllHis();
  }

  getAllHis() async {
    APIResponse apiResponse = APIResponse.fromJson(await Api.histrionicsAll());
    setState(() {
      hisList.addAll(apiResponse.data);
    });
  }

  Future<String> getUserId() async {
    String? userId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    return userId ?? '';
  }

  addShare() async {
    if (content.isEmpty) {
      EasyLoading.showError('请输入内容');
      return;
    }
    if (imgUrl.isEmpty) {
      EasyLoading.showError('请上传照片');
      return;
    }
    var userId = await getUserId();
    Response response = Response.fromJson(
        await Api.addShare(int.parse(userId), hisId, content, imgUrl));
    if (response.status == 'success') {
      EasyLoading.showSuccess('添加分享成功');
    } else {
      EasyLoading.showError(response.message!);
    }
  }

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
      setState(() {
        accessory.add(fileResponse.url!);
      });
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
      setState(() {
        accessory.add(fileResponse.url!);
      });
    } else {
      EasyLoading.showError(fileResponse.msg!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('添加分享')),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          //内容
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('内容',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(128, 128, 128, 1))),
                ),
                const SizedBox(
                  height: 11,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    maxLines: null,
                    minLines: 2,
                    onChanged: ((value) {
                      setState(() {
                        content = value;
                      });
                    }),
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.2,
                    ),
                    maxLength: 1000,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: "请输入",
                      hintStyle: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(155, 158, 174, 1)),
                    ),
                  ),
                )
              ],
            ),
          ),
          //选择相关演出
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            height: 48.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('选择相关演出',
                    style: TextStyle(
                        fontSize: 12, color: Color.fromRGBO(128, 128, 128, 1))),
                InkWell(
                  onTap: (() {
                    //选择相关演出
                    _selectHis(context);
                  }),
                  child: Text(hisName,
                      style: const TextStyle(
                          fontSize: 12, color: Color.fromRGBO(11, 83, 228, 1))),
                )
              ],
            ),
          ),
          //图片
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            height: 48.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('现场照片',
                    style: TextStyle(
                        fontSize: 12, color: Color.fromRGBO(128, 128, 128, 1))),
                InkWell(
                  onTap: (() {
                    //上传照片
                    _selectImgDialog(context);
                  }),
                  child: const Text('上传',
                      style: TextStyle(
                          fontSize: 12, color: Color.fromRGBO(11, 83, 228, 1))),
                )
              ],
            ),
          ),
          Visibility(
            visible: accessory.isNotEmpty,
            child: Container(
                height: 80,
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: accessory.length,
                          itemBuilder: ((context, index) {
                            return _selectImgItem(accessory[index]);
                          })),
                    )
                  ],
                )),
          ),
          const SizedBox(
            height: 100,
          ),
          //提交按钮
          GestureDetector(
              onTap: (() {
                addShare();
              }),
              child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(11, 83, 228, 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                  child: const Text(
                    '提交',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ))),
        ],
      )),
    );
  }

  void _selectHis(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            height: 350,
            child: ListView.builder(
                itemCount: hisList.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                      onTap: () {
                        setState(() {
                          hisId = hisList[index]['histrionicsId'] ?? 1;
                          hisName = hisList[index]['description'] ?? '';
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        height: 42,
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey))),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                hisList[index]['description'] ?? '',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                hisList[index]['startTime'] ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ));
                })),
          );
        }));
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

  Widget _selectImgItem(String url) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      width: 96,
      height: 96,
      child: Stack(children: [
        Positioned(
            child: Image.network(
          url,
          width: 96,
          height: 96,
          fit: BoxFit.cover,
        )),
        Positioned(
            right: 4,
            top: 4,
            child: InkWell(
              onTap: (() {
                print('111');
              }),
              child: Image.asset(
                'assets/images/clear_img.png',
                width: 18,
                height: 18,
              ),
            ))
      ]),
    );
  }
}
