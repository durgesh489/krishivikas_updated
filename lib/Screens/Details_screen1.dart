import 'package:flutter/material.dart';

import 'package:krishivikas/Screens/home_screen.dart';

import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';

import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/tractor/data.dart';

class DetailsScreen1 extends StatefulWidget {
  final int tractorId;

  DetailsScreen1(this.tractorId);

  @override
  State<DetailsScreen1> createState() => _DetailsScreenState1();
}

class _DetailsScreenState1 extends State<DetailsScreen1> {
  String url = "";

  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    print(SharedPreferencesFunctions.userId);
    print(SharedPreferencesFunctions.token);

    setState(() {});
  }

  getApiUrlByCategoryId() {
    print(TractorData.categoryId);
    print("ppppppppppppp");
    if (TractorData.categoryId == 1) {
      url = "https://kv.ratemyevent.in/api/tractor-by-id";
    } else if (TractorData.categoryId == 2) {
      url = "https://kv.ratemyevent.in/api/rent-tractor-by-id";
    } else if (TractorData.categoryId == 3) {
      url = "https://kv.ratemyevent.in/api/gv-by-id";
    } else if (TractorData.categoryId == 4) {
      url = "https://kv.ratemyevent.in/api/implements-add";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisOnLaunch();
    getApiUrlByCategoryId();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // print(tractorInfo);

    return WillPopScope(
      onWillPop: () {
        gotoWithoutBack(context, HomeScreen());
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: Colors.grey,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                goto(context, HomeScreen());
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
          body: FutureBuilder<List>(
              future: ApiMethods().getSingleTractorInfoById(
                  url,
                  SharedPreferencesFunctions.userId!,
                  SharedPreferencesFunctions.token!,
                  widget.tractorId),
              builder: (context, snapshot) {
                print(widget.tractorId);
                print(url);
                print(snapshot.data);
                return snapshot.hasData
                    ? Stack(
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
                                        snapshot.data![0]["left_image"],
                                        fullWidth(context),
                                        270,
                                        "assets/images/left.jpg",
                                        context),
                                    CachedNetworkImg(
                                        snapshot.data![0]["right_image"],
                                        fullWidth(context),
                                        270,
                                        "assets/images/right.jpg",
                                        context),
                                    CachedNetworkImg(
                                        snapshot.data![0]["front_image"],
                                        fullWidth(context),
                                        270,
                                        "assets/images/front.jpg",
                                        context),
                                    CachedNetworkImg(
                                        snapshot.data![0]["back_image"],
                                        fullWidth(context),
                                        270,
                                        "assets/images/back.jpg",
                                        context),
                                    CachedNetworkImg(
                                        snapshot.data![0]["meter_image"],
                                        fullWidth(context),
                                        270,
                                        "assets/images/meter.jpg",
                                        context),
                                    CachedNetworkImg(
                                        snapshot.data![0]["tyre_image"],
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
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 18, bottom: 5),
                                      child: Row(
                                        children: [
                                          Text(
                                            snapshot.data![0]["brand_name"] ??
                                                "",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(" "),
                                          Text(
                                            snapshot.data![0]["model_name"] ??
                                                "",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 13, bottom: 12),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                              "${snapshot.data![0]["state_name"] ?? ""}"),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                          const Icon(
                                            Icons.access_time_outlined,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(snapshot.data![0]["created_at"]
                                              .toString()
                                              .substring(0, 10))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Rs.${snapshot.data![0]["price"] ?? ""}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryColor),
                                      ),
                                    ),
                                    VSpace(10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Status : ",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Pending",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
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
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Text(snapshot.data![0]
                                              ["description"] ??
                                          ""),
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
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 25, right: 25),
                                      child: buildAdditionalDetail(),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              })),
    );
  }

  Widget buildAdditionalDetail() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Container(
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "HP Category",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "41-45 HP",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Gear Box",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "8 Forward + 2 Reverse",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Lifting Capacity",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "1600-1700 Kg",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Clutch",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Single / Dual Optional",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Warranty",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "2000 Hours / 2 Year",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
