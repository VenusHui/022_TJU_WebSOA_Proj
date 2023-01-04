class SharListResponse {
  List<Shar>? content;

  SharListResponse({
    this.content,
  });

  factory SharListResponse.fromJson(Map<String, dynamic> json) =>
      SharListResponse(
        content: json["content"] == null
            ? []
            : List<Shar>.from(json["content"].map((x) => Shar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": content == null
            ? []
            : List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

class Shar {
  String? id;
  int? histrionicsId;
  int? userId;
  String? context;
  String? imageUrl;
  int? stars;
  int? likes;
  String? shareDate;
  bool isLike = false;
  Map? shows = {};
  Shar({
    this.id,
    this.histrionicsId,
    this.userId,
    this.context,
    this.imageUrl,
    this.stars,
    this.likes,
    this.shareDate,
    this.shows,
  });

  factory Shar.fromJson(Map<String, dynamic> json) => Shar(
        id: json["_id"],
        histrionicsId: json["histrionicsId"],
        userId: json["userId"],
        context: json["context"],
        imageUrl: json["imageUrl"],
        stars: json["stars"],
        likes: json['likes'],
        shareDate: json['shareDate'],
        shows: json["shows"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "histrionicsId": histrionicsId,
        "userId": userId,
        "context": context,
        "imageUrl": imageUrl,
        "stars": stars,
        "likes": likes,
        "shows": shows,
      };
}
