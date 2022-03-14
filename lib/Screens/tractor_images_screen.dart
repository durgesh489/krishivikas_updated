import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishivikas/Screens/tractor/data.dart';

import 'package:krishivikas/Screens/tractor_details_screen1.dart';

import 'package:krishivikas/const/colors.dart';

import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class TractorImagesScreen extends StatefulWidget {
  const TractorImagesScreen({Key? key}) : super(key: key);

  @override
  State<TractorImagesScreen> createState() => _TractorImagesScreenState();
}

class _TractorImagesScreenState extends State<TractorImagesScreen> {
  bool showCPI = false;
  String url = "";

  doThisONLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    print(SharedPreferencesFunctions.userId);
  }

  getApiUrlByCategoryId() {
    print(TractorData.categoryId);
    print("ppppppppppppp");
    if (TractorData.categoryId == 1) {
      url = "https://kv.ratemyevent.in/api/tractor-add";
    } else if (TractorData.categoryId == 2) {
      url = "https://kv.ratemyevent.in/api/rent-tractor-add";
    } else if (TractorData.categoryId == 3) {
      url = "https://kv.ratemyevent.in/api/gv-add";
    } else if (TractorData.categoryId == 4) {
      url = "https://kv.ratemyevent.in/api/implements-add";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisONLaunch();
    getApiUrlByCategoryId();
    print(url);
    print(images);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: width * 0.49,
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
          InkWell(
            onTap: () async {
              setState(() {
                showCPI = true;
              });
           
              int count = 0;
              for (var item in images) {
                if (item != "") {
                  count++;
                }
              }
              print(count);

              if (count >= 2) {
                var left_image,
                    right_image,
                    front_image,
                    back_image,
                    meter_image,
                    tyre_image;
                if (images[0] != "") {
                  left_image = await MultipartFile.fromFile(images[0],
                      filename: images[0].split("/").last);
                }
                if (images[1] != "") {
                  right_image = await MultipartFile.fromFile(images[1],
                      filename: images[1].split("/").last);
                }
                if (images[2] != "") {
                  front_image = await MultipartFile.fromFile(images[2],
                      filename: images[2].split("/").last);
                }
                if (images[3] != "") {
                  back_image = await MultipartFile.fromFile(images[3],
                      filename: images[3].split("/").last);
                }
                if (images[4] != "") {
                  meter_image = await MultipartFile.fromFile(images[4],
                      filename: images[4].split("/").last);
                }
                if (images[5] != "") {
                  tyre_image = await MultipartFile.fromFile(images[5],
                      filename: images[5].split("/").last);
                }
                print(SharedPreferencesFunctions.userId);
                print(SharedPreferencesFunctions.token);
                print(TractorData.type);
                print(TractorData.categoryId);
                print(TractorData.brandId);
                print(TractorData.modelId);
                print(TractorData.yearOfPurchase);
                print(TractorData.rcAvailable);
                print(TractorData.nocAvailable);
                print(TractorData.registrationNo);
                print(TractorData.description);
                print(left_image);
                print(right_image);
                print(front_image);
                print(back_image);
                print(meter_image);
                print(tyre_image);
                print(TractorData.price);
                print(TractorData.IsNegotiable);
                print(TractorData.countryId);
                print(TractorData.stateId);
                print(TractorData.cityId);
                print(TractorData.districtId);
                print("${TractorData.lat},${TractorData.long}");
                print(TractorData.zipcode);

                FormData formData = FormData.fromMap({
                  "user_id": SharedPreferencesFunctions.userId,
                  "user_token": SharedPreferencesFunctions.token,
                  "type": TractorData.type ?? 1,
                  "category_id": TractorData.categoryId ?? 1,
                  "brand_id": TractorData.brandId ?? 1,
                  "model_id": TractorData.modelId ?? 1,
                  "year_of_purchase": TractorData.yearOfPurchase,
                  "rc_available": TractorData.rcAvailable,
                  "noc_available": TractorData.nocAvailable,
                  "registration_no": TractorData.registrationNo,
                  "description": TractorData.description,
                  "left_image": left_image,
                  "right_image": right_image,
                  "front_image": front_image,
                  "back_image": back_image,
                  "meter_image": meter_image,
                  "tyre_image": tyre_image,
                  "price": TractorData.price ?? 0,
                  "is_negotiable": TractorData.IsNegotiable,
                  "country_id": TractorData.countryId ?? 1,
                  "state_id": TractorData.stateId ?? 36,
                  "city_id": TractorData.cityId ?? 1,
                  "district_id": TractorData.districtId ?? 1234,
                  "latlong": "${TractorData.lat},${TractorData.long}",
                  "pincode": TractorData.zipcode
                });
                var response = await Dio().post(url, data: formData);
                print(response.data["response"]);
                print(response);
                print(response.data["last_id"]);

                if (response.data["response"]) {
                  gotoWithoutBack(
                    context,
                    TractorDetailsScreen1(response.data["last_id"]),
                  );
                  showSnackbar(context, "Ad added Successfully");
                  setState(() {
                    showCPI = false;
                  });
                }
              } else {
                showSnackbar(context, "Please Upload at least two images");
                setState(() {
                  showCPI = false;
                });
              }

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const SelectPackageScreen()));
            },
            child: Container(
              height: 50,
              width: width * 0.49,
              color: kPrimaryColor,
              alignment: Alignment.center,
              child: showCPI
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Krishi Vikas"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              width: double.infinity,
              color: Colors.green.shade300,
              child: const Text(
                "Click & Upload Photo",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey.shade200,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Please upload minimum two images.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: assetImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        takeImage(i);
                        setState(() {});
                        print(images[i]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  blurRadius: 4)
                            ]),
                        height: width * 0.35,
                        width: width * 0.45,
                        child: images[i] == ""
                            ? Column(
                                children: [
                                  Image.asset(
                                    assetImages[i],
                                    fit: BoxFit.cover,
                                    height: width * 0.28,
                                    width: width * 0.30,
                                  ),
                                  Text(
                                    imagesType[i],
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            : Image.file(
                                File(images[i]),
                                fit: BoxFit.cover,
                              ),
                      ),
                    );
                  }),
            ),
            VSpace(10)
          ],
        ),
      ),
    );
  }

  final ImagePicker picker = new ImagePicker();

  List<String> images = List.filled(6, "");
  List<String> assetImages = [
    "assets/images/left.jpg",
    "assets/images/right.jpg",
    "assets/images/front.jpg",
    "assets/images/back.jpg",
    "assets/images/meter.jpg",
    "assets/images/tyre.jpg",
  ];
  List<String> imagesType = [
    "Left Side Image",
    "Right Side Image",
    "Front Side Image",
    "Back Side Image",
    "Meter Image",
    "Tyre Image",
  ];

  bool isImageSelected = false;

  Future getImageFromGallery(int i) async {
    Navigator.of(context).pop();
    var status = await Permission.camera.status;
    print(status.isDenied);
    if (status.isDenied) {
      await Permission.camera.request();
    }
    if (status.isGranted) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          images[i] = pickedFile.path;
          isImageSelected = true;
          print(images[i]);
        } else {
          print("no image selected");
        }
      });
    }
  }

  Future captureImageFromCamera(int i) async {
    Navigator.of(context).pop();
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request();
    }
    if (status.isGranted) {
      final pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 60);
      setState(() {
        if (pickedFile != null) {
          images[i] = pickedFile.path;
          isImageSelected = true;
          print(images[i]);
        } else {
          print("no image selected");
        }
      });
    }
  }

  takeImage(int i) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Select any option",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
                child: Text(
                  "Select Image from Gallery",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                onPressed: () async {
                  getImageFromGallery(i);
                }),
            SimpleDialogOption(
                child: Text(
                  "Capture Image from Camera",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                onPressed: () async {
                  captureImageFromCamera(i);
                }),
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              onPressed: () {
                goBack(context);
              },
            ),
          ],
        );
      },
    );
  }
}
