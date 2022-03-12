import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:krishivikas/Screens/check_zipcode_screen.dart';
import 'package:krishivikas/Screens/home_screen.dart';
import 'package:krishivikas/Screens/select_Screen.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class AuthMethods {
  Future signInWithGoogle(BuildContext context,int zip) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      var result = await googleSignIn.signIn();
     
      if (result != null) {

        SharedPreferencesFunctions().saveUserZipcode(zip);
        SharedPreferencesFunctions().saveUserEmail(result.email);

        gotoWithoutBack(context, CheckZipcodeScreen(2));
        showSnackbar(context, "Welcome to Krisi Vikas Udyog");
      } else {
        showSnackbar(context, "Something Went Wrong");

        //   SharedPreferencesFunctions().saveUserEmail(result.email);

        //   Map<String, dynamic> userData = {
        //     "mobile": "",
        //     "email": result.email,
        //     "facebook_id": "",
        //     "google_id": result.id,
        //     "device_id": "",
        //     "firebase_token": "",
        //     "phone_verified": 0,
        //     "country_id": 1,
        //     "state_id": stateId ?? 36,
        //     "district_id": 85151,
        //     "city_id": cityId ?? 1,
        //     "lat": lat,
        //     "long": long,
        //     "zipcode": zip
        //   };
        //   var res = await ApiMethods()
        //       .postDataForLogin(userData, "https://kv.ratemyevent.in/api/login");
        //   print(res);

        //   if (res["response"]) {
        //     SharedPreferencesFunctions().saveUserId(res["data"]["user_id"]);
        //     SharedPreferencesFunctions().saveToken(res["data"]["token"]);
        //     SharedPreferencesFunctions()
        //         .saveIsRegistered(res["data"]["profile_update"]);

        //     gotoWithoutBack(context, HomeScreen());

        //     showSnackbar(context, "Welcome to Krisi Vikas");
        //   } else {
        //     showSnackbar(context, "Something Went Wrong");
        //   }
        //   goBack(context);
        //   goto(context, HomeScreen());
        //   showSnackbar(context, "Welcome to Krisi Vikas");
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future logoutFromPhone() async {
    await FirebaseAuth.instance.signOut();
  }

  Future logOutFromGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  Future getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser;
  }
  Future<Response> sendNotification(
      List<String> tokenIdList, String contents, String heading) async {
    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "app_id":
            '27ad62f2-638f-439f-b342-bf5c46b16268', //kAppId is the App Id that one get from the OneSignal When the application is registered.

        "include_player_ids":
            tokenIdList, //tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color": "FF9976D2",

        "small_icon": "ic_stat_onesignal_default",

        "large_icon":
            "https://www.filepicker.io/api/file/zPloHSmnQsix82nlj9Aj?filename=name.jpg",

        "headings": {"en": heading},

        "contents": {"en": contents},
      }),
    );
  }
}
