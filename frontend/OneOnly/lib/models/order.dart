class OrderListResponse {
  List<Order>? content;

  OrderListResponse({
    this.content,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) =>
      OrderListResponse(
        content: json["content"] == null
            ? []
            : List<Order>.from(json["content"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": content == null
            ? []
            : List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

///订单
class Order {
  int? userId;
  int? orderId;
  int? histrionicsId;
  String? orderTime;
  String? payTime;
  int? status;
  double? price;
  Map? shows;
  Map? histrionics;

  Order(
      {this.userId,
      this.orderId,
      this.histrionicsId,
      this.orderTime,
      this.payTime,
      this.status,
      this.shows,
      this.histrionics,
      this.price});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      userId: json["userId"],
      orderId: json["orderId"],
      histrionicsId: json['histrionicsId'],
      orderTime: json["orderTime"],
      payTime: json["payTime"],
      status: json['status'],
      price: json['price'],
      histrionics: json['histrionics'],
      shows: json['shows']);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "orderId": orderId,
        "orderTime": orderTime,
        "payTime": payTime,
        "status": status,
        "histrionicsId": histrionicsId,
        "price": price,
        "histrionics": histrionics,
        "shows": shows,
      };
}
