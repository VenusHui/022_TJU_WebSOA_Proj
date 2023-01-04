class RealviewerListResponse {
  List<Realviewer>? content;

  RealviewerListResponse({
    this.content,
  });

  factory RealviewerListResponse.fromJson(Map<String, dynamic> json) =>
      RealviewerListResponse(
        content: json["content"] == null
            ? []
            : List<Realviewer>.from(
                json["content"].map((x) => Realviewer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": content == null
            ? []
            : List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

///观演人
class Realviewer {
  int? userId;
  String? identityNumber;
  String? phoneNumber;
  String? name;
  bool? isSelectFlag = false;
  // String? links;
  Realviewer({
    this.userId,
    this.identityNumber,
    this.phoneNumber,
    this.name,
    // this.links,
  });

  factory Realviewer.fromJson(Map<String, dynamic> json) => Realviewer(
        userId: json["userId"],
        identityNumber: json["identityNumber"],
        phoneNumber: json["phoneNumber"],
        name: json["name"],
        // links: json["links"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "identityNumber": identityNumber,
        "phoneNumber": phoneNumber,
        "name": name,
      };
}
