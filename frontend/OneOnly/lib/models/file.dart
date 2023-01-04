class FileResponse {
  FileResponse({this.err, this.url, this.msg});

  int? err;
  String? url;
  String? msg;

  factory FileResponse.fromJson(Map<String, dynamic> json) =>
      FileResponse(err: json["err"], url: json["url"], msg: json["msg"]);

  Map<String, dynamic> toJson() => {
        "err": err,
        "url": url,
        "msg": msg,
      };
}

class FileModel {
  String? fileName;
  String? path;
  String? size;
  int? type;

  FileModel({
    this.fileName,
    this.path,
    this.size,
    this.type,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        fileName: json["fileName"],
        path: json["path"],
        size: json['size'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "path": path,
        "size": size,
        "type": type,
      };
}
