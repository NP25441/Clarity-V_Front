final url = "https://1979-202-80-249-194.ap.ngrok.io";

class Data_Api {
  String? license_plate;
  String? name;
  String? city;
  String? type_car;
  String? speed;
  String? color;

  Data_Api(
      {this.license_plate,
       this.name,
       this.city,
       this.type_car,
       this.speed,
       this.color});

  Data_Api.fromJSON(Map<String, dynamic> json) {
    this.license_plate = json["license_plate"];
    this.name = json["name"];
    this.city = json["city"];
    this.type_car = json["type_car"];
    this.speed = json["speed"];
    this.color = json["color"];
  }
}