import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:bruno/bruno.dart';
import './pages/tabs.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFMapSDK, BMF_COORD_TYPE;
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';

void main() {
  runApp(const MyApp());

  ///初始化弹框
  configLoading();

  initMap();
}

void initMap() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 设置用户是否同意SDK隐私协议
  BMFMapSDK.setAgreePrivacy(true);

  // 百度地图sdk初始化鉴权
  if (Platform.isIOS) {
    BMFMapSDK.setApiKeyAndCoordType(
        '5YfqeSB9mGO7iijlcKqE3NqnnzrTazvc', BMF_COORD_TYPE.BD09LL);
  } else if (Platform.isAndroid) {
    await BMFAndroidVersion.initAndroidVersion();
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  }
  Map? map = await BMFMapVersion.nativeMapVersion;
  print('获取原生地图版本号：$map');
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'oneonly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Tabs(),
    );
  }
}
