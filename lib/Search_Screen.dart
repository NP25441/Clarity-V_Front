import 'package:clarity_v/Result_Sceen.dart';
// import 'package:clarity_v/api_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'flutter flow/flutter_flow_util.dart';
import 'flutter flow/flutter_flow_widgets.dart';
import 'flutter flow/flutter_flow_theme.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
import 'package:time_range_picker/time_range_picker.dart';

class SearcScreenWidget extends StatefulWidget {
  const SearcScreenWidget({Key? key}) : super(key: key);

  @override
  _SearcScreenWidgetState createState() => _SearcScreenWidgetState();
}

class _SearcScreenWidgetState extends State<SearcScreenWidget>
    with TickerProviderStateMixin {
  // ตั้งค่าเริ่มต้นเป็น False เพื่อซ่อนการแสดงหน้าของสี
  bool click_color = false;

  // ค่าของสี
  List color_Onclick = ['-'];

  // ส่ง data เข้า API
  List data_Search = [
    // ตัวแปรการค้นหา
    "", // ป้ายทะเบียน
    "", // จังหวัด
    "ไม่ระบุวันที่", // วันที่
    "00:00", // เวลาเริ่ม
    "00:00", // เวลาจบ
    '', // สี
    "-", // ประเภทรถเก๋ง
    "-", // ประเภทรถกระบะ
    "-", // ประเภทรถตู้
    "-", // ประเภทรถบรรทุก
    "-", // รวมทุกประเภท
  ];

  // ตั้งค่าวันที่เริ่มต้น
  DateTime date = DateTime.now();

  // เก็บค่าเปลี่ยนสีปุ่ม
  List onClick_typeCar = [
    0, // รถเก๋ง
    0, // รถกระบะ
    0, // รถตู้
    0, // รถบรรทุก
  ];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  //  แสดงข้อมูลป้ายที่ค้นหา
  String search_plate = "ไม่ได้ใส่หมายเลขป้ายทะเบียน";

  // ตั้งค่าเวลาเริ่มต้น
  TimeOfDay time_start = TimeOfDay(hour: 00, minute: 00);

  // ตั้งค่าเวลาเริ่มต้น
  TimeOfDay time_end = TimeOfDay(hour: 00, minute: 00);

  //  หน้า UI
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // ฟังก์ชันการแสดงวันที่
  String getTextdate() {
    return data_Search[2];
  }

  // ฟังก์ชันการแสดงเวลาที่เริ่มต้น
  String getTexttime_form() {
    if (data_Search[2] == 'ไม่ระบุวันที่') {
      data_Search[3] = 'ไม่ระบุเวลา';
      return data_Search[3];
    } else {
      final hours = time_start.hour.toString().padLeft(2, '0');
      final minutes = time_start.minute.toString().padLeft(2, '0');

      data_Search[3] = '$hours:$minutes'; //เก็บข้อมูลไว้ใน List
      print(data_Search[3]); //แสดงค่าเวลาเริ่มต้น
      return '$hours:$minutes';
    }
  }

  // ฟังก์ชันการแสดงเวลาที่สิ้นสุด
  String getTexttime_to() {
    if (data_Search[3] == 'ไม่ระบุเวลา') {
      data_Search[4] = 'ไม่ระบุเวลา';
      return data_Search[4];
    } else {
      final hours = time_end.hour.toString().padLeft(2, '0');
      final minutes = time_end.minute.toString().padLeft(2, '0');

      data_Search[4] = '$hours:$minutes'; //เก็บข้อมูลไว้ใน List
      print(data_Search[4]); //แสดงค่าเวลาจบ
      return '$hours:$minutes';
    }
  }

  // ฟังก์ชันการเลือกวันที่
  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    );

    setState(() {
      if (newDate == null) {
        data_Search[2] = 'ไม่ระบุวันที่';
        return data_Search[2];
      } else {
        data_Search[2] = '${newDate.day}/${newDate.month}/${newDate.year}';
      }
      date = newDate;
    });
  }

  // ฟังก์ชันการเลือกเวลาเริ่ม
  Future rangeTime(BuildContext context) async {
    final TimeRange? result = await showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        TimeOfDay startTime = TimeOfDay(hour: 6, minute: 00);
        TimeOfDay endTime = TimeOfDay(hour: 18, minute: 00);
        return CupertinoAlertDialog(
          content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 350,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: TimeRangePicker(
                      padding: 36,
                      hideButtons: true,
                      handlerRadius: 8,
                      strokeWidth: 6,
                      interval: const Duration(hours: 1),
                      minDuration: const Duration(hours: 1),
                      ticks: 24,
                      rotateLabels: false,
                      snap: true,
                      labels: [
                        "24 h",
                        "3 h",
                        "6 h",
                        "9 h",
                        "12 h",
                        "15 h",
                        "18 h",
                        "21 h"
                      ].asMap().entries.map((e) {
                        return ClockLabel.fromIndex(
                            idx: e.key, length: 8, text: e.value);
                      }).toList(),
                      activeTimeTextStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 25,
                          color: Colors.white),
                      timeTextStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 25,
                          color: Color.fromARGB(129, 255, 255, 255)),
                      onStartChange: (start) {
                        setState(() {
                          startTime = start;
                        });
                        print('test{$start}');
                      },
                      onEndChange: (end) {
                        setState(() {
                          endTime = end;
                        });
                      },
                    ),
                  )
                ],
              )),
          actions: <Widget>[
            CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text(
                  'ยกเลิก',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Mitr',
                    color: Color.fromARGB(255, 46, 46, 46),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            CupertinoDialogAction(
              child: Text(
                'ยืนยัน',
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Mitr',
                  color: Color.fromARGB(255, 81, 121, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(
                  TimeRange(startTime: startTime, endTime: endTime),
                );
                print(startTime);
                print(endTime);
                setState(() => {time_start = startTime, time_end = endTime});
              },
            ),
          ],
        );
      },
    );
    if (kDebugMode) {
      print(result.toString());
    }
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
        child: Stack(
          children: [
            Align(
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // หัวข้อ (ป้ายทะเบียน)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text(
                            'ค้นหาป้ายทะเบียน',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Mitr',
                              color: Color.fromARGB(255, 46, 46, 46),
                              fontSize: 50,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        // หัวข้อ (ช่องค้นหาป้ายทะเบียน)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            height: 130,
                            decoration: BoxDecoration(),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ป้ายทะเบียน',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Mitr',
                                      color: Color.fromARGB(255, 46, 46, 46),
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  // ช่องค้นหาป้ายทะเบียน
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        50, 5, 50, 0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText:
                                            'กรุณาใส่หมายเลขป้ายทะเบียน เช่น กขค-1234',
                                        hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 155, 155, 155),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 160, 182, 255),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 160, 182, 255),
                                            width: 5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      onChanged: (value) {
                                        search_plate = value;
                                        data_Search[0] = value;
                                      },
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Mitr',
                                        color:
                                            Color.fromARGB(255, 141, 168, 255),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // หัวข้อ (ช่องค้นหาจังหวัด)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            height: 130,
                            decoration: BoxDecoration(),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'จังหวัด',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Mitr',
                                      color: Color.fromARGB(255, 46, 46, 46),
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  // ช่องค้นหาจังหวัด
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        50, 5, 50, 0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'กรุณาใส่จังหวัด เช่น พะเยา',
                                        hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 155, 155, 155),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 160, 182, 255),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 160, 182, 255),
                                            width: 5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      onChanged: (value) {
                                        // city = value;
                                        data_Search[1] = value;
                                      },
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Mitr',
                                        color:
                                            Color.fromARGB(255, 141, 168, 255),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // หัวข้อ (วันที่, เวลา, สี)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            height: 130,
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // หัวข้อ (วันที่)
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'วัน / เดือน / ปี',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Mitr',
                                          color:
                                              Color.fromARGB(255, 46, 46, 46),
                                          fontSize: 30,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      // ช่องใส่วันที่
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 5, 0, 0),
                                        child: Container(
                                            width: 250,
                                            decoration: BoxDecoration(),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(50, 0, 0, 0),
                                              child: FFButtonWidget(
                                                onPressed: () {
                                                  pickDate(context);
                                                },
                                                text: getTextdate(),
                                                options: FFButtonOptions(
                                                  width: double.infinity,
                                                  height: 60,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  textStyle: FlutterFlowTheme
                                                      .subtitle2
                                                      .override(
                                                    fontFamily: 'Mitr',
                                                    color: Color.fromARGB(
                                                        255, 141, 168, 255),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 160, 182, 255),
                                                    width: 2,
                                                  ),
                                                  borderRadius: 12,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height:
                                      MediaQuery.of(context).size.height * 1,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // หัวข้อ (เวลา)
                                        Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'เวลาโดยประมาณ',
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme
                                                      .bodyText1
                                                      .override(
                                                    fontFamily: 'Mitr',
                                                    color: Color.fromARGB(
                                                        255, 46, 46, 46),
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    // ช่องใส่เวลาเริ่มต้น
                                                    Container(
                                                      width: 250,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: FFButtonWidget(
                                                        onPressed: () {
                                                          if (data_Search[2] ==
                                                              'ไม่ระบุวันที่') {
                                                            showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                title: Center(
                                                                    child: Text(
                                                                  'แจ้งเตือน',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: FlutterFlowTheme
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
                                                                    fontSize:
                                                                        35,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                )),
                                                                content: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        'ไม่สามารถระบุเวลาได้หากไม่ทำการระบุ วันที่',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme
                                                                            .bodyText1
                                                                            .override(
                                                                          fontFamily:
                                                                              'Mitr',
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              46,
                                                                              46,
                                                                              46),
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    child: Text(
                                                                      'ตกลง',
                                                                      style: FlutterFlowTheme
                                                                          .subtitle2
                                                                          .override(
                                                                        fontFamily:
                                                                            'Mitr',
                                                                        color: Color(
                                                                            0xFF42A5F5),
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                      ),
                                                                    ),
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context,
                                                                            'ย้อนกลับ'),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          } else {
                                                            rangeTime(context);
                                                          }
                                                        },
                                                        text:
                                                            getTexttime_form() +
                                                                '  -  ' +
                                                                getTexttime_to(),
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              double.infinity,
                                                          height: 60,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          textStyle:
                                                              FlutterFlowTheme
                                                                  .subtitle2
                                                                  .override(
                                                            fontFamily: 'Mitr',
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    141,
                                                                    168,
                                                                    255),
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    160,
                                                                    182,
                                                                    255),
                                                            width: 2,
                                                          ),
                                                          borderRadius: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    // Padding(
                                                    //   padding:
                                                    //       EdgeInsetsDirectional
                                                    //           .fromSTEB(
                                                    //               10, 0, 10, 0),
                                                    //   child: Text(
                                                    //     'ถึง',
                                                    //     style: FlutterFlowTheme
                                                    //         .bodyText1
                                                    //         .override(
                                                    //       fontFamily: 'Mitr',
                                                    //       color: Color.fromARGB(
                                                    //           255, 46, 46, 46),
                                                    //       fontSize: 20,
                                                    //       fontWeight:
                                                    //           FontWeight.w300,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // ช่องใส่เวลาจบ
                                                    // Padding(
                                                    //   padding:
                                                    //       EdgeInsetsDirectional
                                                    //           .fromSTEB(
                                                    //               0, 5, 0, 0),
                                                    //   child: Container(
                                                    //     width: 160,
                                                    //     decoration:
                                                    //         BoxDecoration(),
                                                    //     child: FFButtonWidget(
                                                    //       onPressed:
                                                    //           () async {},
                                                    //       text:
                                                    //           getTexttime_to(),
                                                    //       options:
                                                    //           FFButtonOptions(
                                                    //         width:
                                                    //             double.infinity,
                                                    //         height: 60,
                                                    //         color:
                                                    //             Color.fromARGB(
                                                    //                 255,
                                                    //                 255,
                                                    //                 255,
                                                    //                 255),
                                                    //         textStyle:
                                                    //             FlutterFlowTheme
                                                    //                 .subtitle2
                                                    //                 .override(
                                                    //           fontFamily:
                                                    //               'Mitr',
                                                    //           color: Color
                                                    //               .fromARGB(
                                                    //                   255,
                                                    //                   141,
                                                    //                   168,
                                                    //                   255),
                                                    //           fontSize: 20,
                                                    //           fontWeight:
                                                    //               FontWeight
                                                    //                   .w300,
                                                    //         ),
                                                    //         borderSide:
                                                    //             BorderSide(
                                                    //           color: Color
                                                    //               .fromARGB(
                                                    //                   255,
                                                    //                   160,
                                                    //                   182,
                                                    //                   255),
                                                    //           width: 2,
                                                    //         ),
                                                    //         borderRadius: 12,
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // หัวข้อ (สี)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'สีรถ',
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Mitr',
                                                  color: Color.fromARGB(
                                                      255, 46, 46, 46),
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 5, 0, 0),
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: FFButtonWidget(
                                                    onPressed: () {
                                                      setState(() {
                                                        click_color =
                                                            true; // เปลี่ยนค่าให้เป็นจริงเพื่อแสดง
                                                        print(data_Search);
                                                      });
                                                    },
                                                    text: '',
                                                    options: FFButtonOptions(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      color: color_Onclick[0] ==
                                                              '-'
                                                          ? Color.fromARGB(255,
                                                              239, 238, 233)
                                                          : color_Onclick[0],
                                                      textStyle:
                                                          FlutterFlowTheme
                                                              .subtitle2
                                                              .override(
                                                        fontFamily: 'Poppins',
                                                        color: Color.fromARGB(
                                                            255, 239, 238, 233),
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
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // หัวข้อประเภทรถ
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            height: 130,
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ประเภทรถ',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Mitr',
                                    color: Color.fromARGB(255, 46, 46, 46),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // ประเภทรถ(รถเก๋ง)
                                      Tooltip(
                                        triggerMode: TooltipTriggerMode.manual,
                                        message: ' รถเก๋ง ',
                                        padding: const EdgeInsets.all(5.0),
                                        preferBelow: false,
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Mitr',
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (onClick_typeCar[0] == 1) {
                                                onClick_typeCar[0] = 0;
                                                data_Search[6] = '-';
                                                print(data_Search[6]);
                                              } else {
                                                onClick_typeCar[0] = 1;
                                                data_Search[6] = 'รถเก๋ง';
                                                print(data_Search[6]);
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: onClick_typeCar[0] == 0
                                                  ? Color.fromARGB(
                                                      255, 255, 255, 255)
                                                  : Color.fromARGB(
                                                      100, 160, 182, 255),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 160, 182, 255),
                                                width: 2,
                                              ),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 5, 5, 5),
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
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Mitr',
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        child: GestureDetector(
                                          // ประเภทรถ(กระบะ)
                                          onTap: () {
                                            setState(() {
                                              if (onClick_typeCar[1] == 1) {
                                                onClick_typeCar[1] = 0;
                                                data_Search[7] = '-';
                                                print(data_Search[7]);
                                              } else {
                                                onClick_typeCar[1] = 1;
                                                data_Search[7] = 'รถกระบะ';
                                                print(data_Search[7]);
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: onClick_typeCar[1] == 0
                                                  ? Color.fromARGB(
                                                      255, 255, 255, 255)
                                                  : Color.fromARGB(
                                                      100, 160, 182, 255),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 160, 182, 255),
                                                width: 2,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 5, 5, 5),
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
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Mitr',
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
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
                                                data_Search[8] = '-';
                                                print(data_Search[8]);
                                              } else {
                                                onClick_typeCar[2] = 1;
                                                data_Search[8] = 'รถตู้';
                                                print(data_Search[8]);
                                                print(data_Search[2]);
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: onClick_typeCar[2] == 0
                                                  ? Color.fromARGB(
                                                      255, 255, 255, 255)
                                                  : Color.fromARGB(
                                                      100, 160, 182, 255),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 160, 182, 255),
                                                width: 2,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 5, 5, 5),
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
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Mitr',
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
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
                                                data_Search[9] = '-';
                                                print(data_Search[9]);
                                              } else {
                                                onClick_typeCar[3] = 1;
                                                data_Search[9] = 'รถบรรทุก';
                                                print(data_Search[9]);
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: onClick_typeCar[3] == 0
                                                  ? Color.fromARGB(
                                                      255, 255, 255, 255)
                                                  : Color.fromARGB(
                                                      100, 160, 182, 255),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 160, 182, 255),
                                                width: 2,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 5, 5, 5),
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
                              ],
                            ),
                          ),
                        ),
                        // ส่งค่าไปหน้าต่อไป
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(450, 20, 450, 20),
                          child: FFButtonWidget(
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Center(
                                    child: Text(
                                  'ตรวจสอบข้อมูลที่จะค้นหา',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Mitr',
                                    color: Color.fromARGB(255, 46, 46, 46),
                                    fontSize: 35,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        ' หมายเลขป้ายทะเบียน :  ${data_Search[0] == '' ? data_Search[0] = "ไม่ได้ใส่ข้อมูล" : data_Search[0]} \n จังหวัด :   ${data_Search[1] == '' ? data_Search[1] = "ไม่ได้ใส่ข้อมูล" : data_Search[1]} \n วันที่ :  ${data_Search[2]} \n ตั้งแต่เวลา :  ${data_Search[3]}   ถึง    ${data_Search[4]} \n สีรถ :  ${data_Search[5] == '' ? data_Search[5] = "ไม่กำหนดสี" : data_Search[5]} \n ประเภทรถที่เลือก :  ${onClick_typeCar[0] == 0 ? "" : data_Search[6]} ${onClick_typeCar[1] == 0 ? "" : data_Search[7]} ${onClick_typeCar[2] == 0 ? "" : data_Search[8]} ${onClick_typeCar[3] == 0 ? "" : data_Search[9]}${onClick_typeCar.contains(1) ? "" : data_Search[10] = 'รถเก๋ง รถกระบะ รถตู้ รถบรรทุก'}\n\n ** หากไม่มีการเลือกประเภทรถ จะเป็นการค้นหาทุกประเภท ** ',
                                        textAlign: TextAlign.start,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Mitr',
                                          color:
                                              Color.fromARGB(255, 46, 46, 46),
                                          fontSize: 25,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      'ย้อนกลับ',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Mitr',
                                        color: Color(0xFF1976D2),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    onPressed: () =>
                                        Navigator.pop(context, 'ย้อนกลับ'),
                                  ),
                                  TextButton(
                                    child: Text(
                                      'เริ่มค้นหา',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Mitr',
                                        color: Color(0xFF42A5F5),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    onPressed: () {
                                      // ส่งตัวไหนไปงง searchplate มันเป็  stng
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResultScreenWidget(
                                                  license_plate: data_Search[0],
                                                  city: data_Search[1],
                                                  date: data_Search[2],
                                                  time_in: data_Search[3],
                                                  time_out: data_Search[4],
                                                  search_plate: search_plate,
                                                  type_car: onClick_typeCar,
                                                  type_car_data_1:
                                                      data_Search[6],
                                                  type_car_data_2:
                                                      data_Search[7],
                                                  type_car_data_3:
                                                      data_Search[8],
                                                  type_car_data_4:
                                                      data_Search[9],
                                                  color: data_Search[5],
                                                )),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                            text: 'ค้นหา',
                            options: FFButtonOptions(
                              width: 300,
                              height: 50,
                              color: Color.fromARGB(255, 255, 255, 255),
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Mitr',
                                color: Color.fromARGB(255, 46, 46, 46),
                                fontSize: 30,
                                fontWeight: FontWeight.w300,
                              ),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 160, 182, 255),
                                width: 2,
                              ),
                              borderRadius: 89,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // สีทั้งหมด
            click_color
                ? Align(
                    alignment: AlignmentDirectional(-0.04, 0.08),
                    child: Container(
                      width: 300,
                      height: 270,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 199, 199, 199),
                        borderRadius: BorderRadius.circular(50),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Color.fromARGB(255, 160, 182, 255),
                          width: 5,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 46, 46, 46),
                                    width: 0,
                                  ),
                                ),
                                child: Tooltip(
                                  triggerMode: TooltipTriggerMode.manual,
                                  message: ' สีแดง ',
                                  padding: const EdgeInsets.all(5.0),
                                  preferBelow: false,
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Mitr',
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      data_Search[5] = 'สีแดง';
                                      color_Onclick[0] = Color(0xFFFD0110);
                                      setState(() {
                                        click_color = false;
                                      });
                                      print('สีแดง');
                                    },
                                    text: '',
                                    options: FFButtonOptions(
                                      width: 60,
                                      height: 60,
                                      color: Color(0xFFFD0110),
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Mitr',
                                        color: Color.fromARGB(255, 46, 46, 46),
                                      ),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 160, 182, 255),
                                        width: 3,
                                      ),
                                      borderRadius: 50,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 46, 46, 46),
                                      width: 0,
                                    ),
                                  ),
                                  child: Tooltip(
                                    triggerMode: TooltipTriggerMode.manual,
                                    message: ' สีน้ำเงิน ',
                                    padding: const EdgeInsets.all(5.0),
                                    preferBelow: false,
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Mitr',
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        data_Search[5] = 'สีน้ำเงิน';
                                        color_Onclick[0] = Color(0xFF0012FF);
                                        setState(() {
                                          click_color = false;
                                        });
                                        print('สีน้ำเงิน');
                                      },
                                      text: '',
                                      options: FFButtonOptions(
                                        width: 60,
                                        height: 60,
                                        color: Color(0xFF0012FF),
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Mitr',
                                          color:
                                              Color.fromARGB(255, 46, 46, 46),
                                        ),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 160, 182, 255),
                                          width: 3,
                                        ),
                                        borderRadius: 50,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 46, 46, 46),
                                      width: 0,
                                    ),
                                  ),
                                  child: Tooltip(
                                    triggerMode: TooltipTriggerMode.manual,
                                    message: ' สีเหลือง ',
                                    padding: const EdgeInsets.all(5.0),
                                    preferBelow: false,
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Mitr',
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        data_Search[5] = 'สีเหลือง';
                                        color_Onclick[0] = Color(0xFFFEFB00);
                                        setState(() {
                                          click_color = false;
                                        });
                                        print('สีเหลือง');
                                      },
                                      text: '',
                                      options: FFButtonOptions(
                                        width: 60,
                                        height: 60,
                                        color: Color(0xFFFEFB00),
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Mitr',
                                          color:
                                              Color.fromARGB(255, 46, 46, 46),
                                        ),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 160, 182, 255),
                                          width: 3,
                                        ),
                                        borderRadius: 50,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 46, 46, 46),
                                      width: 0,
                                    ),
                                  ),
                                  child: Tooltip(
                                    triggerMode: TooltipTriggerMode.manual,
                                    message: ' สีขาว ',
                                    padding: const EdgeInsets.all(5.0),
                                    preferBelow: false,
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Mitr',
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        data_Search[5] = 'สีขาว';
                                        color_Onclick[0] =
                                            Color.fromARGB(255, 255, 255, 255);
                                        setState(() {
                                          click_color = false;
                                        });
                                        print('สีขาว');
                                      },
                                      text: '',
                                      options: FFButtonOptions(
                                        width: 60,
                                        height: 60,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Mitr',
                                          color:
                                              Color.fromARGB(255, 46, 46, 46),
                                        ),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 160, 182, 255),
                                          width: 3,
                                        ),
                                        borderRadius: 50,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 46, 46, 46),
                                      width: 0,
                                    ),
                                  ),
                                  child: Tooltip(
                                    triggerMode: TooltipTriggerMode.manual,
                                    message: ' สีดำ ',
                                    padding: const EdgeInsets.all(5.0),
                                    preferBelow: false,
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Mitr',
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        data_Search[5] = 'สีดำ';
                                        color_Onclick[0] = Colors.black;
                                        setState(() {
                                          click_color = false;
                                        });
                                        print('สีดำ');
                                      },
                                      text: '',
                                      options: FFButtonOptions(
                                        width: 60,
                                        height: 60,
                                        color: Colors.black,
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Mitr',
                                          color:
                                              Color.fromARGB(255, 46, 46, 46),
                                        ),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 160, 182, 255),
                                          width: 3,
                                        ),
                                        borderRadius: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Color.fromARGB(255, 46, 46, 46),
                                        width: 0,
                                      ),
                                    ),
                                    child: Tooltip(
                                      triggerMode: TooltipTriggerMode.manual,
                                      message: ' สีม่วง ',
                                      padding: const EdgeInsets.all(5.0),
                                      preferBelow: false,
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Mitr',
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          data_Search[5] = 'สีม่วง';
                                          color_Onclick[0] = Color(0xFF6F36A9);
                                          setState(() {
                                            click_color = false;
                                          });
                                          print('สีม่วง');
                                        },
                                        text: '',
                                        options: FFButtonOptions(
                                          width: 60,
                                          height: 60,
                                          color: Color(0xFF6F36A9),
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Mitr',
                                            color:
                                                Color.fromARGB(255, 46, 46, 46),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 160, 182, 255),
                                            width: 3,
                                          ),
                                          borderRadius: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Color.fromARGB(255, 46, 46, 46),
                                        width: 0,
                                      ),
                                    ),
                                    child: Tooltip(
                                      triggerMode: TooltipTriggerMode.manual,
                                      message: ' สีเขียว ',
                                      padding: const EdgeInsets.all(5.0),
                                      preferBelow: false,
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Mitr',
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          data_Search[5] = 'สีเขียว';
                                          color_Onclick[0] = Color(0xFF08810E);
                                          setState(() {
                                            click_color = false;
                                          });
                                          print('สีเขียว');
                                        },
                                        text: '',
                                        options: FFButtonOptions(
                                          width: 60,
                                          height: 60,
                                          color: Color(0xFF08810E),
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Mitr',
                                            color:
                                                Color.fromARGB(255, 46, 46, 46),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 160, 182, 255),
                                            width: 3,
                                          ),
                                          borderRadius: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Color.fromARGB(255, 46, 46, 46),
                                        width: 0,
                                      ),
                                    ),
                                    child: Tooltip(
                                      triggerMode: TooltipTriggerMode.manual,
                                      message: ' สีส้ม ',
                                      padding: const EdgeInsets.all(5.0),
                                      preferBelow: false,
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Mitr',
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          data_Search[5] = 'สีส้ม';
                                          color_Onclick[0] = Color(0xFFFE8A00);
                                          setState(() {
                                            click_color = false;
                                          });
                                          print('สีส้ม');
                                        },
                                        text: '',
                                        options: FFButtonOptions(
                                          width: 60,
                                          height: 60,
                                          color: Color(0xFFFE8A00),
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Mitr',
                                            color:
                                                Color.fromARGB(255, 46, 46, 46),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 160, 182, 255),
                                            width: 3,
                                          ),
                                          borderRadius: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 46, 46, 46),
                                      width: 0,
                                    ),
                                  ),
                                  child: Tooltip(
                                    triggerMode: TooltipTriggerMode.manual,
                                    message: ' สีแดงเลือดหมู ',
                                    padding: const EdgeInsets.all(5.0),
                                    preferBelow: false,
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Mitr',
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        data_Search[5] = 'สีแดงเลือดหมู';
                                        color_Onclick[0] = Color(0xFF901901);
                                        setState(() {
                                          click_color = false;
                                        });
                                        print('สีแดงเลือดหมู');
                                      },
                                      text: '',
                                      options: FFButtonOptions(
                                        width: 60,
                                        height: 60,
                                        color: Color(0xFF901901),
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Mitr',
                                          color:
                                              Color.fromARGB(255, 46, 46, 46),
                                        ),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 160, 182, 255),
                                          width: 3,
                                        ),
                                        borderRadius: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Color.fromARGB(255, 46, 46, 46),
                                        width: 0,
                                      ),
                                    ),
                                    child: Tooltip(
                                      triggerMode: TooltipTriggerMode.manual,
                                      message: ' สีชมพู ',
                                      padding: const EdgeInsets.all(5.0),
                                      preferBelow: false,
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Mitr',
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          data_Search[5] = 'สีชมพู';
                                          color_Onclick[0] = Color(0xFFFF6790);
                                          setState(() {
                                            click_color = false;
                                          });
                                          print('สีชมพู');
                                        },
                                        text: '',
                                        options: FFButtonOptions(
                                          width: 60,
                                          height: 60,
                                          color: Color(0xFFFF6790),
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Mitr',
                                            color:
                                                Color.fromARGB(255, 46, 46, 46),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 160, 182, 255),
                                            width: 3,
                                          ),
                                          borderRadius: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Color.fromARGB(255, 46, 46, 46),
                                        width: 0,
                                      ),
                                    ),
                                    child: Tooltip(
                                      triggerMode: TooltipTriggerMode.manual,
                                      message: ' สีเทา ',
                                      padding: const EdgeInsets.all(5.0),
                                      preferBelow: false,
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Mitr',
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          data_Search[5] = 'สีเทา';
                                          color_Onclick[0] = Color(0xFF8E8E8E);
                                          setState(() {
                                            click_color = false;
                                          });
                                          print('สีเทา');
                                        },
                                        text: '',
                                        options: FFButtonOptions(
                                          width: 60,
                                          height: 60,
                                          color: Color(0xFF8E8E8E),
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Mitr',
                                            color:
                                                Color.fromARGB(255, 46, 46, 46),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 160, 182, 255),
                                            width: 3,
                                          ),
                                          borderRadius: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Color.fromARGB(255, 46, 46, 46),
                                        width: 0,
                                      ),
                                    ),
                                    child: Tooltip(
                                      triggerMode: TooltipTriggerMode.manual,
                                      message: ' สีฟ้า ',
                                      padding: const EdgeInsets.all(5.0),
                                      preferBelow: false,
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Mitr',
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          data_Search[5] = 'สีฟ้า';
                                          color_Onclick[0] = Color(0xFF00D0FD);
                                          setState(() {
                                            click_color = false;
                                          });
                                          print('สีฟ้า');
                                        },
                                        text: '',
                                        options: FFButtonOptions(
                                          width: 60,
                                          height: 60,
                                          color: Color(0xFF00D0FD),
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Mitr',
                                            color:
                                                Color.fromARGB(255, 46, 46, 46),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 160, 182, 255),
                                            width: 3,
                                          ),
                                          borderRadius: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FFButtonWidget(
                                  onPressed: () {
                                    data_Search[5] = '';
                                    color_Onclick[0] =
                                        Color.fromARGB(255, 239, 238, 233);
                                    setState(() {
                                      click_color = false;
                                    });
                                  },
                                  text: 'ไม่กำหนดสี',
                                  options: FFButtonOptions(
                                    width: 200,
                                    height: 50,
                                    color: Color.fromARGB(255, 239, 238, 233),
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Color.fromARGB(255, 46, 46, 46),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 160, 182, 255),
                                      width: 3,
                                    ),
                                    borderRadius: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }
}
