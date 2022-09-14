// To parse this JSON data, do
//
//     final dataApi = dataApiFromJson(jsonString);

import 'dart:convert';

final url = "https://6dd0-202-80-249-150.ap.ngrok.io";

Data_Api dataApiFromJson(String str) => Data_Api.fromJson(json.decode(str));

String dataApiToJson(Data_Api data) => json.encode(data.toJson());

class Data_Api {
    Data_Api({
        this.status,
        this.plate,
    });

    String? status;
    Plate? plate;

    factory Data_Api.fromJson(Map<String, dynamic> json) => Data_Api(
        status: json["status"],
        plate: Plate.fromJson(json["plate"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "plate": plate!.toJson(),
    };
}

class Plate {
    Plate({
        this.id,
        this.plateId,
        this.licensePlate,
        this.city,
        this.vehicle,
        this.color,
        this.time,
        this.date,
    });

    String? id;
    int? plateId;
    String? licensePlate;
    String? city;
    String? vehicle;
    String? color;
    String? time;
    String? date;

    factory Plate.fromJson(Map<String, dynamic> json) => Plate(
        id: json["_id"],
        plateId: json["id"],
        licensePlate: json["license_plate"],
        city: json["city"],
        vehicle: json["vehicle"],
        color: json["color"],
        time: json["time"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "id": plateId,
        "license_plate": licensePlate,
        "city": city,
        "vehicle": vehicle,
        "color": color,
        "time": time,
        "date": date,
    };
}
