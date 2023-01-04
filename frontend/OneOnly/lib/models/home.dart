class HomeListResponse {
  List<Home>? content;

  HomeListResponse({
    this.content,
  });

  factory HomeListResponse.fromJson(Map<String, dynamic> json) =>
      HomeListResponse(
        content: json["content"] == null
            ? []
            : List<Home>.from(json["content"].map((x) => Home.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": content == null
            ? []
            : List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

///首页
class Home {
  int? showId;
  String? title;
  String? description;
  String? image;
  String? categories;
  // String? links;
  Home({
    this.showId,
    this.title,
    this.description,
    this.image,
    this.categories,
    // this.links,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        showId: json["showId"],
        title: json["title"],
        description: json["description"],
        categories: json["categories"],
        image: json["image"],
        // links: json["links"],
      );

  Map<String, dynamic> toJson() => {
        "showId": showId,
        "title": title,
        "description": description,
        "categories": categories,
        "image": image,
        // "links": links == null
        //     ? []
        //     : List<dynamic>.from(links!.map((x) => x.toJson())),
      };
}
