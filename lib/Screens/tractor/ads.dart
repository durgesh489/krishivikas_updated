import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/tractor/ads_horizontal_list.dart';
import 'package:krishivikas/Screens/tractor/all_ads_vertical_list.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class Ads extends StatefulWidget {
  final String categoryType;
  final int categoryId;
  Ads({Key? key, required this.categoryType, required this.categoryId})
      : super(key: key);

  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  get tabController => null;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.42,
      width: width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                widget.categoryType,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),
            ),
            DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.55,
                          child:TabBar(
                              labelPadding: EdgeInsets.zero,
                              labelColor: Colors.blueGrey,
                              indicatorColor: Colors.blueGrey,
                              isScrollable: false,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorPadding: EdgeInsets.zero,
                              padding: EdgeInsets.only(left: 10),
                              tabs: [
                                Tab(
                                  text: "New ${widget.categoryType}",
                                ),
                                Tab(
                                  text: "Used ${widget.categoryType}",
                                )
                              ]),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: TextButton(
                              onPressed: () {
                                goto(
                                    context,
                                    AllAdsVerticalList(
                                        category: widget.categoryType, categoryId: widget.categoryId));
                              },
                              child: Text(
                                "View All",
                                style: TextStyle(
                                    color: Colors.blueGrey.shade300,
                                    fontSize: 13),
                              )),
                        )
                      ],
                    ),
                    VSpace(10),
                    SizedBox(
                      height: height * 0.28,
                      child: TabBarView(controller: tabController, children: [
                        AdsHorizontalList(
                          category: widget.categoryType,
                          categoryId: widget.categoryId,
                          type: "new",
                        ),
                        AdsHorizontalList(
                            category: widget.categoryType, categoryId: widget.categoryId, type: "old")
                      ]),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
