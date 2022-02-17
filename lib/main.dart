import 'package:clarity_v/Search_Screen.dart';
import 'package:clarity_v/flutter%20flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Clarity V'),
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
    return Scaffold(
      body: 
            AnimatedSplashScreen(
              splash: Image.asset(
                'assets/images/Opening_Screen/Logo.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              duration: 2000,
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: Color(0xFF1D1D1D),
              nextScreen: SearcScreenWidget(),
            ),
          
        
  
    );
  }
}
