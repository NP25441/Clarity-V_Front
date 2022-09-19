import 'dart:convert';

final url = "https://4e86-27-145-28-135.ap.ngrok.io";

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
        this.name,
        this.carImgType,
        this.colorCode,
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
    String? name;
    String? carImgType;
    String? colorCode;

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
        name: json["name"],
        carImgType: json["car_img_type"],
        colorCode: json["color_code"],
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
        "name": name,
        "car_img_type": carImgType,
        "color_code": colorCode,
    };
}
