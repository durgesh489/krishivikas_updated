import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/Details_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class UsedTractorList extends StatefulWidget {
  final String category;
  final int categoryId;
  final String type;
  UsedTractorList(
      {Key? key,
      required this.category,
      required this.categoryId,
      required this.type})
      : super(key: key);

  @override
  State<UsedTractorList> createState() => _UsedTractorListState();
}

class _UsedTractorListState extends State<UsedTractorList> {
  String url = "";
  String otherDistrictUrl = "";
  List tractorsList = [];

  List usedTractorsList = [];
  List otherDistrictTractorsList = [];

  List usedOtherDistrictTractorsList = [];
  doThisONLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    getUrlByCategory();

    tractorsList = await ApiMethods().getTractorsByPostApi(
       url,
        SharedPreferencesFunctions.userId!,
        SharedPreferencesFunctions.token!,
        0,
        20);
    otherDistrictTractorsList = await ApiMethods().getTractorsByPostApi(
        otherDistrictUrl,
        SharedPreferencesFunctions.userId!,
        SharedPreferencesFunctions.token!,
        0,
        20);
    // print(otherDistrictTractorsList);
    print("tractorList" + tractorsList.length.toString());

    // print(otherDistrictTractorsList);
    print("otherDistrictTractorList" +
        otherDistrictTractorsList.length.toString());

    for (var item in tractorsList) {
      if (item["type"] == "old") {
        usedTractorsList.add(item);
      }
    }
    print("usedTractorList" + usedTractorsList.length.toString());

    for (var item in otherDistrictTractorsList) {
      if (item["type"] == "old") {
        usedOtherDistrictTractorsList.add(item);
      }
    }
    print("usedOtherDistrictractorList" +
        usedOtherDistrictTractorsList.length.toString());

    print("totalusedtractorlist" + usedTractorsList.length.toString());

    setState(() {});
    print(SharedPreferencesFunctions.userId);
    print(SharedPreferencesFunctions.token);
  }

  getUrlByCategory() {
    if (widget.categoryId == 1) {
      url = "https://kv.ratemyevent.in/api/tractor";
      otherDistrictUrl = "https://kv.ratemyevent.in/api/tractor-other-district";
    } else if (widget.categoryId == 2) {
      url = "https://kv.ratemyevent.in/api/rent-tractor";
      otherDistrictUrl =
          "https://kv.ratemyevent.in/api/rent-tractor-other-district";
    } else if (widget.categoryId == 3) {
      url = "https://kv.ratemyevent.in/api/gv";
      otherDistrictUrl = "https://kv.ratemyevent.in/api/gv-other-district";
    } else if (widget.categoryId == 4) {
      url = "https://kv.ratemyevent.in/api/implements";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisONLaunch();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
          future: Future.value(usedTractorsList),
          builder: (context, snapshot) {
            print("snapshot: ${snapshot.data}");
            print(snapshot.hasData);
            return usedTractorsList.length==0?Center(child: Text("Sorry! No Ad available"),):  snapshot.data!.length == 0
                ? Center(
                    child: Center(
                    child: CircularProgressIndicator()
                  ))
                : Padding(
                    padding: const EdgeInsets.only(left: 11.0),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: usedTractorsList.length,
                        itemBuilder: (context, index) {
                          var ds = snapshot.data![index];
                          print(ds);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(ds),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 2)
                                    ]),
                                height: height * 0.3,
                                width: width * 0.5,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                        child: CachedNetworkImage(
                                          imageUrl: ds["front_image"],
                                          fit: BoxFit.cover,
                                          width: width,
                                          height: 0.13 * height,
                                          placeholder: (context, url) {
                                            return Center(
                                              child: Text("Loading"),
                                            );
                                          },
                                          errorWidget: (context, url, dynamic) {
                                            return Center(
                                                child: Text("No Image"));
                                          },
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 9),
                                      child: Text(
                                        ds["brand_name"] +" "+ds["model_name"],
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.grey,
                                            size: 18,
                                          ),
                                          Text(
                                            ds["state_name"] ?? "",
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "Rs.${ds["price"] ?? ""}",
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
          }),
      // FutureBuilder<List>(
      //     future: ApiMethods().getTractorsByPostApi(
      //         url,
      //         SharedPreferencesFunctions.userId!,
      //         SharedPreferencesFunctions.token!,
      //         0,
      //         10),
      //     builder: (context, snapshot) {
      //       print("snapshot: ${snapshot.data}");
      //       print(snapshot.hasData);
      //       return snapshot.hasData
      //           ? snapshot.data!.length == 0
      //               ? Center(
      //                   child: Text(" Sorry! No Ad Available"),
      //                 )
      //               : Padding(
      //                   padding: const EdgeInsets.only(left: 11.0),
      //                   child:
      //                 )
      //           : Center(child: CircularProgressIndicator());
      //     }),
    );
  }
}
