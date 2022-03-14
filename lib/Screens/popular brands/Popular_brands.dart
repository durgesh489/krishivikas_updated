import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/popular%20brands/new_brands_list.dart';
import 'package:krishivikas/Screens/popular%20brands/view_all_brands_sceen.dart';
import 'package:krishivikas/widgets/all_widgets.dart';



class PopularBrands extends StatelessWidget {
  const PopularBrands({Key? key}) : super(key: key);

  get tabController => null;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 200,
      child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular Brands",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            goto(context, ViewAllBrandsList());
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                                color: Colors.blueGrey.shade300, fontSize: 13),
                          ))
                    ],
                  ),
                ),
                NewBrandsList()

                // DefaultTabController(

                //    length: 2,
                //    child: Column(
                //      children: [
                //        Row(
                //          children: [

                //            SizedBox(
                //              width: width * 0.62,
                //              child: const TabBar(
                //                labelPadding: EdgeInsets.zero,
                //                labelColor: Colors.blueGrey,
                //                indicatorColor: Colors.blueGrey,
                //                isScrollable: false,
                //                indicatorSize: TabBarIndicatorSize.label,

                //                tabs: [
                //                Tab(text: "New Tractor",),
                //                Tab(text: "Used Tractor",),

                //              ]),
                //            ),

                //          ],
                //        ),

                //        SizedBox(
                //          height: height * 0.40,
                //          child: TabBarView(
                //           controller: tabController,
                //            children:  [
                //            NewBrandsList(),
                //            UsedBrandsList()
                //          ]),
                //        ),

                //      ],
                //    )
                //  ),
              ],
            ),
          )),
    );
  }
}
