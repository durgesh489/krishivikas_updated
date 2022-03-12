import 'dart:io';

import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/all_chats_list_screen.dart';

import 'package:krishivikas/Screens/condition_select_screen.dart';
import 'package:krishivikas/Screens/enter_details_screen.dart';
import 'package:krishivikas/Screens/enter_tractor_details_screen.dart';
import 'package:krishivikas/Screens/favorite_screen.dart';
import 'package:krishivikas/Screens/profile_screen.dart';
import 'package:krishivikas/Screens/select_Screen.dart';
import 'package:krishivikas/Screens/select_category_screen.dart';
import 'package:krishivikas/Screens/subscription_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/goods_and_vehicles/implements.dart';
import 'package:krishivikas/widgets/popular%20brands/Popular_brands.dart';
import 'package:krishivikas/widgets/categories.dart';
import 'package:krishivikas/widgets/rent-tractor/rent_tractors.dart';
import 'package:krishivikas/widgets/slider.dart';
import 'package:krishivikas/widgets/tractor/data.dart';
import 'package:krishivikas/widgets/tractor/tractors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  var body = [
    HomeScreen(),
    FavoriteScreen(),
    AllChatsListScreen(),
    ProfileScreen()
  ];
  var title = ["Krishi Vikas", "Favourite Ads", "Chats", "Profile"];
  var isReg;

  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    print(isReg);
    setState(() {});
    print(SharedPreferencesFunctions.userId);
    print(SharedPreferencesFunctions.token);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisOnLaunch();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomAppBar(
            elevation: 5,
            color: Colors.white,
            shape: const CircularNotchedRectangle(),
            child: SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                        icon: const Icon(Icons.home_outlined)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                        icon: const Icon(Icons.favorite_outline)),
                    const SizedBox(
                      width: 40,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = 2;
                          });
                          //  print(currentIndex);
                        },
                        icon: const Icon(Icons.message_outlined)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = 3;
                          });
                        },
                        icon: const Icon(Icons.person_outline))
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: floatingButton(context),
          appBar: AppBar(
            title: Text(title[currentIndex]),
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              ),
            ],
          ),
          body: currentIndex == 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Sliders(),
                      Container(
                          color: Colors.grey.shade100,
                          height: height * 0.2,
                          child: Categories()),
                      Tractors(),
                      buildWhatYouDo(context),
                      VSpace(10),
                      const PopularBrands(),
                      const GoodsAndVehicles(),
                      const RentTractors(),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                )
              : body[currentIndex]),
      onWillPop: () {
        return showExitPopup(context);
      },
    );
  }

  Widget floatingButton(context) {
    return FloatingActionButton(
      backgroundColor: kPrimaryColor,
      onPressed: () async {
        var userInfo = await ApiMethods().getUserInfoByPostApi(
            "https://kv.ratemyevent.in/api/profile",
            SharedPreferencesFunctions.userId!,
            SharedPreferencesFunctions.token!);
        print(userInfo);
        isReg = userInfo["profile_update"];
        print("is reg:${isReg}");
        goto(
          context,
          isReg == 1 ? SelectCategoryScreen() : Select(),
        );
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }

  Widget buildWhatYouDo(context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 25),
        child: Column(
          children: [
            Text(
              "What would you like to do ?",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade400),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green.shade300)),
                    onPressed: () async {
                      TractorData.categoryId = 2;
                      Map<String, dynamic> userInfo = await ApiMethods()
                          .getUserInfoByPostApi(
                              "https://kv.ratemyevent.in/api/profile",
                              SharedPreferencesFunctions.userId!,
                              SharedPreferencesFunctions.token!);
                      isReg = userInfo["profile_update"];

                      print("is reg:${isReg}");
                      goto(context,
                          isReg == 1 ? ConditionSelectScreen(2) : Select());
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Rent a Tractor",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor)),
                    onPressed: () async {
                      TractorData.categoryId = 1;
                      Map<String, dynamic> userInfo = await ApiMethods()
                          .getUserInfoByPostApi(
                              "https://kv.ratemyevent.in/api/profile",
                              SharedPreferencesFunctions.userId!,
                              SharedPreferencesFunctions.token!);
                      isReg = userInfo["profile_update"];

                      print("is reg:${isReg}");
                      goto(context,
                          isReg == 1 ? ConditionSelectScreen(1) : Select());
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Sell a Tractor",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to exit?"),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: Text("Yes"),
                          style:
                              ElevatedButton.styleFrom(primary: kPrimaryColor),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child:
                            Text("No", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
