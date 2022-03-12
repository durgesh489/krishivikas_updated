import 'package:flutter/material.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/tractor/tractor_list.dart';

import '../tractor/new_tractor_list.dart';
import '../tractor/used_tractor_list.dart';
import 'used_implement_list.dart';

class GoodsAndVehicles extends StatelessWidget {
  const GoodsAndVehicles({Key? key}) : super(key: key);

  get tabController => null;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.4,
      width: width,
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15, left: 10),
            child: Text(
              "Goods and Vehicles",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: SizedBox(
                          width: width * 0.62,
                          child: const TabBar(
                              labelPadding: EdgeInsets.zero,
                              labelColor: Colors.blueGrey,
                              indicatorColor: Colors.blueGrey,
                              isScrollable: false,
                              indicatorSize: TabBarIndicatorSize.label,
                              tabs: [
                                Tab(
                                  text: "New Vehicles",
                                ),
                                Tab(
                                  text: "Used Vehicles",
                                )
                              ]),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: TextButton(
                            onPressed: () {
                              goto(
                                  context,
                                  TractorList(
                                      category: "Goods Vehicle",
                                      categoryId: 3));
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
                  SizedBox(
                    height: height * 0.27,
                    child: TabBarView(controller: tabController, children: [
                      NewTractorList(
                          category: "Goods Vehicle",
                          categoryId: 3,
                          type: "new"),

                      UsedTractorList(
                          category: "Goods Vehicle",
                          categoryId: 3,
                          type: "old")
                      //  NewImplementsList(),
                      //  UsedImplementsList(),
                    ]),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
