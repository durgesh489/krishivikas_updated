import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:krishivikas/Screens/home_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';

class CheckZipcodeScreen extends StatefulWidget {
  final int loginMethod;
  CheckZipcodeScreen(this.loginMethod);

  @override
  State<CheckZipcodeScreen> createState() => _CheckZipcodeScreenState();
}

class _CheckZipcodeScreenState extends State<CheckZipcodeScreen> {
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  var addressInfo;
  bool isZipChanged = false;
  bool showCPI = false;
  String? deviceTokenId;
  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getUserPhoneNumber();
    await SharedPreferencesFunctions().getUserEmail();
    await SharedPreferencesFunctions().getUserZipcode();
    addressInfo = await ApiMethods().getDataByPostApi(
        {"pincode": SharedPreferencesFunctions.zipcode},
        "https://kv.ratemyevent.in/api/pincode-check");
    if (addressInfo != "") {
      zipcodeController.text = SharedPreferencesFunctions.zipcode.toString();
      stateController.text = addressInfo[0]["state_name"];
      cityController.text = addressInfo[0]["city_name"];
      districtController.text = addressInfo[0]["district_name"];
    }

    print(SharedPreferencesFunctions.phoneNumber);
    print(SharedPreferencesFunctions.zipcode);
    print(SharedPreferencesFunctions.deviceToken);

    setState(() {});
  }

  getTokenId() async {
    var status = await OneSignal.shared.getDeviceState();
    deviceTokenId = status!.userId;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisOnLaunch();
    getTokenId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Address"),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Form(
          key: addressFormKey,
          child: Column(
            children: [
              VSpace(50),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: zipcodeController,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Enter Zipcode"),
                    MinLengthValidator(6,
                        errorText: "Pincode should be 6 digits"),
                    MaxLengthValidator(6,
                        errorText: "Pincode should be 6 digits")
                  ]),
                  maxLength: 6,
                  onChanged: (value) async {
                    isZipChanged = true;
                    if (value.length == 6) {
                      addressInfo = await ApiMethods().getDataByPostApi(
                          {"pincode": zipcodeController.text},
                          "https://kv.ratemyevent.in/api/pincode-check");
                      if (addressInfo != "") {
                        stateController.text = addressInfo[0]["state_name"];
                        cityController.text = addressInfo[0]["city_name"];
                        districtController.text =
                            addressInfo[0]["district_name"];
                        setState(() {});
                      }
                    }
                  },
                  decoration: InputDecoration(
                    label: Text("Enter Zipcode"),
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: "Enter Zipcode",
                    enabledBorder: outlineBorder(),
                    focusedBorder: outlineBorder(),
                    errorBorder: outlineBorder(),
                    focusedErrorBorder: outlineBorder(),
                    counterText: "",
                  ),
                ),
              ),
              VSpace(20),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
                child: TextField(
                  controller: stateController,
                  enabled: false,
                  decoration: InputDecoration(
                    label: Text("State Name"),
                    contentPadding: EdgeInsets.only(left: 15),
                    border: outlineBorder(),
                  ),
                ),
              ),
              VSpace(20),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
                child: TextField(
                  controller: cityController,
                  enabled: false,
                  decoration: InputDecoration(
                    label: Text("City/Town/Area"),
                    contentPadding: EdgeInsets.only(left: 15),
                    border: outlineBorder(),
                  ),
                ),
              ),
              VSpace(20),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
                child: TextField(
                  controller: districtController,
                  enabled: false,
                  decoration: InputDecoration(
                    label: Text("District Name"),
                    contentPadding: EdgeInsets.only(left: 15),
                    border: outlineBorder(),
                  ),
                ),
              ),
              VSpace(50),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 45,
                    color: kPrimaryColor,
                    onPressed: () async {
                      if (addressFormKey.currentState!.validate()) {
                        if (mounted) {
                          setState(() {
                            showCPI = true;
                          });
                        }

                        if (isZipChanged) {
                          addressInfo = await ApiMethods().getDataByPostApi(
                              {"pincode": zipcodeController.text},
                              "https://kv.ratemyevent.in/api/pincode-check");
                        }

                        print(addressInfo);
                        print(SharedPreferencesFunctions.phoneNumber);
                        print(deviceTokenId);
                        if (addressInfo != "") {
                          Map<String, dynamic> userData = {
                            "mobile": SharedPreferencesFunctions.phoneNumber,
                            "email": "",
                            "facebook_id": "",
                            "google_id": "",
                            "device_id": deviceTokenId,
                            "firebase_token": "",
                            "phone_verified": 1,
                            "country_id": addressInfo[0]["country_id"] ?? 1,
                            "state_id": addressInfo[0]["state_id"] ?? 36,
                            "district_id":
                                addressInfo[0]["district_id"] ?? 1234,
                            "city_id": addressInfo[0]["city_id"] ?? 1,
                            "lat": addressInfo[0]["latitude"],
                            "long": addressInfo[0]["longitude"],
                            "zipcode": int.parse(zipcodeController.text)
                          };
                          Map<String, dynamic> res = await ApiMethods()
                              .postDataForLogin(userData,
                                  "https://kv.ratemyevent.in/api/login");
                          print(res);
                          print(res["response"]);
                          if (res["response"]) {
                            SharedPreferencesFunctions()
                                .saveUserId(res["data"]["user_id"]);
                            SharedPreferencesFunctions()
                                .saveToken(res["data"]["token"]);
                            SharedPreferencesFunctions().saveIsRegistered(
                                res["data"]["profile_update"]);

                            gotoWithoutBack(context, HomeScreen());
                            showSnackbar(
                                context, "Welcome to Krishi Vikas Udyog");
                          } else {
                            if (mounted) {
                              setState(() {
                                showCPI = false;
                              });
                            }

                            showSnackbar(context, "Something Went Wrong");
                          }
                        } else {
                          if (mounted) {
                            setState(() {
                              showCPI = false;
                            });
                          }

                          showSnackbar(context, "This is not a valid Zipcode");
                        }
                      }
                    },
                    child: showCPI
                        ? Center(child: CircularProgressIndicator())
                        : Text(
                            "Continue",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
