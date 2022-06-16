import 'package:clarity_v/Result_Sceen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'flutter flow/flutter_flow_util.dart';
import 'flutter flow/flutter_flow_widgets.dart';
import 'flutter flow/flutter_flow_theme.dart';

class SearcScreenWidget extends StatefulWidget {
  const SearcScreenWidget({Key? key}) : super(key: key);

  @override
  _SearcScreenWidgetState createState() => _SearcScreenWidgetState();
}

class _SearcScreenWidgetState extends State<SearcScreenWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final initialDate_form = DateTime.now();
  final initialDate_to = DateTime.now();

  String license_plate = "ไม่มีข้อมูล"; // แสดงข้อมูลทะเบียนรถ
  String city = "ไม่มีข้อมูล"; // แสดงข้อมูลจังหวัด
  bool click_color =
      false; // ตั้งค่าเริ่มต้นเป็น False เพื่อซ่อนการแสดงหน้าของสี

  DateTime date = DateTime.now(); // ตั้งค่าวันที่เริ่มต้น
  TimeOfDay time_form = TimeOfDay.now(); // ตั้งค่าเวลาเริ่มต้น
  TimeOfDay time_to = TimeOfDay.now(); // ตั้งค่าเวลาเริ่มต้น

  // ฟังก์ชันการแสดงวันที่
  String getTextdate() {
    if (date == null) {
      return 'Select Date';
    } else {
      data_Search[2] =
          '${date.day}/${date.month}/${date.year}'; //เก็บข้อมูลไว้ใน List
      print(data_Search[2]); // แสดงค่าวันที่ที่เลือก
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  // ฟังก์ชันการแสดงเวลาที่เริ่มต้น
  String getTexttime_form() {
    if (time_form == null) {
      return 'Select Time';
    } else {
      final hours = time_form.hour.toString().padLeft(2, '0');
      final minutes = time_form.minute.toString().padLeft(2, '0');

      data_Search[3] = '$hours:$minutes'; //เก็บข้อมูลไว้ใน List
      print(data_Search[3]); //แสดงค่าเวลาเริ่มต้น
      return '$hours:$minutes';
    }
  }

  // ฟังก์ชันการแสดงเวลาที่สิ้นสุด
  String getTexttime_to() {
    if (time_to == null) {
      return 'Select Time';
    } else {
      final hours = time_to.hour.toString().padLeft(2, '0');
      final minutes = time_to.minute.toString().padLeft(2, '0');

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

    if (newDate == null) return;

    setState(() => date = newDate);
  }

  // ฟังก์ชันการเลือกเวลาเริ่ม
  Future pickTime_form(BuildContext context) async {
    final initialTime_form = TimeOfDay(hour: 0, minute: 0);
    final newTime_form = await showTimePicker(
      context: context,
      initialTime: initialTime_form,
    );

    if (newTime_form == null) return;

    setState(() => time_form = newTime_form);
  }

  // ฟังก์ชันการเลือกเวลาจบ
  Future pickTime_to(BuildContext context) async {
    final initialTime_to = TimeOfDay(hour: 0, minute: 0);
    final newTime_to = await showTimePicker(
      context: context,
      initialTime: initialTime_to,
    );

    if (newTime_to == null) return;

    setState(() => time_to = newTime_to);
  }

  List data_Search = [
    // ตัวแปรการค้นหา
    "-", // ป้ายทะเบียน
    "-", // จังหวัด
    "00/00/0000", // วันที่
    "00:00", // เวลาเริ่ม
    "00:00", // เวลาจบ
    "-", // สี
    "-" // ประเภท
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF1E2429),
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
                        Padding(
                          // หัวข้อ (ป้ายทะเบียน)
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text(
                            'ค้นหาป้ายทะเบียน',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Mitr',
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          // หัวข้อ (ช่องค้นหาป้ายทะเบียน)
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
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Padding(
                                    // ช่องค้นหาป้ายทะเบียน
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        50, 5, 50, 0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'xxx / xxx',
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFF1D1D1D),
                                      ),
                                      onChanged: (value) {
                                        license_plate = value;
                                        data_Search[0] = value;
                                      },
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Mitr',
                                        color: Colors.white,
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
                        Padding(
                          // หัวข้อ (ช่องค้นหาจังหวัด)
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
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Padding(
                                    // ช่องค้นหาจังหวัด
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        50, 5, 50, 0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: '----',
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFF1D1D1D),
                                      ),
                                      onChanged: (value) {
                                        city = value;
                                        data_Search[1] = value;
                                      },
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Mitr',
                                        color: Colors.white,
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
                        Padding(
                          // หัวข้อ (วันที่, เวลา, สี)
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
                                Align(
                                  // หัวข้อ (วันที่)
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
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Padding(
                                        // ช่องใส่วันที่
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
                                                  color: Color(0xFF1D1D1D),
                                                  textStyle: FlutterFlowTheme
                                                      .subtitle2
                                                      .override(
                                                    fontFamily: 'Mitr',
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1,
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
                                        Align(
                                          // หัวข้อ (เวลา)
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    60, 0, 0, 0),
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
                                                    color: Colors.white,
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
                                                    Container(
                                                      // ช่องใส่เวลาเริ่มต้น
                                                      width: 160,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: FFButtonWidget(
                                                        onPressed: () {
                                                          pickTime_form(
                                                              context);
                                                        },
                                                        text:
                                                            getTexttime_form(),
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              double.infinity,
                                                          height: 60,
                                                          color:
                                                              Color(0xFF1D1D1D),
                                                          textStyle:
                                                              FlutterFlowTheme
                                                                  .subtitle2
                                                                  .override(
                                                            fontFamily: 'Mitr',
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.black,
                                                            width: 1,
                                                          ),
                                                          borderRadius: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 0, 10, 0),
                                                      child: Text(
                                                        'ถึง',
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Mitr',
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      // ช่องใส่เวลาจบ
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 5, 0, 0),
                                                      child: Container(
                                                        width: 160,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: FFButtonWidget(
                                                          onPressed: () {
                                                            pickTime_to(
                                                                context);
                                                          },
                                                          text:
                                                              getTexttime_to(),
                                                          options:
                                                              FFButtonOptions(
                                                            width:
                                                                double.infinity,
                                                            height: 60,
                                                            color: Color(
                                                                0xFF1D1D1D),
                                                            textStyle:
                                                                FlutterFlowTheme
                                                                    .subtitle2
                                                                    .override(
                                                              fontFamily:
                                                                  'Mitr',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1,
                                                            ),
                                                            borderRadius: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          // หัวข้อ (สี)
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  60, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'สี',
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Mitr',
                                                  color: Colors.white,
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
                                                      });
                                                    },
                                                    text: '',
                                                    options: FFButtonOptions(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      color: Color(0xFF1D1D1D),
                                                      textStyle:
                                                          FlutterFlowTheme
                                                              .subtitle2
                                                              .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFF1D1D1D),
                                                      ),
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 1,
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
                        Padding(
                          // หัวข้อประเภทรถ
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
                                  'ประเภท',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Mitr',
                                    color: Colors.white,
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
                                      Tooltip(
                                        triggerMode: TooltipTriggerMode.manual,
                                        message: ' รถเก๋ง ',
                                        padding: const EdgeInsets.all(5.0),
                                        preferBelow: false,
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Mitr',
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        child: GestureDetector(
                                          // ประเภทรถ(บรรทุก)
                                          onTap: () {
                                            data_Search[6] = 'รถเก๋ง';
                                            color:
                                            Colors.grey;
                                          },
                                          child: Container(
                                            // ประเภทรถ(ทั่วไป)
                                            decoration: BoxDecoration(
                                              color: Color(0xFF1D1D1D),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Image.asset(
                                              'assets/images/Sedan.png',
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.contain,
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
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        child: GestureDetector(
                                          // ประเภทรถ(กระบะ)
                                          onTap: () {
                                            data_Search[6] = 'รถกระบะ';
                                            setState(() {
                                              click_color = false;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFF1D1D1D),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Image.asset(
                                              'assets/images/Pickup.png',
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.contain,
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
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        child: GestureDetector(
                                          // ประเภทรถ(ตู้)
                                          onTap: () {
                                            data_Search[6] = 'รถตู้';
                                            setState(() {
                                              click_color = false;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFF1D1D1D),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Image.asset(
                                              'assets/images/Van.png',
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.contain,
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
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        child: GestureDetector(
                                          // ประเภทรถ(บรรทุก)
                                          onTap: () {
                                            data_Search[6] = 'รถบรรทุก';
                                            setState(() {
                                              click_color = false;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFF1D1D1D),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Image.asset(
                                              'assets/images/Truck.png',
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.contain,
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
                        Padding(
                          // ส่งค่าไปหน้าต่อไป
                          padding:
                              EdgeInsetsDirectional.fromSTEB(450, 20, 450, 20),
                          child: FFButtonWidget(
                            onPressed: () {
                              print(data_Search);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultScreenWidget(
                                          license_plate: license_plate,
                                          city: city,
                                        )),
                              );
                            },
                            text: 'ค้นหา',
                            options: FFButtonOptions(
                              width: 300,
                              height: 50,
                              color: Color(0xFF1D1D1D),
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Mitr',
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w300,
                              ),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
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
            click_color // สีทั้งหมด
                ? Align(
                    alignment: AlignmentDirectional(-0.04, 0.08),
                    child: Container(
                      width: 300,
                      height: 270,
                      decoration: BoxDecoration(
                        color: Color(0xFF1D1D1D),
                        borderRadius: BorderRadius.circular(50),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.black,
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
                                    color: Colors.white,
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
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      data_Search[5] = 'สีแดง';
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
                                        color: Colors.white,
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.white,
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
                                      color: Colors.white,
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
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        data_Search[5] = 'สีน้ำเงิน';
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
                                          color: Colors.white,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
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
                                      color: Colors.white,
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
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        data_Search[5] = 'สีเหลือง';
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
                                          color: Colors.white,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
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
                                      color: Colors.white,
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
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        data_Search[5] = 'สีขาว';
                                        setState(() {
                                          click_color = false;
                                        });
                                        print('สีขาว');
                                      },
                                      text: '',
                                      options: FFButtonOptions(
                                        width: 60,
                                        height: 60,
                                        color: Color(0xFFECE7D1),
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Mitr',
                                          color: Colors.white,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
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
                                      color: Colors.white,
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
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        data_Search[5] = 'สีดำ';
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
                                          color: Colors.white,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
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
                                        color: Colors.white,
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
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          data_Search[5] = 'สีม่วง';
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
                                            color: Colors.white,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
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
                                        color: Colors.white,
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
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          data_Search[5] = 'สีเขียว';
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
                                            color: Colors.white,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
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
                                        color: Colors.white,
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
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          data_Search[5] = 'สีส้ม';
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
                                            color: Colors.white,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
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
                                      color: Colors.white,
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
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        data_Search[5] = 'สีแดงเลือดหมู';
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
                                          color: Colors.white,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
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
                                        color: Colors.white,
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
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          data_Search[5] = 'สีชมพู';
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
                                            color: Colors.white,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
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
                                        color: Colors.white,
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
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          data_Search[5] = 'สีเทา';
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
                                            color: Colors.white,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
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
                                        color: Colors.white,
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
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          data_Search[5] = 'สีฟ้า';
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
                                            color: Colors.white,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
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
                                    data_Search[5] = 'ไม่กำหนดสี';
                                    setState(() {
                                      click_color = false;
                                    });
                                  },
                                  text: 'ไม่กำหนดสี',
                                  options: FFButtonOptions(
                                    width: 200,
                                    height: 50,
                                    color: Color(0xFF1D1D1D),
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white,
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
