class LocationsResponse {
  LocationsResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  int? message;
  // ignore: unnecessary_question_mark
  List<Location>? data;

  factory LocationsResponse.fromJson(Map<String, dynamic> json) =>
      LocationsResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Location>.from(
                json["data"].map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Location {
  int? locationId;
  String? name;
  String? description;
  String? image;
  String? locationType;
  double? lat;
  double? lng;

  Location({
    this.locationId,
    this.name,
    this.description,
    this.image,
    this.locationType,
    this.lat,
    this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        locationId: json["locationId"],
        name: json["name"],
        description: json['description'],
        image: json["image"],
        locationType: json["locationType"],
        lat: json['lat'],
        lng: json['lng'],
      );

  Map<String, dynamic> toJson() => {
        "locationId": locationId,
        "name": name,
        "description": description,
        "image": image,
        "locationType": locationType,
        "lat": lat,
        "lng": lng,
      };
}
