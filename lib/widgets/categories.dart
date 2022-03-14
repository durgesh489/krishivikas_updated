

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:krishivikas/Screens/tractor/all_ads_vertical_list.dart';
import 'package:krishivikas/Screens/tractor_details_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class Categories extends StatefulWidget {
  Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: ApiMethods().getData("https://kv.ratemyevent.in/api/category"),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:15.0,top: 10),
                    child: boldText("Select Category",17),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // shrinkWrap: true,
                      physics: ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              onTap: () {
                                goto(
                                    context,
                                    AllAdsVerticalList(
                                      category: snapshot.data![index]["category"],
                                      categoryId: snapshot.data![index]["id"],
                                    ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                   
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                         color: kPrimaryColor,
                                        // boxShadow: [
                                        // BoxShadow(color: Colors.grey, blurRadius: 3)
                                      // ],
                                       shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot.data![index]["icon"],
                                       
                                          fit: BoxFit.cover,
                                         
                                          placeholder: (context, url) {
                                            return Center(
                                              child: Text("Loading"),
                                            );
                                          },
                                          errorWidget: (context, url, dynamic) {
                                            return Center(child: Icon(Icons.image));
                                          },
                                        ),
                                      )),
                                  VSpace(5),
                                  Text(
                                    snapshot.data![index]["category"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 13),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ),
                ],
              )
              : Center(child: CircularProgressIndicator());
        });
  }
}
