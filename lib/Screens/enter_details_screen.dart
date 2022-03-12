import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krishivikas/Screens/home_screen.dart';
import 'package:krishivikas/Screens/profile_screen.dart';
import 'package:krishivikas/Screens/select_category_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:http/http.dart' as http;

class EnterDetails extends StatefulWidget {
  final int userTypeId;
  EnterDetails(this.userTypeId);

  @override
  State<EnterDetails> createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();

  DateTime pickedDate = DateTime.now();
  bool showCPI = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  

  var addressInfo;

  getUserInfo() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    await SharedPreferencesFunctions().getUserEmail();
    await SharedPreferencesFunctions().getUserPhoneNumber();
    await SharedPreferencesFunctions().getUserZipcode();
    print(SharedPreferencesFunctions.zipcode);

    phoneNumberController.text = SharedPreferencesFunctions.phoneNumber ?? "";
    emailController.text = SharedPreferencesFunctions.email ?? "";
    zipController.text = SharedPreferencesFunctions.zipcode.toString();
    addressInfo = await ApiMethods().getDataByPostApi(
        {"pincode": SharedPreferencesFunctions.zipcode},
        "https://kv.ratemyevent.in/api/pincode-check");
    if (addressInfo != "") {
      stateController.text = addressInfo[0]["state_name"];
      cityController.text = addressInfo[0]["city_name"];
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () async {
          if (formKey.currentState!.validate()) {
            setState(() {
              showCPI = true;
            });

            print(SharedPreferencesFunctions.userId);
            addressInfo = await ApiMethods().getDataByPostApi(
                {"pincode": SharedPreferencesFunctions.zipcode},
                "https://kv.ratemyevent.in/api/pincode-check");
            stateController.text = addressInfo[0]["state_name"];
            cityController.text = addressInfo[0]["city_name"];
         
            Map<String, dynamic> individualUserData = {
              "user_id": SharedPreferencesFunctions.userId,
              "user_type_id": widget.userTypeId,
              "name": nameController.text,
              "email": emailController.text,
              "address": addressController.text,
              "country_id": addressInfo[0]["country_id"],
              "state_id": addressInfo[0]["state_id"],
              "district_id": addressInfo[0]["district_id"],
              "city_id": addressInfo[0]["city_id"],
              "zipcode": zipController.text,
              "dob": "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}",
              "latlong": "${addressInfo[0]["latitude"]},${addressInfo[0]["longitude"]}",
              "photo": ""
            };
            Map<String, dynamic> dealerUserData = {
              "user_id": SharedPreferencesFunctions.userId,
              "user_type_id": widget.userTypeId,
              "name": nameController.text,
              "email": emailController.text,
              "address": addressController.text,
              "country_id": addressInfo[0]["country_id"],
              "state_id": addressInfo[0]["state_id"],
              "district_id": addressInfo[0]["district_id"],
              "city_id":addressInfo[0]["city_id"],
              "zipcode": zipController.text,
              "dob": "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}",
              "company_name": companyNameController.text,
              "gst_no": gstNumberController.text,
              "latlong": "${addressInfo[0]["latitude"]},${addressInfo[0]["longitude"]}",
              "photo": ""
            };
            bool result = await ApiMethods().postData(
                widget.userTypeId == 2 ? dealerUserData : individualUserData,
                "https://kv.ratemyevent.in/api/regdata");
            if (result) {
              gotoWithoutBack(context, SelectCategoryScreen());
              showSnackbar(context, "Welcome to Krisi Vikas Udyog");
            }
          } else {
            showSnackbar(context, "Please fill All fields");
          }
        },
        child: Container(
          color: kPrimaryColor,
          height: 50,
          width: double.infinity,
          alignment: Alignment.center,
          child: showCPI
              ? CircularProgressIndicator()
              : Text(
                  "Complete Registration",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Krishi Vikas"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 70,
              width: double.infinity,
              color: Colors.green.shade300,
              child: const Text(
                "Enter your details",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            // const SizedBox(height: 10),
            // const Padding(
            //   padding: EdgeInsets.only(left: 15, top: 10),
            //   child: Text(
            //     "Enter Name *",
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            // ),
            VSpace(10),
            CustomTextfield(nameController, "Enter Name", "Name",
                "Please fill name!", TextInputType.text),
            // const Padding(
            //   padding: EdgeInsets.only(left: 15, top: 20),
            //   child: Text(
            //     "Enter Number *",
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            // ),
            VSpace(10),
            phoneNumberController.text != ""
                ? Padding(
                    padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
                    child: TextFormField(
                      enabled: false,
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        label: Text("Phone Number"),
                        contentPadding: EdgeInsets.only(left: 15),
                        border: outlineBorder(),
                      ),
                    ),
                  )
                : CustomTextfield(
                    phoneNumberController,
                    "Enter Phone Number",
                    "Phone Number",
                    "Please Fill Phone Number!",
                    TextInputType.phone),
            // const Padding(
            //   padding: EdgeInsets.only(left: 15, top: 20),
            //   child: Text(
            //     "Enter Email *",
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            // ),
            VSpace(10),
            emailController.text != ""
                ? Padding(
                    padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
                    child: TextFormField(
                      enabled: false,
                      controller: emailController,
                      decoration: InputDecoration(
                        label: Text("Email"),
                        contentPadding: EdgeInsets.only(left: 15),
                        border: outlineBorder(),
                      ),
                    ),
                  )
                : CustomTextfield(emailController, "Enter Email", "Email",
                    "Please Fill Email", TextInputType.emailAddress),
            widget.userTypeId == 2 ? VSpace(10) : SizedBox(),
            widget.userTypeId == 2
                ? CustomTextfield(
                    companyNameController,
                    "Enter Company Name",
                    "Company Name",
                    "Please Fill Company Name",
                    TextInputType.emailAddress)
                : SizedBox(),
            widget.userTypeId == 2 ? VSpace(10) : SizedBox(),
            widget.userTypeId == 2
                ? CustomTextfield(
                    gstNumberController,
                    "Enter GST Number",
                    "GST Number",
                    "Please Fill GST Number",
                    TextInputType.emailAddress)
                : SizedBox(),
            VSpace(10),

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
            VSpace(10),
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

            // CustomTextfield(cityController, "Select City"),
            // const Padding(
            //   padding: EdgeInsets.only(left: 15, top: 20),
            //   child: Text(
            //     "Enter Address *",
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            // ),
            VSpace(10),
            CustomTextfield(addressController, "Enter Address", "Address",
                "Please fill Address!", TextInputType.text),
            VSpace(10),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: zipController,
                validator: MultiValidator([
                  RequiredValidator(errorText: "Enter Zipcode"),
                  MinLengthValidator(6,
                      errorText: "Pincode should be 6 digits"),
                  MaxLengthValidator(6, errorText: "Pincode should be 6 digits")
                ]),
                maxLength: 6,
                onChanged: (value) async {
                  if (value.length == 6) {
                    addressInfo = await ApiMethods().getDataByPostApi(
                        {"pincode": zipController.text},
                        "https://kv.ratemyevent.in/api/pincode-check");
                    if (addressInfo != "") {
                      stateController.text = addressInfo[0]["state_name"];
                      cityController.text = addressInfo[0]["city_name"];
                      // districtController.text =
                      //     addressInfo[0]["district_name"];
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

            const Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                "Select Date of Birth *",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}",
                      style: TextStyle(fontSize: 17),
                    ),
                    IconButton(
                      onPressed: () {
                        showDate();
                      },
                      icon: Icon(Icons.date_range),
                    ),
                  ],
                ),
              ),
            ),
            VSpace(20)
          ],
        ),
      ),
    );
  }

  Future showDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
    if (date != null) {
      pickedDate = date;
      print(pickedDate);
      setState(() {});
    }
  }
}
