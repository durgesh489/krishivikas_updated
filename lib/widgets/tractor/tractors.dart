import 'package:flutter/material.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/tractor/new_tractor_list.dart';
import 'package:krishivikas/widgets/tractor/tractor_list.dart';
import 'package:krishivikas/widgets/tractor/used_tractor_list.dart';

class Tractors extends StatelessWidget {
  Tractors({Key? key}) : super(key: key);
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
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                "Tractors",
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
                          child: const TabBar(
                              labelPadding: EdgeInsets.zero,
                              labelColor: Colors.blueGrey,
                              indicatorColor: Colors.blueGrey,
                              isScrollable: false,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorPadding: EdgeInsets.zero,
                              padding: EdgeInsets.only(left: 10),
                              tabs: [
                                Tab(
                                  text: "New Tractor",
                                ),
                                Tab(
                                  text: "Used Tractor",
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
                                    TractorList(
                                        category: "Tractor", categoryId: 1));
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
                        NewTractorList(
                          category: "Tractor",
                          categoryId: 1,
                          type: "new",
                        ),
                       NewTractorList(category: "Tractor", categoryId: 1, type: "old")
                       
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
