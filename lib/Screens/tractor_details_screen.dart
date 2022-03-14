import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:krishivikas/Screens/enter_details_screen.dart';
import 'package:krishivikas/Screens/home_screen.dart';
import 'package:krishivikas/Screens/chat/individual_chat_screen.dart';
import 'package:krishivikas/Screens/account/profile_screen.dart';
import 'package:krishivikas/Screens/select_user_type_screen.dart';
import 'package:krishivikas/Screens/account/user_profile_screen.dart';


import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/auth_methods.dart';
import 'package:krishivikas/services/firebase_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class TractorDetailsScreen extends StatefulWidget {
  final ds;

  TractorDetailsScreen(this.ds);

  @override
  State<TractorDetailsScreen> createState() => _TractorDetailsScreenState();
}

class _TractorDetailsScreenState extends State<TractorDetailsScreen> {
  String chatRoomId = "";
  bool showCPI = false;
  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getIsRegistered();
    await SharedPreferencesFunctions().getUserPhoneNumber();
    print(SharedPreferencesFunctions.phoneNumber);
    print(widget.ds["mobile"]);
    chatRoomId = getChatRoomIdByPhoneNumbers(
        SharedPreferencesFunctions.phoneNumber.toString(), widget.ds["mobile"]);
    print(chatRoomId);
  }

  getChatRoomIdByPhoneNumbers(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisOnLaunch();
    // print(widget.ds["photo"]);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () {
        gotoWithoutBack(context, HomeScreen());
        return Future.value(true);
      },
      child: Scaffold(
        bottomNavigationBar: SharedPreferencesFunctions.phoneNumber !=
                widget.ds["mobile"]
            ? Container(
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                            height: 55,
                            color: kPrimaryColor,
                            onPressed: () {
                              setState(() {
                                showCPI = true;
                              });
                              Map<String, dynamic> chatRoomInfoMap = {
                                "usersPhoneNumbers": [
                                  SharedPreferencesFunctions.phoneNumber
                                      .toString(),
                                  widget.ds["mobile"]
                                ],
                                "usersDeviceTokenIds": [
                                  SharedPreferencesFunctions.deviceToken
                                      .toString(),
                                  widget.ds["device_id"],
                                ],
                                "ts": DateTime.now()
                              };
                              FirebaseMethods()
                                  .createChatRoom(chatRoomId, chatRoomInfoMap)
                                  .then((value) {
                                setState(() {
                                  showCPI = false;
                                });

                                goto(
                                    context,
                                    IndividualChatScreen(widget.ds["mobile"],
                                        widget.ds["device_id"]));
                              });
                            },
                            child: showCPI
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Row(
                                    children: [
                                      Image.asset(
                                        "assets/chat.png",
                                        width: 20,
                                        height: 20,
                                        color: Colors.white,
                                      ),
                                      HSpace(8),
                                      Text(
                                        "Send a Message",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )),
                      ),
                      Expanded(
                        child: MaterialButton(
                            height: 55,
                            color: Colors.green,
                            onPressed: () async {
                              String url = 'tel:${widget.ds["mobile"]}';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/phone.png",
                                  width: 20,
                                  height: 20,
                                  color: Colors.white,
                                ),
                                HSpace(8),
                                Text(
                                  "Contact Now",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              )
            : null,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              goBack(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: kPrimaryColor,
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.share_outlined)),
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 270,
                  child: Row(
                    children: [
                      CachedNetworkImg(
                          widget.ds["left_image"],
                          fullWidth(context),
                          270,
                          "assets/images/left.jpg",
                          context),
                      CachedNetworkImg(
                          widget.ds["right_image"],
                          fullWidth(context),
                          270,
                          "assets/images/right.jpg",
                          context),
                      CachedNetworkImg(
                          widget.ds["front_image"],
                          fullWidth(context),
                          270,
                          "assets/images/front.jpg",
                          context),
                      CachedNetworkImg(
                          widget.ds["back_image"],
                          fullWidth(context),
                          270,
                          "assets/images/back.jpg",
                          context),
                      CachedNetworkImg(
                          widget.ds["meter_image"],
                          fullWidth(context),
                          270,
                          "assets/images/meter.jpg",
                          context),
                      CachedNetworkImg(
                          widget.ds["tyre_image"],
                          fullWidth(context),
                          270,
                          "assets/images/tyre.jpg",
                          context),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 250,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 18, bottom: 5),
                        child: Row(
                          children: [
                            Text(
                              widget.ds["brand_name"] ?? "",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(" "),
                            Text(
                              widget.ds["model_name"] ?? "",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 13, bottom: 12, right: 25),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(widget.ds["city_name"] ?? ""),
                                  Text(","),
                                  Text(widget.ds["state_name"] ?? ""),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/calendar.png",
                                    width: 13,
                                    height: 13,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(widget.ds["created_at"]
                                      .toString()
                                      .substring(0, 10))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13, right: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/rupee.png",
                              width: 15,
                              height: 15,
                            ),
                            HSpace(5),
                            Text(
                              "₹" + "${widget.ds["price"] ?? ""}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            HSpace(3),
                            widget.ds["is_negotiable"] == "1"
                                ? Text("(Price Negotiable)")
                                : SizedBox()
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.grey.shade100,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(widget.ds["description"] ?? ""),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.grey.shade100,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Additional Details",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: buildAdditionalDetail(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.grey.shade100,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Contact",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          goto(context, UserProfileScreen(widget.ds));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.ds["photo"],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return CircleAvatar(
                                          child: Icon(
                                            Icons.person,
                                            size: 30,
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, dynamic) {
                                        return CircleAvatar(
                                          child: Icon(
                                            Icons.person,
                                            size: 40,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.ds["name"] ?? "Unknown",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(top: 3, bottom: 3),
                                        child: Text(
                                          "Member Since Sep 2020",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                      Text(
                                        "SEE PROFILE",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    goto(context, UserProfileScreen(widget.ds));
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAdditionalDetail() {
    return Column(
      children: [
        VSpace(10),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "RC Available",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.ds["rc_available"] == 1 ? "Yes" : "No",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "NOC Available",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.ds["noc_available"] == 1 ? "Yes" : "No",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        ListView.builder(
            padding: EdgeInsets.zero,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.ds["specification"].length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.ds["specification"][index]["spec_name"],
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.ds["specification"][index]["spec_value"],
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })),
      ],
    );
    // Column(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.only(top: 2),
    //       child: Container(
    //         color: Colors.grey.shade100,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: const [
    //             Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Text(
    //                 "HP Category",
    //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Text(
    //                 "41-45 HP",
    //                 style: TextStyle(
    //                   fontSize: 14,
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 4),
    //       child: Container(
    //         color: Colors.grey.shade100,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: const [
    //             Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Text(
    //                 "Gear Box",
    //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Text(
    //                 "8 Forward + 2 Reverse",
    //                 style: TextStyle(
    //                   fontSize: 14,
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 4),
    //       child: Container(
    //         color: Colors.grey.shade100,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: const [
    //             Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Text(
    //                 "Lifting Capacity",
    //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Text(
    //                 "1600-1700 Kg",
    //                 style: TextStyle(
    //                   fontSize: 14,
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 4),
    //       child: Container(
    //         color: Colors.grey.shade100,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: const [
    //             Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Text(
    //                 "Clutch",
    //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Text(
    //                 "Single / Dual Optional",
    //                 style: TextStyle(
    //                   fontSize: 14,
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 4),
    //       child: Container(
    //         color: Colors.grey.shade100,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: const [
    //             Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Text(
    //                 "Warranty",
    //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Text(
    //                 "2000 Hours / 2 Year",
    //                 style: TextStyle(
    //                   fontSize: 14,
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }
}
