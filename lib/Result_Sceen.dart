import 'package:clarity_v/Search_Screen.dart';
import 'package:clarity_v/Video_Screen.dart';
import 'package:clarity_v/flutter%20flow/flutter_flow_theme.dart';
import 'package:clarity_v/flutter%20flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultScreenWidget extends StatefulWidget {
  final String license_plate;
  final String city;
  const ResultScreenWidget(
      {Key? key, required this.license_plate, required this.city})
      : super(key: key);

  @override
  _ResultScreenWidgetState createState() => _ResultScreenWidgetState();
}

class _ResultScreenWidgetState extends State<ResultScreenWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String license_plate = "ไม่มีข้อมูล";
  String city = "ไม่มีข้อมูล";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF1E2429),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: double.infinity,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFF1D1D1D),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SearcScreenWidget()),
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
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                              child: Text(
                                'ผลการค้นหา',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Mitr',
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Container(
                                    width: 250,
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/Example_Demo/Test 1.jpg',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Container(
                                    width: 250,
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/Example_Demo/Test 2.jpg',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Container(
                                    width: 250,
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/Example_Demo/Test 3.jpg',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Container(
                                    width: 250,
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/Example_Demo/Test 4.jpg',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Container(
                                    width: 250,
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/Example_Demo/Test 5.jpg',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Container(
                                    width: 250,
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/Example_Demo/Test 6.jpg',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Container(
                                    width: 250,
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/Example_Demo/Test 7.jpg',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Container(
                                    width: 250,
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/Example_Demo/Test 8.jpg',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
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
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  height: double.infinity,
                  decoration: BoxDecoration(),
                  child: SingleChildScrollView(
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.96, 0.95),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/images/Example_Demo/Palte.jpg',
                                      width: 200,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(),
                            child: Text(
                              '${widget.license_plate}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Mitr',
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'ชื่อเจ้าของรถ :',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Mitr',
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'นายตัวอย่าง สมมุติ',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Mitr',
                                      color: Colors.white,
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
                          padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'จังหวัด :',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Mitr',
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    '${widget.city}',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Mitr',
                                      color: Colors.white,
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
                          padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'ประเภทรถ :',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Mitr',
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'รถกระบะ',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Mitr',
                                      color: Colors.white,
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
                          padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'ความเร็วโดยเฉลี่ย :',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Mitr',
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    '60',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Mitr',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'กม./ชม.',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Mitr',
                                      color: Colors.white,
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
                          padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'สี :',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Mitr',
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'สีดำ',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Mitr',
                                      color: Colors.white,
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
                                        color: Colors.white,
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
                          child: FFButtonWidget(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoScreenWidget()),
                              );
                            },
                            text: 'ค้นหาภาพจากกล้อง',
                            options: FFButtonOptions(
                              width: 230,
                              height: 50,
                              color: Color(0xFF1D1D1D),
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Mitr',
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: 50,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: LinearPercentIndicator(
                            percent: 1,
                            width: 650,
                            lineHeight: 5,
                            animation: true,
                            progressColor: Colors.white,
                            backgroundColor: Color(0x00000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
