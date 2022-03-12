import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krishivikas/Screens/select_package_screen.dart';
import 'package:krishivikas/Screens/tractor_images_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/tractor/data.dart';

class EnterTractordetails extends StatefulWidget {
  EnterTractordetails({Key? key}) : super(key: key);

  @override
  State<EnterTractordetails> createState() => _EnterTractordetailsState();
}

class _EnterTractordetailsState extends State<EnterTractordetails> {
  bool rcAvailabel = false;
  bool financierNoc = false;
  bool isNegotiable = false;
  TextEditingController regNo = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController tractorDetails = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // var citiesList = [];
  // var statesList = [];

  var addressInfo;

  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getUserZipcode();
    addressInfo = await ApiMethods().getDataByPostApi(
        {"pincode": SharedPreferencesFunctions.zipcode},
        "https://kv.ratemyevent.in/api/pincode-check");
    zipController.text = SharedPreferencesFunctions.zipcode.toString();
    stateController.text = addressInfo[0]["state_name"];
    cityController.text = addressInfo[0]["city_name"];

    // statesList =
    //     await ApiMethods().getData("https://kv.ratemyevent.in/api/state");
    // for (var item in statesList) {
    //   if (item["state_name"].toString().toLowerCase() ==
    //       state.toString().toLowerCase()) {
    //     TractorData.stateId = item["id"];
    //   }
    // }
    // citiesList = await ApiMethods().getCitiesByPostApi(
    //     "https://kv.ratemyevent.in/api/city", TractorData.stateId ?? 36);
    // for (var item in citiesList) {
    //   if (item["city_name"].toString().toLowerCase() ==
    //       city.toString().toLowerCase()) {
    //     TractorData.cityId = item["id"];
    //     print(TractorData.cityId);
    //   }
    // }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    doThisOnLaunch();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: width * 0.48,
              color: kPrimaryColor,
              alignment: Alignment.center,
              child: const Text(
                "Previous",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () async {
              if (formKey.currentState!.validate()) {
                TractorData.rcAvailable = rcAvailabel ? 1 : 0;
                TractorData.nocAvailable = financierNoc ? 1 : 0;
                TractorData.registrationNo = regNo.text;
                TractorData.price = price.text;
                TractorData.description = tractorDetails.text;
                TractorData.IsNegotiable = isNegotiable ? 1 : 0;
                addressInfo = await ApiMethods().getDataByPostApi(
                    {"pincode": SharedPreferencesFunctions.zipcode},
                    "https://kv.ratemyevent.in/api/pincode-check");
                TractorData.countryId = addressInfo[0]["country_id"];

                TractorData.stateId = addressInfo[0]["state_id"];
                TractorData.cityId = addressInfo[0]["city_id"];
                TractorData.districtId = addressInfo[0]["district_id"];
                TractorData.lat = addressInfo[0]["latitude"];
                TractorData.long = addressInfo[0]["longitude"];
                TractorData.zipcode = int.parse(zipController.text);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TractorImagesScreen()));
              } else {
                showSnackbar(context, "Please fill all fields");
              }
            },
            child: Container(
              height: 50,
              width: width * 0.48,
              color: kPrimaryColor,
              alignment: Alignment.center,
              child: const Text(
                "Next",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Krishi Vikas"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              width: double.infinity,
              color: Colors.green.shade300,
              child: const Text(
                "Enter Details",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 14, right: 14, top: 10, bottom: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "RC Available",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Switch(
                        activeColor: kPrimaryColor,
                        inactiveTrackColor: kPrimaryColor,
                        value: rcAvailabel,
                        onChanged: (value) {
                          setState(() {
                            rcAvailabel = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 2),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Financier NOC",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Switch(
                        activeColor: kPrimaryColor,
                        inactiveTrackColor: kPrimaryColor,
                        value: financierNoc,
                        onChanged: (value) {
                          setState(() {
                            financierNoc = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            VSpace(10),
            // const Padding(
            //   padding: EdgeInsets.only(left: 18, top: 40),
            //   child: Text(
            //     "Enter Registration No.",
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
              child: SizedBox(
                child: TextFormField(
                  controller: regNo,
                  decoration: InputDecoration(
                    label: Text("Registration Number"),
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: "Enter Registration Number",
                    enabledBorder: outlineBorder(),
                    focusedBorder: outlineBorder(),
                  ),
                ),
              ),
            ),

            VSpace(10),
            CustomTextfield(price, "Enter Price *", "Price *",
                "Please Fill Price!", TextInputType.number),
            Padding(
              padding: const EdgeInsets.only(
                  left: 14, right: 14, top: 10, bottom: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Is Negotiable",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Switch(
                        activeColor: kPrimaryColor,
                        inactiveTrackColor: kPrimaryColor,
                        value: isNegotiable,
                        onChanged: (value) {
                          setState(() {
                            isNegotiable = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
            // CustomTextfield(addressController, "Enter Address", "Address",
            //     "Please fill Address!", TextInputType.text),
            // VSpace(10),
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
            // const Padding(
            //   padding: EdgeInsets.only(left: 15, top: 20),
            //   child: Text(
            //     "Select State *",
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       border: Border.all(color: Colors.grey.shade400, width: 2),
            //     ),
            //     // height: 45,
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 10.0),
            //       child: DropdownButtonHideUnderline(
            //         child: DropdownSearch<dynamic>(
            //           // label: state,
            //           selectedItem: state,
            //           showSearchBox: true,
            //           dialogMaxWidth: double.infinity,
            //           maxHeight: fullHeight(context) - 150,
            //           dropdownSearchDecoration: InputDecoration(
            //               contentPadding: EdgeInsets.zero,
            //               border: InputBorder.none),
            //           items: statesList
            //               .map((items) => items["state_name"])
            //               .toList(),
            //           onChanged: (val) async {
            //             TractorData.stateName = val;
            //             for (var item in statesList) {
            //               if (item["state_name"] == val) {
            //                 TractorData.stateId = item["id"];
            //                 print(TractorData.stateId);
            //               }
            //             }
            //             citiesList = await ApiMethods().getCitiesByPostApi(
            //                 "https://kv.ratemyevent.in/api/city",
            //                 TractorData.stateId!);
            //             print(citiesList);
            //             setState(() {});
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // // const Padding(
            // //   padding: EdgeInsets.only(left: 15, top: 20),
            // //   child: Text(
            // //     "Select City *",
            // //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // //   ),
            // // ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 15, top: 20),
            //   child: Text(
            //     "Select City *",
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       border: Border.all(color: Colors.grey.shade400, width: 2),
            //     ),
            //     // height: 45,
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 10.0),
            //       child: DropdownButtonHideUnderline(
            //         child: DropdownSearch<dynamic>(
            //           selectedItem: city,
            //           showSearchBox: true,
            //           dialogMaxWidth: double.infinity,
            //           maxHeight: fullHeight(context) - 150,
            //           dropdownSearchDecoration: InputDecoration(
            //               contentPadding: EdgeInsets.zero,
            //               border: InputBorder.none),
            //           items: citiesList
            //               .map((items) => items["city_name"])
            //               .toList(),
            //           onChanged: (val) {
            //             TractorData.cityName = val;
            //             for (var item in citiesList) {
            //               if (item["city_name"] == val) {
            //                 TractorData.cityId = item["id"];
            //                 print(TractorData.cityId);
            //               }
            //             }
            //           },
            //         ),

            //         // DropdownButton<String>(
            //         //   hint: Text("Select City"),
            //         //   value: cityDropdownValue,
            //         //   items: citiesList.map((items) {
            //         //     return DropdownMenuItem(
            //         //       child: Text(items["city_name"]),
            //         //       value: items["id"].toString(),
            //         //     );
            //         //   }).toList(),
            //         //   onChanged: (value) {
            //         //     setState(() {
            //         //       cityDropdownValue = value;
            //         //     });
            //         //   },
            //         // ),
            //       ),
            //     ),
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.only(left: 18, top: 20),
              child: Text(
                "Tractor Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 8, right: 18),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                controller: tractorDetails,
                maxLines: 10,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                    hintText: "About Your Tractor",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    enabledBorder: outlineBorder(),
                    focusedBorder: outlineBorder(),
                    errorBorder: outlineBorder(),
                    focusedErrorBorder: outlineBorder()),
              ),
            ),

            VSpace(20)
          ],
        ),
      ),
    );
  }
}
