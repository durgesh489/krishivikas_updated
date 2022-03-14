import 'dart:async';

import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/home_screen.dart';
import 'package:krishivikas/Screens/other_screens/language_screen.dart';
import 'package:krishivikas/Screens/account/login_screen.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      gotoWithoutBack(context, HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset(
        "assets/splash.jpg",
        fit: BoxFit.cover,
      ),
    ));
  }
}
