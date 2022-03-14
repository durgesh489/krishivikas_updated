import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krishivikas/Screens/account/check_zipcode_screen.dart';
import 'package:krishivikas/Screens/home_screen.dart';

import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/auth_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pinput/pin_put/pin_put.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool codeSent = false;
  bool showLoginCPI = false;

  String otpMsg = "";
  String phoneNumber = "";
  String verificationCode = "";
  TextEditingController phoneNumberController = new TextEditingController();
  String? deviceTokenId;
  FocusNode focusNode = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController pinPutController = new TextEditingController();
  FocusNode pinPutFocusNode = new FocusNode();
  bool showOtpCPI = false;

  signInWithFacebook() async {
    await FacebookAuth.instance.login(permissions: ["public_profile", "email"]);
    // .then((value) {
    // FacebookAuth.instance.getUserData().then((result) {
    //   Map<String, dynamic> user = result;
    //   print(user["picture"]["data"]["url"]);
    //   print(user["name"]);
    //   print(user["email"]);
    // });
    // });
  }

  int zip = 000000;

  doThisOnLaunch() async {
    Position position = await ApiMethods().getGeoLocationPosition();
    double lat = position.latitude;
    double long = position.longitude;
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    zip = int.parse(placemarks[0].postalCode ?? "000000");
    print(zip);
  }

  getTokenId() async {
    var status = await OneSignal.shared.getDeviceState();
    deviceTokenId = status!.userId;
    print(deviceTokenId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    doThisOnLaunch();
    getTokenId();
  }

  Future<void> verifyPhoneNumber() async {
    focusNode.unfocus();
    setState(() {
      showLoginCPI = true;
    });

    await auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        UserCredential result =
            await auth.signInWithCredential(phoneAuthCredential);
        otpMsg = phoneAuthCredential.smsCode!;
        print(otpMsg + "Auto");
        User? user = result.user;

        if (result != null) {
          gotoWithoutBack(context, CheckZipcodeScreen(1));
          showSnackbar(context, "Welcome to Krisi Vikas");
        } else {
          setState(() {
            showLoginCPI = false;
          });
          showSnackbar(context, "Something Went Wrong");
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        showSnackbar(context, e.message.toString());
        print(e.toString());

        setState(() {
          showLoginCPI = false;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationCode = verificationId;
        print(verificationCode);
        print(resendToken.toString() + "Code Sent");
        // codeSent = true;
        showLoginCPI = false;

        setState(() {});
      },
      codeAutoRetrievalTimeout: (String? verificationId) {
        verificationCode = verificationId!;
      },
      timeout: Duration(seconds: 60),
    );
  }

  Future<void> verifyPin(String pin) async {
    setState(() {
      showOtpCPI = true;
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationCode, smsCode: pin);

    try {
      print(verificationCode);

      UserCredential result = await auth.signInWithCredential(credential);
      User? user = result.user;
      if (result != null) {
        print(verificationCode + "Verify Pin");

        gotoWithoutBack(context, CheckZipcodeScreen(1));
        showSnackbar(context, "Welcome to Krisi Vikas");
      } else {
        setState(() {
          showLoginCPI = false;
        });
        showSnackbar(context, "Something Went Wrong");
      }
      //     Map<String, dynamic> userData = {
      //       "mobile": phoneNumber,
      //       "email": "",
      //       "facebook_id": "",
      //       "google_id": "",
      //       "device_id": "",
      //       "firebase_token": "",
      //       "phone_verified": 1,
      //       "country_id": 1,
      //       "state_id": stateId ?? 36,
      //       "district_id": 85151,
      //       "city_id": cityId ?? 1,
      //       "lat": lat,
      //       "long": long,
      //       "zipcode": zip
      //     };

      //     var res = await ApiMethods()
      //         .postDataForLogin(userData, "https://kv.ratemyevent.in/api/login");

      //     print(res);
      //     if (res["response"]) {
      //       SharedPreferencesFunctions().saveUserPhoneNumber(phoneNumber);
      //       SharedPreferencesFunctions().saveUserId(res["data"]["user_id"]);
      //       SharedPreferencesFunctions().saveToken(res["data"]["token"]);
      //       SharedPreferencesFunctions()
      //           .saveIsRegistered(res["data"]["profile_update"]);
      //       gotoWithoutBack(context, HomeScreen());
      //       showSnackbar(context, "Welcome to Krisi Vikas");
      //     } else {
      //       setState(() {
      //         showLoginCPI = false;
      //       });
      //       showSnackbar(context, "Something Went Wrong");
      //     }

    } on FirebaseException catch (e) {
      setState(() {
        showOtpCPI = false;
      });
      showSnackbar(context, e.message.toString());
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: codeSent ? OtpWidget() : LoginWidget(),
      ),
    ));
  }

  Widget LoginWidget() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 21, top: 100, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sign Up or Login",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  // IconButton(
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     },
                  //     icon: const Icon(
                  //       Icons.close,
                  //       color: Colors.grey,
                  //       size: 26,
                  //     ))
                ],
              ),
            ),
            VSpace(10),
            const Padding(
              padding: EdgeInsets.only(left: 21),
              child: Text(
                "We will send you a confirmation code",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 21, right: 15, top: 35),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.network(
                  //   "https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1350px-Flag_of_India.svg.png",
                  //   height: 40,
                  //   width: 40,
                  // ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12, right: 4),
                    child: Text(
                      "+91",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: phoneNumberController,
                      focusNode: focusNode,
                      onChanged: (value) {
                        phoneNumber = value;
                        if (value.length == 10) {
                          focusNode.unfocus();
                        }
                        setState(() {});
                      },
                      validator: MultiValidator(
                        [
                          MinLengthValidator(10,
                              errorText: "Phone Number should be 10 digits"),
                          RequiredValidator(
                              errorText: "this is required field"),
                        ],
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      //textAlign: TextAlign.center,

                      decoration: InputDecoration(
                          counterText: "",
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          hintText: "999-999-9999",
                          hintStyle: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            showLoginCPI
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (mounted) {
                              setState(() {
                                codeSent = true;
                                decT();
                              });
                            }

                            getTokenId();
                            SharedPreferencesFunctions()
                                .saveUserPhoneNumber(phoneNumber);
                            SharedPreferencesFunctions().saveUserZipcode(zip);
                            SharedPreferencesFunctions()
                                .saveDeviceToken(deviceTokenId.toString());

                            verifyPhoneNumber();
                          }
                        },
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              Size(fullWidth(context) * 0.90, 45),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(kPrimaryColor)),
                        label: const Text(
                          "CONTINUE",
                          style: TextStyle(fontSize: 16),
                        ),
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Text(
                  "By tapping continue, you agree to the Terms of Use and Privacy Policy",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            const Center(
              child: Text(
                "Or connect using",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    signInWithFacebook();
                  },
                  child: Container(
                    height: 40,
                    width: fullWidth(context) * 0.31,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue.shade700,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.facebook_outlined,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Facebook",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    AuthMethods().signInWithGoogle(context, zip);
                  },
                  child: Container(
                    height: 40,
                    width: fullWidth(context) * 0.31,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.g_mobiledata,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Google",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  int t = 60;
  decT() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (t > 0) {
          t -= 1;
        } else {
          timer.cancel();
        }
      });
    });
  }

  Widget OtpWidget() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          boldText("Enter  OTP ", 28),
          SizedBox(height: 25),
          PinPut(
            fieldsCount: 6,
            focusNode: pinPutFocusNode,
            controller: pinPutController,
            submittedFieldDecoration: boxDecoration(2, 5),
            selectedFieldDecoration: boxDecoration(2, 5),
            followingFieldDecoration: boxDecoration(1, 5),
            textStyle: TextStyle(fontSize: 20),
            pinAnimationType: PinAnimationType.scale,
            eachFieldHeight: 43,
          ),
          VSpace(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              normalText(t.toString() + " sec", 17),
              InkWell(
                  onTap: () {
                    if (t == 0) {
                      setState(() {
                        t = 60;
                        decT();
                      });

                      verifyPhoneNumber();
                    }
                  },
                  child:
                      appText("Resend OTP", 17, Colors.blue, FontWeight.bold))
            ],
          ),
          SizedBox(height: 50),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  fixedSize:
                      MaterialStateProperty.all(Size(fullWidth(context), 45))),
              onPressed: () {
                verifyPin(pinPutController.text);
              },
              child: showOtpCPI
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      "Verify OTP",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
        ],
      ),
    );
  }
}
