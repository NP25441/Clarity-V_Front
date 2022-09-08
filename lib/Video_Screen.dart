import 'package:clarity_v/Search_Screen.dart';
import 'package:clarity_v/flutter%20flow/flutter_flow_theme.dart';
import 'package:clarity_v/flutter%20flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert' as convert;

import 'api_model.dart';

class VideoScreenWidget extends StatefulWidget {
  final String license_plate;
  final String city;
  final String search_plate;
  const VideoScreenWidget(
      {Key? key,
      required this.license_plate,
      required this.city,
      required this.search_plate})
      : super(key: key);

  @override
  _VideoScreenWidgetState createState() => _VideoScreenWidgetState();
}

class _VideoScreenWidgetState extends State<VideoScreenWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final url =
      'file://D:/Develop/Flutter Project/clarity_v/video_download_front';

  // ส่งค่าให้กับ Api
  var data_api = Data_Api();

// //  เชื่อมต่อกับ API
//   showdata_Result() async {
//     final res = await http.get(
//       Uri.parse("$url"),
//       headers: {
//         "Accept": "application/json",
//         "Access-Control_Allow_Origin": "*",
//       },
//     );
//     print('res.statusCode: ${res.statusCode}');
//     print('res.headers: ${res.headers}');
//     print('body = ${res.body}');
//     final data = convert.jsonDecode(res.body) as Map<String, dynamic>;
//     print("getProfile: ${data[1]}");
//     print(data["message"]);
//     setState(() {
//       data_api = Data_Api.fromJson(data);
//     });
//   }

  //   //  หน้า UI
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // showdata_Result();
  // }

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
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 40, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.453,
                      height: MediaQuery.of(context).size.height * 0.85,
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Container(
                              width: 650,
                              height: 550,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/Example_Demo/Car.jpg',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.96, 0.95),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        'assets/images/Example_Demo/Palte.jpg',
                                        width: 220,
                                        height: 140,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.47,
                        height: MediaQuery.of(context).size.height * 0.71,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                              child: Container(
                                width: double.infinity,
                                height: 55,
                                decoration: BoxDecoration(),
                                child: Text(
                                  '${widget.license_plate}',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Mitr',
                                    color: Color.fromARGB(255, 46, 46, 46),
                                    fontSize: 40,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Container(
                                width: double.infinity,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 160, 182, 255),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'ชื่อเจ้าของรถ :',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Mitr',
                                        color: Color.fromARGB(255, 46, 46, 46),
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        'นายตัวอย่าง สมมุติ',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Mitr',
                                          color:
                                              Color.fromARGB(255, 46, 46, 46),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'จังหวัด :',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Mitr',
                                        color: Color.fromARGB(255, 46, 46, 46),
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        '${widget.city}',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Mitr',
                                          color:
                                              Color.fromARGB(255, 46, 46, 46),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'ประเภทรถ :',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Mitr',
                                        color: Color.fromARGB(255, 46, 46, 46),
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        'รถกระบะ',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Mitr',
                                          color:
                                              Color.fromARGB(255, 46, 46, 46),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Image.asset(
                                        'assets/images/Pickup.png',
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
                                  EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'สี :',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Mitr',
                                        color: Color.fromARGB(255, 46, 46, 46),
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        'สีดำ',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Mitr',
                                          color:
                                              Color.fromARGB(255, 46, 46, 46),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 160, 182, 255),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 40, 20, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  }
                                  print('เข้าถึง DIR');
                                },
                                text: 'เปิดตำแหน่งของไฟล์',
                                options: FFButtonOptions(
                                  width: 230,
                                  height: 50,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Mitr',
                                    color: Color.fromARGB(255, 46, 46, 46),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 160, 182, 255),
                                    width: 2,
                                  ),
                                  borderRadius: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
