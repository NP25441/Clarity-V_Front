import 'package:clarity_v/Search_Screen.dart';
import 'package:clarity_v/flutter%20flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    var initialSize = Size(1300, 800);
    appWindow.size = initialSize;
    appWindow.minSize = initialSize;
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const MyHomePage(title: 'Clarity V'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Image.asset(
          'assets/images/Logo.png',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
        duration: 1000,
        backgroundColor: Color(0xFF1D1D1D),
        nextScreen: AnimatedSplashScreen(
        splash: Image.asset(
          'assets/images/Logo.png',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        duration: 1000,
        nextScreen: SearcScreenWidget(),
      ),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
    );
  }
}
