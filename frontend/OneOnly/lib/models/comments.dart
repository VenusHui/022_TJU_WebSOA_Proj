class CommentListResponse {
  List<Comment>? content;

  CommentListResponse({
    this.content,
  });

  factory CommentListResponse.fromJson(Map<String, dynamic> json) =>
      CommentListResponse(
        content: json["content"] == null
            ? []
            : List<Comment>.from(
                json["content"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": content == null
            ? []
            : List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

class Comment {
  int? user_id;
  String? context;
  String? comment_time;
  int? likes;

  Comment({
    this.user_id,
    this.context,
    this.comment_time,
    this.likes,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        user_id: json["user_id"],
        context: json["context"],
        comment_time: json["comment_time"],
        likes: json["likes"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "context": context,
        "comment_time": comment_time,
        "likes": likes,
      };
}
