class Response {
  Response({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  // ignore: unnecessary_question_mark
  dynamic? data;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}

class APIResponse {
  APIResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  int? message;
  // ignore: unnecessary_question_mark
  dynamic? data;

  factory APIResponse.fromJson(Map<String, dynamic> json) => APIResponse(
        status: json["status"] ?? '',
        message: json["message"] ?? '',
        data: json["data"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
