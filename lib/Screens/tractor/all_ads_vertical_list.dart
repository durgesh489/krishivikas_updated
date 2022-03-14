import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/tractor_details_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class AllAdsVerticalList extends StatefulWidget {
  final String category;
  final int categoryId;
  AllAdsVerticalList({Key? key, required this.category, required this.categoryId})
      : super(key: key);

  @override
  State<AllAdsVerticalList> createState() => _AllAdsVerticalListState();
}

class _AllAdsVerticalListState extends State<AllAdsVerticalList> {
  String url = "";
  String otherDistrictUrl = "";
  List tractorsList = [];

  List otherDistrictTractorsList = [];

  doThisONLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    getUrlByCategory();
    print(url);
    print(otherDistrictUrl);
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

    for (var item in otherDistrictTractorsList) {
      tractorsList.add(item);
    }

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
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(widget.category),
      ),
      body: FutureBuilder<List>(
          future: Future.value(tractorsList),
          builder: (context, snapshot) {
            return tractorsList.length == 0
                ? Center(
                    child: Text("Sorry! No Ad available"),
                  )
                : snapshot.hasData
                    ? snapshot.data!.length == 0
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var ds = snapshot.data![index];
                              return InkWell(
                                onTap: () {
                                  goto(
                                    context,
                                    TractorDetailsScreen(ds),
                                  );
                                },
                                child: Card(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: CachedNetworkImage(
                                                imageUrl: ds["front_image"],
                                                fit: BoxFit.cover,
                                                width: 125,
                                                height: 90,
                                                placeholder: (context, url) {
                                                  return Center(
                                                    child: Text("Loading"),
                                                  );
                                                },
                                                errorWidget:
                                                    (context, url, dynamic) {
                                                  return Center(
                                                      child: Text("No Image"));
                                                },
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 190,
                                                  child: Text(
                                                    ds["brand_name"] +
                                                        " " +
                                                        ds["model_name"],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/rupee.png",
                                                      width: 15,
                                                      height: 15,
                                                    ),
                                                    HSpace(5),
                                                    Text(
                                                      "Rs. ${ds["price"] ?? ""}",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: kPrimaryColor),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                
                                                
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.location_on,
                                                          size: 16,
                                                          color: Colors.grey,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4),
                                                          child: Text(
                                                              ds["city_name"] ??
                                                                  ""),
                                                        )
                                                      ],
                                                    ),
                                                    HSpace(13),
                                                    Row(
                                                      children: [
                                                         Image.asset(
                                                          "assets/calendar.png",
                                                          width: 15,
                                                          height: 15,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4),
                                                          child: Text(
                                                              ds["created_at"]
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10)),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                VSpace(5),
                                                Text(ds["type"]=="new"?"New ${widget.category}":"Used ${widget.category}")
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              );
                            },
                          )
                    : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
