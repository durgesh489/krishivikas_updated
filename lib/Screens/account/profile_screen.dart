import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishivikas/Screens/home_screen.dart';
import 'package:krishivikas/Screens/account/login_screen.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/auth_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name;
  String? email;
  String? phoneNumber;
  doThisOnLaunch() async {
    // await SharedPreferencesFunctions().getUserInfo();
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
  }

  getUserInfo() async {
    Map<String, dynamic> userInfo = await ApiMethods().getUserInfoByPostApi(
        "https://kv.ratemyevent.in/api/profile",
        SharedPreferencesFunctions.userId!,
        SharedPreferencesFunctions.token!);
    print(userInfo["name"] ?? "");
    name = userInfo["name"] ?? "";
    email = userInfo["email"] ?? "";
    phoneNumber = userInfo["mobile"] ?? "";
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisOnLaunch();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Column(
              children: [
                const SizedBox(
                  height: 38,
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                        radius: 55,
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                  width: fullWidth(context),
                                  height: fullHeight(context),
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: 60,
                              )),
                    InkWell(
                      onTap: () {
                        takeImage();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.teal,
                        radius: 22,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  name ?? "",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.mobile_friendly,
                        color: Colors.orange,
                        size: 19,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          phoneNumber ?? "",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.email,
                        color: Colors.orange,
                        size: 19,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          email ?? "",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(12.0),
          //   child: Container(
          //       decoration: BoxDecoration(
          //           color: Colors.pink.shade50.withOpacity(0.6),
          //           borderRadius: BorderRadius.circular(10)),
          //       child: Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: ListTile(
          //           leading: Icon(
          //             Icons.email,
          //             color: Colors.orange,
          //           ),
          //           title: const Text(
          //             "Verify your email",
          //             style: TextStyle(
          //                 fontWeight: FontWeight.bold, color: Colors.blueGrey),
          //           ),
          //           subtitle: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.only(top: 3, bottom: 3),
          //                 child: Text(
          //                   "Be a part of our trusted community by verifying",
          //                   style: TextStyle(
          //                     color: Colors.orange.shade400.withOpacity(0.7),
          //                   ),
          //                 ),
          //               ),
          //               const Text(
          //                 "email@domain.com",
          //                 style: TextStyle(
          //                     color: Colors.black54,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ],
          //           ),
          //         ),
          //       )),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person_outline,
                    color: Colors.blue.shade200,
                    size: 25,
                  ),
                  label: const Text(
                    "Profile",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.category_outlined,
                    color: Colors.blue.shade200,
                    size: 25,
                  ),
                  label: const Text(
                    "Categories",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_outline,
                    color: Colors.blue.shade200,
                    size: 25,
                  ),
                  label: const Text(
                    "Favourites",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: Colors.blue.shade200,
                    size: 25,
                  ),
                  label: const Text(
                    "My Ads",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.message_outlined,
                    color: Colors.blue.shade200,
                    size: 25,
                  ),
                  label: const Text(
                    "Chats",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings,
                    color: Colors.blue.shade200,
                    size: 25,
                  ),
                  label: const Text(
                    "Settings",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.phone,
                    color: Colors.blue.shade200,
                    size: 25,
                  ),
                  label: const Text(
                    "Contact",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    AuthMethods().logoutFromPhone();
                    AuthMethods().logOutFromGoogle();
                    gotoWithoutBack(context, LoginScreen());
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.blue.shade200,
                    size: 25,
                  ),
                  label: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  File? image;
  bool isImageSelected = false;
  final ImagePicker picker = new ImagePicker();

  Future getImageFromGallery() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      var profilePicture = await MultipartFile.fromFile(image!.path,
          filename: image!.path.split("/").last);

      FormData formData = FormData.fromMap({
        "photo": profilePicture,
        "user_id": SharedPreferencesFunctions.userId,
        "user_token": SharedPreferencesFunctions.token,
      });
      var response = await Dio()
          .post("https://kv.ratemyevent.in/api/regdata", data: formData);
      // print(response.data["response"]);
      print(response);

      if (response.data["response"]) {
        showSnackbar(context, "Photo added Successfully");
      } else {
        showSnackbar(context, "No photo uploaded");
      }
    } else {
      print("no image selected");
    }
    setState(() {});
  }

  Future captureImageFromCamera() async {
    Navigator.of(context).pop();
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 60);
    if (pickedFile != null) {
      image = File(pickedFile.path);

      var profilePicture = await MultipartFile.fromFile(image!.path,
          filename: image!.path.split("/").last);

      FormData formData = FormData.fromMap({
        "photo": profilePicture,
        "user_id": SharedPreferencesFunctions.userId,
        "user_token": SharedPreferencesFunctions.token,
      });
      var response = await Dio()
          .post("https://kv.ratemyevent.in/api/regdata", data: formData);
      // print(response.data["response"]);
      print(response);

      if (response.data["response"]) {
        showSnackbar(context, "Photo added Successfully");
      } else {
        showSnackbar(context, "No photo uploaded");
      }
    } else {
      print("no image selected");
    }
    setState(() {});
  }

  takeImage() {
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
                  getImageFromGallery();
                }),
            SimpleDialogOption(
                child: Text(
                  "Capture Image from Camera",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                onPressed: () async {
                  captureImageFromCamera();
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
