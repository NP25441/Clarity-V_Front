import 'dart:convert';

final url = "https://7eb5-202-80-249-133.ap.ngrok.io";


Data_Api data_ApiFromJson(String str) => Data_Api.fromJson(json.decode(str));

String data_ApiToJson(Data_Api data) => json.encode(data.toJson());

class Data_Api {
    Data_Api({
        this.licensePlate,
        this.date,
        this.timein,
        this.timeout,
        this.city,
        this.vehicle1,
        this.vehicle2,
        this.vehicle3,
        this.vehicle4,
        this.vehicle5,
        this.color,
    });

    String? licensePlate;
    String? date;
    String? timein;
    String? timeout;
    String? city;
    String? vehicle1;
    String? vehicle2;
    String? vehicle3;
    String? vehicle4;
    String? vehicle5;
    String? color;

    factory Data_Api.fromJson(Map<String, dynamic> json) => Data_Api(
        licensePlate: json["license_plate"],
        date: json["date"],
        timein: json["timein"],
        timeout: json["timeout"],
        city: json["city"],
        vehicle1: json["vehicle1"],
        vehicle2: json["vehicle2"],
        vehicle3: json["vehicle3"],
        vehicle4: json["vehicle4"],
        vehicle5: json["vehicle5"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "license_plate": licensePlate,
        "date": date,
        "timein": timein,
        "timeout": timeout,
        "city": city,
        "vehicle1": vehicle1,
        "vehicle2": vehicle2,
        "vehicle3": vehicle3,
        "vehicle4": vehicle4,
        "vehicle5": vehicle5,
        "color": color,
    };
}