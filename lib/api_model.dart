import 'dart:convert';

final url = "https://4309-2001-fb1-10b-d49b-59e5-6664-7d03-f4de.ap.ngrok.io";

List<Data_Api> data_ApiFromJson(String str) => List<Data_Api>.from(json.decode(str).map((x) => Data_Api.fromJson(x)));

String data_ApiToJson(List<Data_Api> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Data_Api {
    Data_Api({
        this.id,
        this.data_ApiId,
        this.licensePlate,
        this.name,
        this.city,
        this.vehicle,
        this.carImgType,
        this.color,
        this.colorCode,
        this.time,
        this.date,
        this.imgCar,
        this.imgPlate,
        this.video,
    });

    String? id;
    int? data_ApiId;
    String? licensePlate;
    String? name;
    String? city;
    String? vehicle;
    String? carImgType;
    String? color;
    String? colorCode;
    String? time;
    String? date;
    String? imgCar;
    String? imgPlate;
    String? video;

    factory Data_Api.fromJson(Map<String, dynamic> json) => Data_Api(
        id: json["_id"],
        data_ApiId: json["id"],
        licensePlate: json["license_plate"],
        name: json["name"],
        city: json["city"],
        vehicle: json["vehicle"],
        carImgType: json["car_img_type"],
        color: json["color"],
        colorCode: json["color_code"],
        time: json["time"],
        date: json["date"],
        imgCar: json["img_car"],
        imgPlate: json["img_plate"],
        video: json["video"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "id": data_ApiId,
        "license_plate": licensePlate,
        "name": name,
        "city": city,
        "vehicle": vehicle,
        "car_img_type": carImgType,
        "color": color,
        "color_code": colorCode,
        "time": time,
        "date": date,
        "img_car": imgCar,
        "img_plate": imgPlate,
        "video": video,
    };
}