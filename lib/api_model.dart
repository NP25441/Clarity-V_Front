import 'dart:convert';

final url = "https://d721-2001-fb1-108-c52a-a809-ef4c-5d24-f359.ap.ngrok.io";

List<Data_Api> data_ApiFromJson(String str) => List<Data_Api>.from(json.decode(str).map((x) => Data_Api.fromJson(x)));

String data_ApiToJson(List<Data_Api> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Data_Api {
    Data_Api({
        this.id,
        this.data_ApiId,
        this.licensePlate,
        this.city,
        this.vehicle,
        this.color,
        this.time,
        this.date,
        this.img,
    });

    String? id;
    int? data_ApiId;
    String? licensePlate;
    String? city;
    String? vehicle;
    String? color;
    String? time;
    String? date;
    String? img;

    factory Data_Api.fromJson(Map<String, dynamic> json) => Data_Api(
        id: json["_id"],
        data_ApiId: json["id"],
        licensePlate: json["license_plate"],
        city: json["city"],
        vehicle: json["vehicle"],
        color: json["color"],
        time: json["time"],
        date: json["date"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "id": data_ApiId,
        "license_plate": licensePlate,
        "city": city,
        "vehicle": vehicle,
        "color": color,
        "time": time,
        "date": date,
        "img": img,
    };
}
