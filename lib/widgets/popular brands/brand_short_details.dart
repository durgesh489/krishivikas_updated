import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/Details_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class BrandShortDetails extends StatefulWidget {
  final int masterBrandId;
  BrandShortDetails(this.masterBrandId);

  @override
  State<BrandShortDetails> createState() => _BrandShortDetailsState();
}

class _BrandShortDetailsState extends State<BrandShortDetails> {
  int districtId = 0000;

  doThisONLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    await SharedPreferencesFunctions().getUserZipcode();

    var addressInfo = await ApiMethods().getDataByPostApi(
        {"pincode": SharedPreferencesFunctions.zipcode},
        "https://kv.ratemyevent.in/api/pincode-check");
    if (addressInfo != "") {
      districtId = addressInfo[0]["district_id"];
    }
    print(widget.masterBrandId);
    print(districtId);

    setState(() {});
    print(SharedPreferencesFunctions.userId);
    print(SharedPreferencesFunctions.token);
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
        title: Text("All brand tractors"),
      ),
      body: FutureBuilder<List>(
          future: ApiMethods().getDataByPostApi(
              {"master_brand_id": widget.masterBrandId, "district": districtId},
              "https://kv.ratemyevent.in/api/master-brand-data"),
          builder: (context, snapshot) {
            return snapshot.hasData
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
                                DetailsScreen(ds),
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ds["brand_name"] ?? "",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
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
                                                          const EdgeInsets.only(
                                                              left: 4),
                                                      child: Text(
                                                          ds["state_name"] ??
                                                              ""),
                                                    )
                                                  ],
                                                ),
                                                HSpace(8),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .access_time_outlined,
                                                      size: 16,
                                                      color: Colors.grey,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
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
