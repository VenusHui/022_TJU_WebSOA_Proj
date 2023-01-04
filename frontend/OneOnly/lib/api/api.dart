import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';
import '../utils/http.dart';

class Api {
  /// 登录接口 1
  static Future sign({
    UserLoginRequestEntity? params,
  }) async {
    return await HttpUtil().postForm(
      ':8000/users/token/',
      data: params?.toJson(),
    );
  }

  ///注册接口 1
  static Future register(
      String userName, String password, String phoneNumber) async {
    return await HttpUtil().postForm(':8000/users/', data: {
      'user_name': userName,
      'password': password,
      'phone_number': phoneNumber
    });
  }

  ///首页接口 1
  static Future home(String categories) async {
    return await HttpUtil().get(
      ':8001/shows/',
      queryParameters: {"categories": categories},
    );
  }

  ///根据showid 查询详情 1
  static Future showDetails(int id) async {
    return await HttpUtil().get(
      ':8001/shows/$id/',
    );
  }

  ///根据histrionics ID  查询histrionics相关的所有票档 1
  static Future histrionicsDetails(int histrionicsId) async {
    return await HttpUtil().get(
      ':8001/histrionics/$histrionicsId/ticket_stall/',
    );
  }

  ///查询演出相关的所有转卖数据 1
  static Future resaleList(int showId) async {
    return await HttpUtil().get(
      ':8001/shows/$showId/resale/',
    );
  }

  ///转卖票 0
  static Future resaleTicket(
      int userId, int ticketId, String resale_price) async {
    return await HttpUtil().postForm(
      ':8001/users/$userId/tickets/$ticketId/resale/',
      data: {"resale_price": resale_price},
    );
  }

  ///查询特定票档信息 0
  static Future ticketStall(int userId, int ticketStallId) async {
    return await HttpUtil().get(
      ':8001/users/$userId/ticket_stall/$ticketStallId',
    );
  }

  ///用户下单  1
  static Future userPlaceOrder(int userId, int ticketStallId, int ticketNum,
      List<String> viewersId) async {
    return await HttpUtil().post(':8001/users/$userId/orders/', data: {
      'ticket_stall_id': ticketStallId,
      'ticket_num': ticketNum,
      'viewers_id': viewersId
    });
  }

  ///查询用户有效的票据  1
  static Future validTicket(int userId) async {
    return await HttpUtil().get(
      ':8001/users/$userId/validTicket/',
    );
  }

  ///查询用户所有订单 1
  static Future getUserOrder(int userId) async {
    return await HttpUtil().get(
      ':8001/users/$userId/orders/',
    );
  }

  ///根据userId查询观影人 1
  static Future getRealViewer(String userId) async {
    return await HttpUtil().get(
      ':8000/users/$userId/realviewers/',
    );
  }

  ///添加观影人 1
  static Future addRealviewers(int userId, String number, String name) async {
    return await HttpUtil().postForm(':8000/realviewers/',
        data: {'user_id': userId, 'identity_number': number, 'name': name});
  }

  ///删除观影人

  ///查询指定用户信息 1
  static Future getUserInfo(int userId) async {
    return await HttpUtil().get(
      ':8000/users/$userId/',
    );
  }

  ///修改用户名 1
  static Future updataUserName(int userId, String name) async {
    return await HttpUtil()
        .put(':8000/users/$userId/name/', queryParameters: {"new_name": name});
  }

  ///修改用户所在城市 1
  static Future updataUserAddress(int userId, String city) async {
    return await HttpUtil()
        .put(':8000/users/$userId/city/', queryParameters: {"new_city": city});
  }

  ///修改用户头像
  static Future updataUserAvatar(int userId, String avatar) async {
    return await HttpUtil().put(':8000/users/$userId/avatar/',
        queryParameters: {"new_avatar": avatar});
  }

  ///查看用户所有的转卖 1
  static Future getUserAllResells(int userId) async {
    return await HttpUtil().get(
      ':8001/users/$userId/resale/',
    );
  }

  ///转卖票 1
  static Future postResells(int userId, int ticketId, int resalePrice) async {
    return await HttpUtil().post(
        ':8001/users/$userId/tickets/$ticketId/resale/',
        queryParameters: {'resale_price': resalePrice});
  }

  //查看全部sharings 1
  static Future getsharings() async {
    return await HttpUtil().get(
      ':8002/sharings/',
    );
  }

  ///查看指定sharing的评论 1
  static Future getsharComments(String sharingId) async {
    return await HttpUtil().get(':8002/sharings/$sharingId/comments/',
        queryParameters: {'filter': 'all', 'id': '0'});
  }

  ///查看指定分享 1
  static Future getsharDetails(String sharingId) async {
    return await HttpUtil().get(':8002/sharings/$sharingId/');
  }

  ///发表评论 1
  static Future addSharComment(
      String sharingId, int userId, String context) async {
    return await HttpUtil().postForm(':8002/sharings/$sharingId/comments/',
        data: {'user_id': userId, 'context': context});
  }

  ///购买转卖票 1
  static Future postResales(String resaleId, String userId) async {
    return await HttpUtil().post(
      ':8001/users/$userId/resales/$resaleId',
    );
  }

  ///查询用户有效的票据 1
  static Future getValidTicket(int userId) async {
    return await HttpUtil().get(
      ':8001/users/$userId/validTicket/',
    );
  }

  ///histrionics
  static Future getHistrionicShow(String histrionicsId) async {
    return await HttpUtil().get(
      ':8001/histrionics/$histrionicsId/show/',
    );
  }

  ///查询门票细节信息
  static Future getTicketsDetails(String userId, String ticketId) async {
    return await HttpUtil().get(
      ':8001/users/$userId/tickets/$ticketId/',
    );
  }

  ///上传文件
  static Future upload(XFile file) async {
    FormData formData = FormData.fromMap({
      'token': 'cdeec378679e437089a1be0b20359946',
      'files': [
        await MultipartFile.fromFile(file.path,
            filename: file.name,
            contentType: MediaType("image", file.name.split(".").last)),
      ]
    });
    return await HttpUtil().post(
      'https://api.superbed.cn/upload',
      data: formData,
    );
  }

  ///查询所有演出地点
  static Future getLocations() async {
    return await HttpUtil().get(
      ':8001/locations/',
    );
  }

  ///查询指定演出地点详情
  static Future getLocationDetails(String locationId) async {
    return await HttpUtil().get(
      ':8001/locations/$locationId/',
    );
  }

  ///查询地点相关演出
  static Future getLocationShows(String locationId) async {
    return await HttpUtil().get(
      ':8001/locations/$locationId/shows/',
    );
  }

  ///点赞指定分享
  static Future updataSharings(String sharingId, int likes) async {
    return await HttpUtil()
        .put(':8002/sharings/$sharingId/', queryParameters: {"likes": likes});
  }

  ///查看指定演出的地点
  static Future histrionicLocation(String histrionicsId) async {
    return await HttpUtil().get(':8001/histrionics/$histrionicsId/location/');
  }

  ///验票
  static Future ticketsCode(String userId, String tickets) async {
    return await HttpUtil().post(':8001/users/$userId/tickets/$tickets/');
  }

  ///查询所有场次
  static Future histrionicsAll() async {
    return await HttpUtil().get(':8001/histrionics/');
  }

  ///添加分享
  static Future addShare(
      int userId, int histrionicsId, String context, String imageUrl) async {
    return await HttpUtil().postForm(':8001/sharings/', data: {
      'user_id': userId,
      'histrionics_id': histrionicsId,
      'context': context,
      'image_url': imageUrl
    });
  }
}
