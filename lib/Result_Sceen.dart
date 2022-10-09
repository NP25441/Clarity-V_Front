import 'dart:core';
import 'package:clarity_v/Search_Screen.dart';
import 'package:clarity_v/Video_Screen.dart';
import 'package:clarity_v/flutter%20flow/flutter_flow_theme.dart';
import 'package:clarity_v/flutter%20flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'api_model.dart';

class ResultScreenWidget extends StatefulWidget {
  final String license_plate;
  final String city;
  final String search_plate;
  final List type_car;
  final String color;
  final String type_car_data_1;
  final String type_car_data_2;
  final String type_car_data_3;
  final String type_car_data_4;
  final String date;
  final String time_in;
  final String time_out;
  const ResultScreenWidget({
    Key? key,
    required this.license_plate,
    required this.city,
    required this.search_plate,
    required this.type_car,
    required this.color,
    required this.type_car_data_1,
    required this.type_car_data_2,
    required this.type_car_data_3,
    required this.type_car_data_4,
    required this.date,
    required this.time_in,
    required this.time_out,
  }) : super(key: key);

  @override
  _ResultScreenWidgetState createState() => _ResultScreenWidgetState();
}

class _ResultScreenWidgetState extends State<ResultScreenWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<Data_Api>> futureData;

  // เก็บค่าเปลี่ยนสีปุ่มของรถและมาการแทนค่าจากชุดแรก
  List onClick_typeCar = [
    1, // รถเก๋ง
    1, // รถกระบะ
    1, // รถตู้
    1, // รถบรรทุก
  ];

  // ประเภทของรถ
  List data_Car = [
    // ตัวแปรการค้นหา
    "รถเก๋ง", // ประเภทรถเก๋ง
    "รถกระบะ", // ประเภทรถกระบะ
    "รถตู้", // ประเภทรถตู้
    "รถบรทุก", // ประเภทรถบรรทุก
  ];

  List data_click = [0]; // การกดใน list

  List data_left = [
    0, // หมายเลขป้าย
    0, // ชื่อ
    0, // จังหวัด
    0, // ประเภท
    0, // สี
    0, // ภาพรถ
    0, // รูปประเภทรถ
    Color(0xFF8E8E8E), // ช้อมูลสี
    0, // ภาพป้ายทะเบียน
    0, // ตำแหน่งไฟล์ Video
    0, // เวลา
    0, // วันที่
  ];

  //  เชื่อมต่อกับ API
  Future<List<Data_Api>> showdata_Search() async {
    final res = await http.get(
      Uri.parse("$url/plates"),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*",
      },
    );
    print('status: ${res.statusCode}');
    // print('headers: ${res.headers}');
    // print('body ${res.body}');

    final futureData = data_ApiFromJson(res.body);
    if (res.statusCode == 200) {
      return futureData;
    }
    return futureData;
  }

  // สร้างค่าตั้งต้น
  @override
  void initState() {
    super.initState();
    futureData = showdata_Search();
    widget.type_car.contains(1)
        ? onClick_typeCar = widget.type_car
        : onClick_typeCar = onClick_typeCar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromARGB(255, 239, 238, 233),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // ส่วนหัวของหน้า
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 100,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 160, 182, 255),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        print(widget.type_car);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearcScreenWidget()),
                        );
                      },
                      child: Image.asset(
                        'assets/images/Back.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: double.infinity,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'หมายเลขป้ายทะเบียน : ${widget.search_plate}',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Mitr',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 40,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // กล่อง Filter ประเภทรถ
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Color.fromARGB(255, 160, 182, 255),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ประเภทรถ(รถเก๋ง)
                    Tooltip(
                      triggerMode: TooltipTriggerMode.manual,
                      message: ' รถเก๋ง ',
                      padding: const EdgeInsets.all(5.0),
                      preferBelow: false,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Mitr',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (onClick_typeCar[0] == 1) {
                              onClick_typeCar[0] = 0;
                              data_Car[0] = '';
                              print(data_Car[0]);
                              print(widget.type_car);
                            } else {
                              onClick_typeCar[0] = 1;
                              data_Car[0] = 'รถเก๋ง';
                              print(data_Car[0]);
                            }
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          decoration: BoxDecoration(
                            color: onClick_typeCar[0] == 1
                                ? Color.fromARGB(100, 160, 182, 255)
                                : Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color.fromARGB(255, 160, 182, 255),
                              width: 2,
                            ),
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                            child: Image.asset(
                              'assets/images/Sedan.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tooltip(
                      triggerMode: TooltipTriggerMode.manual,
                      message: ' รถกระบะ ',
                      padding: const EdgeInsets.all(5.0),
                      preferBelow: false,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Mitr',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      child: GestureDetector(
                        // ประเภทรถ(กระบะ)
                        onTap: () {
                          setState(() {
                            if (onClick_typeCar[1] == 1) {
                              onClick_typeCar[1] = 0;
                              data_Car[1] = '';
                              print(data_Car[1]);
                            } else {
                              onClick_typeCar[1] = 1;
                              data_Car[1] = 'รถกระบะ';
                              print(data_Car[1]);
                            }
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          decoration: BoxDecoration(
                            color: onClick_typeCar[1] == 1
                                ? Color.fromARGB(100, 160, 182, 255)
                                : Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color.fromARGB(255, 160, 182, 255),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                            child: Image.asset(
                              'assets/images/Pickup.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tooltip(
                      triggerMode: TooltipTriggerMode.manual,
                      message: ' รถตู้ ',
                      padding: const EdgeInsets.all(5.0),
                      preferBelow: false,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Mitr',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      child: GestureDetector(
                        // ประเภทรถ(ตู้)
                        onTap: () {
                          print('รถตู้');
                          setState(() {
                            if (onClick_typeCar[2] == 1) {
                              onClick_typeCar[2] = 0;
                              data_Car[2] = '';
                              print(data_Car[2]);
                            } else {
                              onClick_typeCar[2] = 1;
                              data_Car[2] = 'รถตู้';
                              print(data_Car[2]);
                            }
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          decoration: BoxDecoration(
                            color: onClick_typeCar[2] == 1
                                ? Color.fromARGB(100, 160, 182, 255)
                                : Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color.fromARGB(255, 160, 182, 255),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                            child: Image.asset(
                              'assets/images/Van.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tooltip(
                      triggerMode: TooltipTriggerMode.manual,
                      message: ' รถบรรทุก ',
                      padding: const EdgeInsets.all(5.0),
                      preferBelow: false,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Mitr',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      child: GestureDetector(
                        // ประเภทรถ(บรรทุก)
                        onTap: () {
                          print('รถบรรทุก');

                          setState(() {
                            if (onClick_typeCar[3] == 1) {
                              onClick_typeCar[3] = 0;
                              data_Car[3] = '';
                              print(data_Car[3]);
                            } else {
                              onClick_typeCar[3] = 1;
                              data_Car[3] = 'รถบรรทุก';
                              print(data_Car[3]);
                              print(data_left[8]);
                            }
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          decoration: BoxDecoration(
                            color: onClick_typeCar[3] == 1
                                ? Color.fromARGB(100, 160, 182, 255)
                                : Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color.fromARGB(255, 160, 182, 255),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                            child: Image.asset(
                              'assets/images/Truck.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // สร้าง List Visw เพื่อดูข้อมูล
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.453,
                            height: MediaQuery.of(context).size.height * 0.71,
                            decoration: BoxDecoration(),
                            child: FutureBuilder<List<Data_Api>>(
                                future: futureData,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return SpinKitSpinningLines(
                                        size: 140,
                                        color:
                                            Color.fromARGB(255, 160, 182, 255));
                                  }
                                  final listviewData = snapshot.data!;
                                  List<Data_Api> listviewData2 = listviewData;

                                  // การค้นหาตาม หมายเลขป้ายทะเบียน
                                  if (widget.license_plate !=
                                      "ไม่ได้ใส่ข้อมูล") {
                                    listviewData2 = listviewData
                                        .where((e) => e.licensePlate!
                                            .contains(widget.license_plate))
                                        .toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listviewData2.length,
                                      itemBuilder:
                                          (context, indexlistviewData2) {
                                        if (indexlistviewData2 == 0) {
                                          indexlistviewData2 + 1;
                                        }
                                        return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print(listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate);
                                                data_click[0] = 1;
                                                data_left[0] = listviewData2[
                                                        indexlistviewData2]
                                                    .licensePlate;
                                                data_left[1] = listviewData2[
                                                        indexlistviewData2]
                                                    .name;
                                                data_left[2] = listviewData2[
                                                        indexlistviewData2]
                                                    .city;
                                                data_left[3] = listviewData2[
                                                        indexlistviewData2]
                                                    .vehicle;
                                                data_left[4] = listviewData2[
                                                        indexlistviewData2]
                                                    .color;
                                                data_left[5] = listviewData2[
                                                        indexlistviewData2]
                                                    .img;
                                                data_left[6] = listviewData2[
                                                        indexlistviewData2]
                                                    .carImgType;
                                                data_left[7] = listviewData2[
                                                        indexlistviewData2]
                                                    .colorCode;
                                                data_left[8] = listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate;
                                                data_left[9] = listviewData2[
                                                        indexlistviewData2]
                                                    .video;
                                                data_left[10] = listviewData2[
                                                        indexlistviewData2]
                                                    .time;
                                                data_left[11] = listviewData2[
                                                        indexlistviewData2]
                                                    .date;
                                              });
                                            },
                                            child: Card(
                                                child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 0),
                                                  child: Container(
                                                    width: 550,
                                                    height: 150,
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(30,
                                                                      0, 30, 0),
                                                          child: Image.network(
                                                            '${listviewData2[indexlistviewData2].img}',
                                                            width: 200,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].licensePlate}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].city}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].vehicle}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )));
                                      },
                                    );
                                  }

                                  // การค้นหาตาม จังหวัด
                                  if (widget.city != "ไม่ได้ใส่ข้อมูล") {
                                    listviewData2 = listviewData
                                        .where((e) =>
                                            e.city!.contains(widget.city))
                                        .toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listviewData2.length,
                                      itemBuilder:
                                          (context, indexlistviewData2) {
                                        if (indexlistviewData2 == 0) {
                                          indexlistviewData2 + 1;
                                        }
                                        return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print(listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate);
                                                data_click[0] = 1;
                                                data_left[0] = listviewData2[
                                                        indexlistviewData2]
                                                    .licensePlate;
                                                data_left[1] = listviewData2[
                                                        indexlistviewData2]
                                                    .name;
                                                data_left[2] = listviewData2[
                                                        indexlistviewData2]
                                                    .city;
                                                data_left[3] = listviewData2[
                                                        indexlistviewData2]
                                                    .vehicle;
                                                data_left[4] = listviewData2[
                                                        indexlistviewData2]
                                                    .color;
                                                data_left[5] = listviewData2[
                                                        indexlistviewData2]
                                                    .img;
                                                data_left[6] = listviewData2[
                                                        indexlistviewData2]
                                                    .carImgType;
                                                data_left[7] = listviewData2[
                                                        indexlistviewData2]
                                                    .colorCode;
                                                data_left[8] = listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate;
                                                data_left[9] = listviewData2[
                                                        indexlistviewData2]
                                                    .video;
                                                data_left[10] = listviewData2[
                                                        indexlistviewData2]
                                                    .time;
                                                data_left[11] = listviewData2[
                                                        indexlistviewData2]
                                                    .date;
                                              });
                                            },
                                            child: Card(
                                                child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 0),
                                                  child: Container(
                                                    width: 550,
                                                    height: 150,
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(30,
                                                                      0, 30, 0),
                                                          child: Image.network(
                                                            '${listviewData2[indexlistviewData2].img}',
                                                            width: 200,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].licensePlate}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].city}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].vehicle}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )));
                                      },
                                    );
                                  }

                                  // การค้นหาตาม วันที่
                                  // if (widget.date != "19/8/2022") {
                                  //   listviewData2 = listviewData
                                  //       .where((e) =>
                                  //           e.vehicle!.contains(data_Car[3]))
                                  //       .toList();
                                  //   return ListView.builder(
                                  //     padding: EdgeInsets.zero,
                                  //     scrollDirection: Axis.vertical,
                                  //     itemCount: listviewData2.length,
                                  //     itemBuilder:
                                  //         (context, indexlistviewData2) {
                                  //       if (indexlistviewData2 == 0) {
                                  //         indexlistviewData2 + 1;
                                  //       }
                                  //       return GestureDetector(
                                  //           onTap: () {
                                  //             setState(() {
                                  //               print(listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate);
                                  //               data_click[0] = 1;
                                  //               data_left[0] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .licensePlate;
                                  //               data_left[1] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .name;
                                  //               data_left[2] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .city;
                                  //               data_left[3] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .vehicle;
                                  //               data_left[4] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .color;
                                  //               data_left[5] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .img;
                                  //               data_left[6] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .carImgType;
                                  //               data_left[7] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .colorCode;
                                  //               data_left[8] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate;
                                  //               data_left[9] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .video;
                                  // data_left[10] = listviewData2[indexlistviewData2].time;
                                  // data_left[11] = listviewData2[indexlistviewData2].date;
                                  //             });
                                  //           },
                                  //           child: Card(
                                  //               child: Row(
                                  //             mainAxisSize: MainAxisSize.max,
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               Padding(
                                  //                 padding: EdgeInsetsDirectional
                                  //                     .fromSTEB(0, 0, 0, 0),
                                  //                 child: Container(
                                  //                   width: 550,
                                  //                   height: 150,
                                  //                   decoration: BoxDecoration(),
                                  //                   child: Row(
                                  //                     mainAxisSize:
                                  //                         MainAxisSize.max,
                                  //                     mainAxisAlignment:
                                  //                         MainAxisAlignment
                                  //                             .start,
                                  //                     children: [
                                  //                       Padding(
                                  //                         padding:
                                  //                             EdgeInsetsDirectional
                                  //                                 .fromSTEB(30,
                                  //                                     0, 30, 0),
                                  //                         child: Image.network(
                                  //                           '${listviewData2[indexlistviewData2].img}',
                                  //                           width: 200,
                                  //                           height: 100,
                                  //                           fit: BoxFit.cover,
                                  //                         ),
                                  //                       ),
                                  //                       Column(
                                  //                         mainAxisSize:
                                  //                             MainAxisSize.max,
                                  //                         mainAxisAlignment:
                                  //                             MainAxisAlignment
                                  //                                 .spaceEvenly,
                                  //                         crossAxisAlignment:
                                  //                             CrossAxisAlignment
                                  //                                 .start,
                                  //                         children: [
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].licensePlate}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].city}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].vehicle}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           )));
                                  //     },
                                  //   );
                                  // }

                                  // การค้นหาตาม เวลาเข้า
                                  // if (widget.time_in != "02:32") {
                                  //   listviewData2 = listviewData
                                  //       .where((e) =>
                                  //           e.time!.contains(widget.time_in))
                                  //       .toList();
                                  //   return ListView.builder(
                                  //     padding: EdgeInsets.zero,
                                  //     scrollDirection: Axis.vertical,
                                  //     itemCount: listviewData2.length,
                                  //     itemBuilder:
                                  //         (context, indexlistviewData2) {
                                  //       if (indexlistviewData2 == 0) {
                                  //         indexlistviewData2 + 1;
                                  //       }
                                  //       return GestureDetector(
                                  //           onTap: () {
                                  //             setState(() {
                                  //               print(listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate);
                                  //               data_click[0] = 1;
                                  //               data_left[0] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .licensePlate;
                                  //               data_left[1] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .name;
                                  //               data_left[2] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .city;
                                  //               data_left[3] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .vehicle;
                                  //               data_left[4] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .color;
                                  //               data_left[5] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .img;
                                  //               data_left[6] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .carImgType;
                                  //               data_left[7] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .colorCode;
                                  //               data_left[8] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate;
                                  //               data_left[9] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .video;
                                  // data_left[10] = listviewData2[indexlistviewData2].time;
// data_left[11] = listviewData2[indexlistviewData2].date;
                                  //             });
                                  //           },
                                  //           child: Card(
                                  //               child: Row(
                                  //             mainAxisSize: MainAxisSize.max,
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               Padding(
                                  //                 padding: EdgeInsetsDirectional
                                  //                     .fromSTEB(0, 0, 0, 0),
                                  //                 child: Container(
                                  //                   width: 550,
                                  //                   height: 150,
                                  //                   decoration: BoxDecoration(),
                                  //                   child: Row(
                                  //                     mainAxisSize:
                                  //                         MainAxisSize.max,
                                  //                     mainAxisAlignment:
                                  //                         MainAxisAlignment
                                  //                             .start,
                                  //                     children: [
                                  //                       Padding(
                                  //                         padding:
                                  //                             EdgeInsetsDirectional
                                  //                                 .fromSTEB(30,
                                  //                                     0, 30, 0),
                                  //                         child: Image.network(
                                  //                           '${listviewData2[indexlistviewData2].img}',
                                  //                           width: 200,
                                  //                           height: 100,
                                  //                           fit: BoxFit.cover,
                                  //                         ),
                                  //                       ),
                                  //                       Column(
                                  //                         mainAxisSize:
                                  //                             MainAxisSize.max,
                                  //                         mainAxisAlignment:
                                  //                             MainAxisAlignment
                                  //                                 .spaceEvenly,
                                  //                         crossAxisAlignment:
                                  //                             CrossAxisAlignment
                                  //                                 .start,
                                  //                         children: [
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].licensePlate}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].city}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].vehicle}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           )));
                                  //     },
                                  //   );
                                  // }

                                  // การค้นหาตาม วันที่(ออก)
                                  // if (widget.time_out != "02:31") {
                                  //   listviewData2 = listviewData
                                  //       .where((e) =>
                                  //           e.time!.contains(widget.time_out))
                                  //       .toList();
                                  //   return ListView.builder(
                                  //     padding: EdgeInsets.zero,
                                  //     scrollDirection: Axis.vertical,
                                  //     itemCount: listviewData2.length,
                                  //     itemBuilder:
                                  //         (context, indexlistviewData2) {
                                  //       if (indexlistviewData2 == 0) {
                                  //         indexlistviewData2 + 1;
                                  //       }
                                  //       return GestureDetector(
                                  //           onTap: () {
                                  //             setState(() {
                                  //               print(listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate);
                                  //               data_click[0] = 1;
                                  //               data_left[0] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .licensePlate;
                                  //               data_left[1] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .name;
                                  //               data_left[2] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .city;
                                  //               data_left[3] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .vehicle;
                                  //               data_left[4] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .color;
                                  //               data_left[5] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .img;
                                  //               data_left[6] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .carImgType;
                                  //               data_left[7] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .colorCode;
                                  //               data_left[8] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate;
                                  //               data_left[9] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .video;
                                  // data_left[10] = listviewData2[indexlistviewData2].time;
// data_left[11] = listviewData2[indexlistviewData2].date;
                                  //             });
                                  //           },
                                  //           child: Card(
                                  //               child: Row(
                                  //             mainAxisSize: MainAxisSize.max,
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               Padding(
                                  //                 padding: EdgeInsetsDirectional
                                  //                     .fromSTEB(0, 0, 0, 0),
                                  //                 child: Container(
                                  //                   width: 550,
                                  //                   height: 150,
                                  //                   decoration: BoxDecoration(),
                                  //                   child: Row(
                                  //                     mainAxisSize:
                                  //                         MainAxisSize.max,
                                  //                     mainAxisAlignment:
                                  //                         MainAxisAlignment
                                  //                             .start,
                                  //                     children: [
                                  //                       Padding(
                                  //                         padding:
                                  //                             EdgeInsetsDirectional
                                  //                                 .fromSTEB(30,
                                  //                                     0, 30, 0),
                                  //                         child: Image.network(
                                  //                           '${listviewData2[indexlistviewData2].img}',
                                  //                           width: 200,
                                  //                           height: 100,
                                  //                           fit: BoxFit.cover,
                                  //                         ),
                                  //                       ),
                                  //                       Column(
                                  //                         mainAxisSize:
                                  //                             MainAxisSize.max,
                                  //                         mainAxisAlignment:
                                  //                             MainAxisAlignment
                                  //                                 .spaceEvenly,
                                  //                         crossAxisAlignment:
                                  //                             CrossAxisAlignment
                                  //                                 .start,
                                  //                         children: [
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].licensePlate}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].city}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].vehicle}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           )));
                                  //     },
                                  //   );
                                  // }

                                  // การค้าหาตาม สี
                                  if (widget.color != "ไม่เลือกสี") {
                                    listviewData2 = listviewData
                                        .where((e) =>
                                            e.color!.contains(widget.color))
                                        .toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listviewData2.length,
                                      itemBuilder:
                                          (context, indexlistviewData2) {
                                        if (indexlistviewData2 == 0) {
                                          indexlistviewData2 + 1;
                                        }
                                        return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print(listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate);
                                                data_click[0] = 1;
                                                data_left[0] = listviewData2[
                                                        indexlistviewData2]
                                                    .licensePlate;
                                                data_left[1] = listviewData2[
                                                        indexlistviewData2]
                                                    .name;
                                                data_left[2] = listviewData2[
                                                        indexlistviewData2]
                                                    .city;
                                                data_left[3] = listviewData2[
                                                        indexlistviewData2]
                                                    .vehicle;
                                                data_left[4] = listviewData2[
                                                        indexlistviewData2]
                                                    .color;
                                                data_left[5] = listviewData2[
                                                        indexlistviewData2]
                                                    .img;
                                                data_left[6] = listviewData2[
                                                        indexlistviewData2]
                                                    .carImgType;
                                                data_left[7] = listviewData2[
                                                        indexlistviewData2]
                                                    .colorCode;
                                                data_left[8] = listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate;
                                                data_left[9] = listviewData2[
                                                        indexlistviewData2]
                                                    .video;
                                                data_left[10] = listviewData2[
                                                        indexlistviewData2]
                                                    .time;
                                                data_left[11] = listviewData2[
                                                        indexlistviewData2]
                                                    .date;
                                              });
                                            },
                                            child: Card(
                                                child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 0),
                                                  child: Container(
                                                    width: 550,
                                                    height: 150,
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(30,
                                                                      0, 30, 0),
                                                          child: Image.network(
                                                            '${listviewData2[indexlistviewData2].img}',
                                                            width: 200,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].licensePlate}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].city}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].vehicle}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )));
                                      },
                                    );
                                  }

                                  // การค้นหาตามประเภทรถ (รถเก๋ง)
                                  if (widget.type_car_data_1 != "-") {
                                    listviewData2 = listviewData
                                        .where((e) =>
                                            e.vehicle!.contains(data_Car[0]))
                                        .toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listviewData2.length,
                                      itemBuilder:
                                          (context, indexlistviewData2) {
                                        if (indexlistviewData2 == 0) {
                                          indexlistviewData2 + 1;
                                        }
                                        return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print(listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate);
                                                data_click[0] = 1;
                                                data_left[0] = listviewData2[
                                                        indexlistviewData2]
                                                    .licensePlate;
                                                data_left[1] = listviewData2[
                                                        indexlistviewData2]
                                                    .name;
                                                data_left[2] = listviewData2[
                                                        indexlistviewData2]
                                                    .city;
                                                data_left[3] = listviewData2[
                                                        indexlistviewData2]
                                                    .vehicle;
                                                data_left[4] = listviewData2[
                                                        indexlistviewData2]
                                                    .color;
                                                data_left[5] = listviewData2[
                                                        indexlistviewData2]
                                                    .img;
                                                data_left[6] = listviewData2[
                                                        indexlistviewData2]
                                                    .carImgType;
                                                data_left[7] = listviewData2[
                                                        indexlistviewData2]
                                                    .colorCode;
                                                data_left[8] = listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate;
                                                data_left[9] = listviewData2[
                                                        indexlistviewData2]
                                                    .video;
                                                data_left[10] = listviewData2[
                                                        indexlistviewData2]
                                                    .time;
                                                data_left[11] = listviewData2[
                                                        indexlistviewData2]
                                                    .date;
                                              });
                                            },
                                            child: Card(
                                                child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 0),
                                                  child: Container(
                                                    width: 550,
                                                    height: 150,
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(30,
                                                                      0, 30, 0),
                                                          child: Image.network(
                                                            '${listviewData2[indexlistviewData2].img}',
                                                            width: 200,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].licensePlate}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].city}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].vehicle}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )));
                                      },
                                    );
                                  }

                                  // การค้นหาตามประเภทรถ (รถกระบะ)
                                  if (widget.type_car_data_2 != "-") {
                                    listviewData2 = listviewData
                                        .where((e) =>
                                            e.vehicle!.contains(data_Car[1]))
                                        .toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listviewData2.length,
                                      itemBuilder:
                                          (context, indexlistviewData2) {
                                        if (indexlistviewData2 == 0) {
                                          indexlistviewData2 + 1;
                                        }
                                        return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print(listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate);
                                                data_click[0] = 1;
                                                data_left[0] = listviewData2[
                                                        indexlistviewData2]
                                                    .licensePlate;
                                                data_left[1] = listviewData2[
                                                        indexlistviewData2]
                                                    .name;
                                                data_left[2] = listviewData2[
                                                        indexlistviewData2]
                                                    .city;
                                                data_left[3] = listviewData2[
                                                        indexlistviewData2]
                                                    .vehicle;
                                                data_left[4] = listviewData2[
                                                        indexlistviewData2]
                                                    .color;
                                                data_left[5] = listviewData2[
                                                        indexlistviewData2]
                                                    .img;
                                                data_left[6] = listviewData2[
                                                        indexlistviewData2]
                                                    .carImgType;
                                                data_left[7] = listviewData2[
                                                        indexlistviewData2]
                                                    .colorCode;
                                                data_left[8] = listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate;
                                                data_left[9] = listviewData2[
                                                        indexlistviewData2]
                                                    .video;
                                                data_left[10] = listviewData2[
                                                        indexlistviewData2]
                                                    .time;
                                                data_left[11] = listviewData2[
                                                        indexlistviewData2]
                                                    .date;
                                              });
                                            },
                                            child: Card(
                                                child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 0),
                                                  child: Container(
                                                    width: 550,
                                                    height: 150,
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(30,
                                                                      0, 30, 0),
                                                          child: Image.network(
                                                            '${listviewData2[indexlistviewData2].img}',
                                                            width: 200,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].licensePlate}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].city}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].vehicle}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )));
                                      },
                                    );
                                  }

                                  // การค้นหาตามประเภทรถ (รถตู้)
                                  if (widget.type_car_data_3 != "-") {
                                    listviewData2 = listviewData
                                        .where((e) =>
                                            e.vehicle!.contains(data_Car[2]))
                                        .toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listviewData2.length,
                                      itemBuilder:
                                          (context, indexlistviewData2) {
                                        if (indexlistviewData2 == 0) {
                                          indexlistviewData2 + 1;
                                        }
                                        return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print(listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate);
                                                data_click[0] = 1;
                                                data_left[0] = listviewData2[
                                                        indexlistviewData2]
                                                    .licensePlate;
                                                data_left[1] = listviewData2[
                                                        indexlistviewData2]
                                                    .name;
                                                data_left[2] = listviewData2[
                                                        indexlistviewData2]
                                                    .city;
                                                data_left[3] = listviewData2[
                                                        indexlistviewData2]
                                                    .vehicle;
                                                data_left[4] = listviewData2[
                                                        indexlistviewData2]
                                                    .color;
                                                data_left[5] = listviewData2[
                                                        indexlistviewData2]
                                                    .img;
                                                data_left[6] = listviewData2[
                                                        indexlistviewData2]
                                                    .carImgType;
                                                data_left[7] = listviewData2[
                                                        indexlistviewData2]
                                                    .colorCode;
                                                data_left[8] = listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate;
                                                data_left[9] = listviewData2[
                                                        indexlistviewData2]
                                                    .video;
                                                data_left[10] = listviewData2[
                                                        indexlistviewData2]
                                                    .time;
                                                data_left[11] = listviewData2[
                                                        indexlistviewData2]
                                                    .date;
                                              });
                                            },
                                            child: Card(
                                                child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 0),
                                                  child: Container(
                                                    width: 550,
                                                    height: 150,
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(30,
                                                                      0, 30, 0),
                                                          child: Image.network(
                                                            '${listviewData2[indexlistviewData2].img}',
                                                            width: 200,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].licensePlate}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].city}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].vehicle}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )));
                                      },
                                    );
                                  }

                                  // การค้นหาตามประเภทรถ (รถบรรทุก)
                                  if (widget.type_car_data_4 != "-") {
                                    listviewData2 = listviewData
                                        .where((e) =>
                                            e.vehicle!.contains(data_Car[3]))
                                        .toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listviewData2.length,
                                      itemBuilder:
                                          (context, indexlistviewData2) {
                                        if (indexlistviewData2 == 0) {
                                          indexlistviewData2 + 1;
                                        }
                                        return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print(listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate);
                                                data_click[0] = 1;
                                                data_left[0] = listviewData2[
                                                        indexlistviewData2]
                                                    .licensePlate;
                                                data_left[1] = listviewData2[
                                                        indexlistviewData2]
                                                    .name;
                                                data_left[2] = listviewData2[
                                                        indexlistviewData2]
                                                    .city;
                                                data_left[3] = listviewData2[
                                                        indexlistviewData2]
                                                    .vehicle;
                                                data_left[4] = listviewData2[
                                                        indexlistviewData2]
                                                    .color;
                                                data_left[5] = listviewData2[
                                                        indexlistviewData2]
                                                    .img;
                                                data_left[6] = listviewData2[
                                                        indexlistviewData2]
                                                    .carImgType;
                                                data_left[7] = listviewData2[
                                                        indexlistviewData2]
                                                    .colorCode;
                                                data_left[8] = listviewData2[
                                                        indexlistviewData2]
                                                    .imgPlate;
                                                data_left[9] = listviewData2[
                                                        indexlistviewData2]
                                                    .video;
                                                data_left[10] = listviewData2[
                                                        indexlistviewData2]
                                                    .time;
                                                data_left[11] = listviewData2[
                                                        indexlistviewData2]
                                                    .date;
                                              });
                                            },
                                            child: Card(
                                                child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 0),
                                                  child: Container(
                                                    width: 550,
                                                    height: 150,
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(30,
                                                                      0, 30, 0),
                                                          child: Image.network(
                                                            '${listviewData2[indexlistviewData2].img}',
                                                            width: 200,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].licensePlate}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].city}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${listviewData2[indexlistviewData2].vehicle}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Mitr',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        46,
                                                                        46),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )));
                                      },
                                    );
                                  }

                                  // Filter

                                  // คัดกรองประเภทรถ (รถเก๋ง)
                                  // if (onClick_typeCar[0] != "0") {
                                  //   listviewData2 = listviewData
                                  //       .where((e) =>
                                  //           e.vehicle!.contains(data_Car[0]))
                                  //       .toList();
                                  //   return ListView.builder(
                                  //     padding: EdgeInsets.zero,
                                  //     scrollDirection: Axis.vertical,
                                  //     itemCount: listviewData2.length,
                                  //     itemBuilder:
                                  //         (context, indexlistviewData2) {
                                  //       if (indexlistviewData2 == 0) {
                                  //         indexlistviewData2 + 1;
                                  //       }
                                  //       return GestureDetector(
                                  //           onTap: () {
                                  //             setState(() {
                                  //               print(listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate);
                                  //               data_click[0] = 1;
                                  //               data_left[0] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .licensePlate;
                                  //               data_left[1] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .name;
                                  //               data_left[2] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .city;
                                  //               data_left[3] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .vehicle;
                                  //               data_left[4] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .color;
                                  //               data_left[5] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .img;
                                  //               data_left[6] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .carImgType;
                                  //               data_left[7] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .colorCode;
                                  //               data_left[8] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate;
                                  //               data_left[9] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .video;
                                  //             });
                                  //           },
                                  //           child: Card(
                                  //               child: Row(
                                  //             mainAxisSize: MainAxisSize.max,
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               Padding(
                                  //                 padding: EdgeInsetsDirectional
                                  //                     .fromSTEB(0, 0, 0, 0),
                                  //                 child: Container(
                                  //                   width: 550,
                                  //                   height: 150,
                                  //                   decoration: BoxDecoration(),
                                  //                   child: Row(
                                  //                     mainAxisSize:
                                  //                         MainAxisSize.max,
                                  //                     mainAxisAlignment:
                                  //                         MainAxisAlignment
                                  //                             .start,
                                  //                     children: [
                                  //                       Padding(
                                  //                         padding:
                                  //                             EdgeInsetsDirectional
                                  //                                 .fromSTEB(30,
                                  //                                     0, 30, 0),
                                  //                         child: Image.network(
                                  //                           '${listviewData2[indexlistviewData2].img}',
                                  //                           width: 200,
                                  //                           height: 100,
                                  //                           fit: BoxFit.cover,
                                  //                         ),
                                  //                       ),
                                  //                       Column(
                                  //                         mainAxisSize:
                                  //                             MainAxisSize.max,
                                  //                         mainAxisAlignment:
                                  //                             MainAxisAlignment
                                  //                                 .spaceEvenly,
                                  //                         crossAxisAlignment:
                                  //                             CrossAxisAlignment
                                  //                                 .start,
                                  //                         children: [
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].licensePlate}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].city}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].vehicle}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           )));
                                  //     },
                                  //   );
                                  // }

                                  // คัดกรองประเภทรถ (รถกระบะ)
                                  // if (onClick_typeCar[1] != "0") {
                                  //   listviewData2 = listviewData
                                  //       .where((e) =>
                                  //           e.vehicle!.contains(data_Car[1]))
                                  //       .toList();
                                  //   return ListView.builder(
                                  //     padding: EdgeInsets.zero,
                                  //     scrollDirection: Axis.vertical,
                                  //     itemCount: listviewData2.length,
                                  //     itemBuilder:
                                  //         (context, indexlistviewData2) {
                                  //       if (indexlistviewData2 == 0) {
                                  //         indexlistviewData2 + 1;
                                  //       }
                                  //       return GestureDetector(
                                  //           onTap: () {
                                  //             setState(() {
                                  //               print(listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate);
                                  //               data_click[0] = 1;
                                  //               data_left[0] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .licensePlate;
                                  //               data_left[1] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .name;
                                  //               data_left[2] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .city;
                                  //               data_left[3] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .vehicle;
                                  //               data_left[4] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .color;
                                  //               data_left[5] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .img;
                                  //               data_left[6] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .carImgType;
                                  //               data_left[7] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .colorCode;
                                  //               data_left[8] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate;
                                  //               data_left[9] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .video;
                                  //             });
                                  //           },
                                  //           child: Card(
                                  //               child: Row(
                                  //             mainAxisSize: MainAxisSize.max,
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               Padding(
                                  //                 padding: EdgeInsetsDirectional
                                  //                     .fromSTEB(0, 0, 0, 0),
                                  //                 child: Container(
                                  //                   width: 550,
                                  //                   height: 150,
                                  //                   decoration: BoxDecoration(),
                                  //                   child: Row(
                                  //                     mainAxisSize:
                                  //                         MainAxisSize.max,
                                  //                     mainAxisAlignment:
                                  //                         MainAxisAlignment
                                  //                             .start,
                                  //                     children: [
                                  //                       Padding(
                                  //                         padding:
                                  //                             EdgeInsetsDirectional
                                  //                                 .fromSTEB(30,
                                  //                                     0, 30, 0),
                                  //                         child: Image.network(
                                  //                           '${listviewData2[indexlistviewData2].img}',
                                  //                           width: 200,
                                  //                           height: 100,
                                  //                           fit: BoxFit.cover,
                                  //                         ),
                                  //                       ),
                                  //                       Column(
                                  //                         mainAxisSize:
                                  //                             MainAxisSize.max,
                                  //                         mainAxisAlignment:
                                  //                             MainAxisAlignment
                                  //                                 .spaceEvenly,
                                  //                         crossAxisAlignment:
                                  //                             CrossAxisAlignment
                                  //                                 .start,
                                  //                         children: [
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].licensePlate}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].city}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].vehicle}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           )));
                                  //     },
                                  //   );
                                  // }

                                  // คัดกรองประเภทรถ (รถตู้)
                                  // if (onClick_typeCar[2] != "0") {
                                  //   listviewData2 = listviewData
                                  //       .where((e) =>
                                  //           e.vehicle!.contains(data_Car[2]))
                                  //       .toList();
                                  //   return ListView.builder(
                                  //     padding: EdgeInsets.zero,
                                  //     scrollDirection: Axis.vertical,
                                  //     itemCount: listviewData2.length,
                                  //     itemBuilder:
                                  //         (context, indexlistviewData2) {
                                  //       if (indexlistviewData2 == 0) {
                                  //         indexlistviewData2 + 1;
                                  //       }
                                  //       return GestureDetector(
                                  //           onTap: () {
                                  //             setState(() {
                                  //               print(listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate);
                                  //               data_click[0] = 1;
                                  //               data_left[0] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .licensePlate;
                                  //               data_left[1] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .name;
                                  //               data_left[2] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .city;
                                  //               data_left[3] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .vehicle;
                                  //               data_left[4] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .color;
                                  //               data_left[5] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .img;
                                  //               data_left[6] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .carImgType;
                                  //               data_left[7] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .colorCode;
                                  //               data_left[8] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate;
                                  //               data_left[9] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .video;
                                  //             });
                                  //           },
                                  //           child: Card(
                                  //               child: Row(
                                  //             mainAxisSize: MainAxisSize.max,
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               Padding(
                                  //                 padding: EdgeInsetsDirectional
                                  //                     .fromSTEB(0, 0, 0, 0),
                                  //                 child: Container(
                                  //                   width: 550,
                                  //                   height: 150,
                                  //                   decoration: BoxDecoration(),
                                  //                   child: Row(
                                  //                     mainAxisSize:
                                  //                         MainAxisSize.max,
                                  //                     mainAxisAlignment:
                                  //                         MainAxisAlignment
                                  //                             .start,
                                  //                     children: [
                                  //                       Padding(
                                  //                         padding:
                                  //                             EdgeInsetsDirectional
                                  //                                 .fromSTEB(30,
                                  //                                     0, 30, 0),
                                  //                         child: Image.network(
                                  //                           '${listviewData2[indexlistviewData2].img}',
                                  //                           width: 200,
                                  //                           height: 100,
                                  //                           fit: BoxFit.cover,
                                  //                         ),
                                  //                       ),
                                  //                       Column(
                                  //                         mainAxisSize:
                                  //                             MainAxisSize.max,
                                  //                         mainAxisAlignment:
                                  //                             MainAxisAlignment
                                  //                                 .spaceEvenly,
                                  //                         crossAxisAlignment:
                                  //                             CrossAxisAlignment
                                  //                                 .start,
                                  //                         children: [
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].licensePlate}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].city}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].vehicle}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           )));
                                  //     },
                                  //   );
                                  // }

                                  // คัดกรองประเภทรถ (รถบรรทุก)
                                  // if (onClick_typeCar[3] != "0") {
                                  //   listviewData2 = listviewData
                                  //       .where((e) =>
                                  //           e.vehicle!.contains(data_Car[3]))
                                  //       .toList();
                                  //   return ListView.builder(
                                  //     padding: EdgeInsets.zero,
                                  //     scrollDirection: Axis.vertical,
                                  //     itemCount: listviewData2.length,
                                  //     itemBuilder:
                                  //         (context, indexlistviewData2) {
                                  //       if (indexlistviewData2 == 0) {
                                  //         indexlistviewData2 + 1;
                                  //       }
                                  //       return GestureDetector(
                                  //           onTap: () {
                                  //             setState(() {
                                  //               print(listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate);
                                  //               data_click[0] = 1;
                                  //               data_left[0] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .licensePlate;
                                  //               data_left[1] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .name;
                                  //               data_left[2] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .city;
                                  //               data_left[3] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .vehicle;
                                  //               data_left[4] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .color;
                                  //               data_left[5] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .img;
                                  //               data_left[6] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .carImgType;
                                  //               data_left[7] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .colorCode;
                                  //               data_left[8] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .imgPlate;
                                  //               data_left[9] = listviewData2[
                                  //                       indexlistviewData2]
                                  //                   .video;
                                  //             });
                                  //           },
                                  //           child: Card(
                                  //               child: Row(
                                  //             mainAxisSize: MainAxisSize.max,
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               Padding(
                                  //                 padding: EdgeInsetsDirectional
                                  //                     .fromSTEB(0, 0, 0, 0),
                                  //                 child: Container(
                                  //                   width: 550,
                                  //                   height: 150,
                                  //                   decoration: BoxDecoration(),
                                  //                   child: Row(
                                  //                     mainAxisSize:
                                  //                         MainAxisSize.max,
                                  //                     mainAxisAlignment:
                                  //                         MainAxisAlignment
                                  //                             .start,
                                  //                     children: [
                                  //                       Padding(
                                  //                         padding:
                                  //                             EdgeInsetsDirectional
                                  //                                 .fromSTEB(30,
                                  //                                     0, 30, 0),
                                  //                         child: Image.network(
                                  //                           '${listviewData2[indexlistviewData2].img}',
                                  //                           width: 200,
                                  //                           height: 100,
                                  //                           fit: BoxFit.cover,
                                  //                         ),
                                  //                       ),
                                  //                       Column(
                                  //                         mainAxisSize:
                                  //                             MainAxisSize.max,
                                  //                         mainAxisAlignment:
                                  //                             MainAxisAlignment
                                  //                                 .spaceEvenly,
                                  //                         crossAxisAlignment:
                                  //                             CrossAxisAlignment
                                  //                                 .start,
                                  //                         children: [
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].licensePlate}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].city}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                           Text(
                                  //                             '${listviewData2[indexlistviewData2].vehicle}',
                                  //                             style:
                                  //                                 FlutterFlowTheme
                                  //                                     .bodyText1
                                  //                                     .override(
                                  //                               fontFamily:
                                  //                                   'Mitr',
                                  //                               color: Color
                                  //                                   .fromARGB(
                                  //                                       255,
                                  //                                       46,
                                  //                                       46,
                                  //                                       46),
                                  //                               fontSize: 20,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w300,
                                  //                             ),
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           )));
                                  //     },
                                  //   );
                                  // }

                                  // คืนค่าของ ลำดับ
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount: listviewData.length,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        index + 1;
                                      }

                                      return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              data_click[0] = 1;
                                              data_left[0] = listviewData[index]
                                                  .licensePlate;
                                              data_left[1] =
                                                  listviewData[index].name;
                                              data_left[2] =
                                                  listviewData[index].city;
                                              data_left[3] =
                                                  listviewData[index].vehicle;
                                              data_left[4] =
                                                  listviewData[index].color;
                                              data_left[5] =
                                                  listviewData[index].img;
                                              data_left[6] = listviewData[index]
                                                  .carImgType;
                                              data_left[7] =
                                                  listviewData[index].colorCode;
                                              data_left[8] =
                                                  listviewData[index].imgPlate;
                                              data_left[9] =
                                                  listviewData[index].video;
                                              data_left[10] = 
                                                  listviewData[index].time;
                                              data_left[11] = 
                                                  listviewData[index].date;
                                            });
                                          },
                                          child: Card(
                                              child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 0),
                                                child: Container(
                                                  width: 550,
                                                  height: 150,
                                                  decoration: BoxDecoration(),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(30, 0,
                                                                    30, 0),
                                                        child: Image.network(
                                                          '${listviewData[index].img}',
                                                          width: 200,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${listviewData[index].licensePlate}',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                              fontFamily:
                                                                  'Mitr',
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      46,
                                                                      46,
                                                                      46),
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${listviewData[index].city}',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                              fontFamily:
                                                                  'Mitr',
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      46,
                                                                      46,
                                                                      46),
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${listviewData[index].vehicle}',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                              fontFamily:
                                                                  'Mitr',
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      46,
                                                                      46,
                                                                      46),
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )));
                                    },
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // สร้าง ListView สำหรับดูรายละเอียด
                  SingleChildScrollView(
                    child: FutureBuilder<List<Data_Api>>(
                        future: futureData,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return SpinKitSpinningLines(
                                size: 140,
                                color: Color.fromARGB(255, 160, 182, 255));
                          }
                          final listviewData2 = snapshot.data!;
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height:
                                      MediaQuery.of(context).size.height * 0.71,
                                  decoration: BoxDecoration(),
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: Container(
                                              width: 500,
                                              height: 350,
                                              child: Stack(
                                                children: [

                                                  // รูปภาพรถ
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                        "${data_click[0] == 0 ? listviewData2[0].img : data_left[5]}",
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),

                                                  // รูปภาพป้ายทะเบียน
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.96, 0.95),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                        "${data_click[0] == 0 ? listviewData2[0].imgPlate : data_left[8]}",
                                                        width: 120,
                                                        height: 80,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // เลขป้ายทะเบียน
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 20, 0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 55,
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                "${data_click[0] == 0 ? listviewData2[0].licensePlate : data_left[0]}",
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Mitr',
                                                  color: Color.fromARGB(
                                                      255, 46, 46, 46),
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),
                                          ),

                                          // เส้นขั้น
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 3,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 160, 182, 255),
                                              ),
                                            ),
                                          ),

                                          // ชื่อเจ้าของรถ
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 5, 0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'ชื่อเจ้าของรถ :',
                                                    style: FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Mitr',
                                                      color: Color.fromARGB(
                                                          255, 46, 46, 46),
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 0, 0),
                                                    child: Text(
                                                      "${data_click[0] == 0 ? listviewData2[0].name : data_left[1]}",
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Mitr',
                                                        color: Color.fromARGB(
                                                            255, 46, 46, 46),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // จังหวัด
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 5, 0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'จังหวัด :',
                                                    style: FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Mitr',
                                                      color: Color.fromARGB(
                                                          255, 46, 46, 46),
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 0, 0),
                                                    child: Text(
                                                      "${data_click[0] == 0 ? listviewData2[0].city : data_left[2]}",
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Mitr',
                                                        color: Color.fromARGB(
                                                            255, 46, 46, 46),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // ประเภทรถ
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 5, 0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'ประเภทรถ :',
                                                    style: FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Mitr',
                                                      color: Color.fromARGB(
                                                          255, 46, 46, 46),
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 0, 0),
                                                    child: Text(
                                                      "${data_click[0] == 0 ? listviewData2[0].vehicle : data_left[3]}",
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Mitr',
                                                        color: Color.fromARGB(
                                                            255, 46, 46, 46),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 0, 0),
                                                    child: Image.network(
                                                      '${data_click[0] == 0 ? listviewData2[0].carImgType : data_left[6]}',
                                                      width: 50,
                                                      height: 50,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // สี
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 5, 0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'สี :',
                                                    style: FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Mitr',
                                                      color: Color.fromARGB(
                                                          255, 46, 46, 46),
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 0, 0),
                                                    child: Text(
                                                      "${data_click[0] == 0 ? listviewData2[0].color : data_left[4]}",
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Mitr',
                                                        color: Color.fromARGB(
                                                            255, 46, 46, 46),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                  // Padding(
                                                  //   padding:
                                                  //       EdgeInsetsDirectional
                                                  //           .fromSTEB(
                                                  //               10, 0, 0, 0),
                                                  //   child: Container(
                                                  //     width: 50,
                                                  //     height: 50,
                                                  //     decoration: BoxDecoration(
                                                  //       color: data_click[0] == 0 ? listviewData2[0].colorCode : data_left[7],
                                                  //         shape: BoxShape.circle,
                                                  //       border: Border.all(
                                                  //         color: Color.fromARGB(
                                                  //             255,
                                                  //             160,
                                                  //             182,
                                                  //             255),
                                                  //         width: 2,
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // เวลา
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 5, 0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'เวลา :',
                                                    style: FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Mitr',
                                                      color: Color.fromARGB(
                                                          255, 46, 46, 46),
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 0, 0),
                                                    child: Text(
                                                      "${data_click[0] == 0 ? listviewData2[0].time : data_left[10]}",
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Mitr',
                                                        color: Color.fromARGB(
                                                            255, 46, 46, 46),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // วันที่
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 5, 0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'วัน / เดือน / ปี :',
                                                    style: FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Mitr',
                                                      color: Color.fromARGB(
                                                          255, 46, 46, 46),
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 0, 0),
                                                    child: Text(
                                                      "${data_click[0] == 0 ? listviewData2[0].date : data_left[11]}",
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Mitr',
                                                        color: Color.fromARGB(
                                                            255, 46, 46, 46),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // ปุ่มการค้นหา
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: FFButtonWidget(
                                              onPressed: () {

                                                // เซ็ตค่าตั้งต้นหากกรณีไม่มีข้อมูล
                                                data_click[0] == 0
                                                    ? data_left[0] =
                                                        listviewData2[0]
                                                            .licensePlate
                                                    : data_left[0];

                                                data_click[0] == 0
                                                    ? data_left[1] =
                                                        listviewData2[0].name
                                                    : data_left[1];

                                                data_click[0] == 0
                                                    ? data_left[2] =
                                                        listviewData2[0].city
                                                    : data_left[2];

                                                data_click[0] == 0
                                                    ? data_left[3] =
                                                        listviewData2[0].vehicle
                                                    : data_left[3];

                                                data_click[0] == 0
                                                    ? data_left[4] =
                                                        listviewData2[0].color
                                                    : data_left[4];

                                                data_click[0] == 0
                                                    ? data_left[5] =
                                                        listviewData2[0].img
                                                    : data_left[5];

                                                data_click[0] == 0
                                                    ? data_left[6] =
                                                        listviewData2[0]
                                                            .carImgType
                                                    : data_left[6];

                                                data_click[0] == 0
                                                    ? data_left[7] =
                                                        listviewData2[0]
                                                            .colorCode
                                                    : data_left[7];

                                                data_click[0] == 0
                                                    ? data_left[8] =
                                                        listviewData2[0]
                                                            .imgPlate
                                                    : data_left[8];

                                                data_click[0] == 0
                                                    ? data_left[9] =
                                                        listviewData2[0].video
                                                    : data_left[9];

                                                data_click[0] == 0
                                                    ? data_left[10] =
                                                        listviewData2[0].time
                                                    : data_left[10];

                                                data_click[0] == 0
                                                    ? data_left[11] =
                                                        listviewData2[0].date
                                                    : data_left[11];

                                                // ส่งข้อมูลไปหน้าถัดไป
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          VideoScreenWidget(
                                                            license_plate:
                                                                data_left[0],
                                                            name: data_left[1],
                                                            city: data_left[2],
                                                            vehicle:
                                                                data_left[3],
                                                            vehicle_type_img:
                                                                data_left[6],
                                                            color: data_left[4],
                                                            color_code:
                                                                data_left[7],
                                                            img: data_left[5],
                                                            img_plate:
                                                                data_left[8],
                                                            video: data_left[9],
                                                            time: data_left[10],
                                                            date: data_left[11],
                                                            search_plate: widget
                                                                .search_plate,
                                                          )),
                                                );
                                              },
                                              text: 'ค้นหาวิดีโอจากกล้อง',
                                              options: FFButtonOptions(
                                                width: 230,
                                                height: 50,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                textStyle: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                  fontFamily: 'Mitr',
                                                  color: Color.fromARGB(
                                                      255, 46, 46, 46),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 160, 182, 255),
                                                  width: 2,
                                                ),
                                                borderRadius: 50,
                                              ),
                                            ),
                                          ),

                                          // เส้นขั้น
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 20, 0, 20),
                                            child: Container(
                                              width: double.infinity,
                                              height: 3,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 160, 182, 255),
                                              ),
                                            ),
                                          ),

                                          // แถบโหลดข้อมูล
                                          // Padding(
                                          //   padding:
                                          //       EdgeInsetsDirectional.fromSTEB(
                                          //           0, 20, 0, 10),
                                          //   child: LinearPercentIndicator(
                                          //     percent: 0.5,
                                          //     width: 600,
                                          //     lineHeight: 5,
                                          //     animation: true,
                                          //     progressColor: Color.fromARGB(
                                          //         255, 160, 182, 255),
                                          //     backgroundColor: Color.fromARGB(
                                          //         0, 255, 255, 255),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
