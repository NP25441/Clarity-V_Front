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
  const ResultScreenWidget({
    Key? key,
    required this.license_plate,
    required this.city,
    required this.search_plate,
    required this.type_car,
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
    0, //ป้าย
    0, // ชื่อ
    0, // จังหวัด
    0, // ประเภท
    0, // สี
    0, // ภาพ
    0, // รูปประเภทรถ
    'Color(0xFF8E8E8E)', // ช้อมูลสี
    0, // โหลดข้อมูล
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
                                              width: 550,
                                              height: 450,
                                              child: Stack(
                                                children: [
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
                                                  // Align(
                                                  //   alignment:
                                                  //       AlignmentDirectional(
                                                  //           0.96, 0.95),
                                                  //   child: ClipRRect(
                                                  //     borderRadius:
                                                  //         BorderRadius.circular(
                                                  //             20),
                                                  //     child: Image.asset(
                                                  //       'assets/images/Example_Demo/Palte.jpg',
                                                  //       width: 200,
                                                  //       height: 100,
                                                  //       fit: BoxFit.cover,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
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
                                                  //       color: Color.fromARGB(255,
                                                  //             239, 238, 233),
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
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: FFButtonWidget(
                                              onPressed: () {
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
                                                            search_plate: widget
                                                                .search_plate,
                                                          )),
                                                );
                                              },
                                              text: 'ค้นหาภาพจากกล้อง',
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
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 20, 0, 10),
                                            child: LinearPercentIndicator(
                                              percent: 0.5,
                                              width: 600,
                                              lineHeight: 5,
                                              animation: true,
                                              progressColor: Color.fromARGB(
                                                  255, 160, 182, 255),
                                              backgroundColor: Color.fromARGB(
                                                  0, 255, 255, 255),
                                            ),
                                          ),
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
