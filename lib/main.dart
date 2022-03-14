import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/home_screen.dart';
import 'package:krishivikas/Screens/account/login_screen.dart';
import 'package:krishivikas/Screens/account/profile_screen.dart';
import 'package:krishivikas/Screens/other_screens/splash_screen1.dart';
import 'package:krishivikas/Screens/other_screens/splash_screen2.dart';
import 'package:krishivikas/services/auth_methods.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   void configOneSignel() {
    OneSignal.shared.setAppId('27ad62f2-638f-439f-b342-bf5c46b16268');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configOneSignel();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: AuthMethods().getCurrentUser(),
        builder: (context,AsyncSnapshot snapshot) {
        return snapshot.hasData? SplashScreen2():SplashScreen1();
      }),
    );
  }
}
