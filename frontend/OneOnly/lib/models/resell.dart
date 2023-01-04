class ResellListResponse {
  String? status;
  int? message;
  List<Resell>? data;

  ResellListResponse({
    this.data,
    this.status,
    this.message,
  });

  factory ResellListResponse.fromJson(Map<String, dynamic> json) =>
      ResellListResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Resell>.from(json["data"].map((x) => Resell.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

///票夹列表
class Resell {
  int? ticketId;
  int? ticketStallId;
  String? identityNumber;
  int? seat;
  int? status;
  Map? shows = {};
  Map? histrionics = {};
  Map? ticketStall = {};

  Resell(
      {this.ticketId,
      this.ticketStallId,
      this.identityNumber,
      this.seat,
      this.shows,
      this.histrionics,
      this.ticketStall,
      this.status});

  factory Resell.fromJson(Map<String, dynamic> json) => Resell(
      ticketId: json["ticketId"],
      ticketStallId: json["ticketStallId"],
      identityNumber: json["identityNumber"],
      seat: json["seat"],
      shows: json['shows'],
      histrionics: json['histrionics'],
      ticketStall: json['ticket_stall'],
      status: json['status']);

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "ticketStallId": ticketStallId,
        "identityNumber": identityNumber,
        "seat": seat,
        "status": status,
        "shows": shows,
        "histrionics": histrionics,
        "ticket_stall": ticketStall
      };
}
