import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/Select_brand_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/tractor/data.dart';

class ConditionSelectScreen extends StatefulWidget {
  final categoryId;
  ConditionSelectScreen(this.categoryId);

  @override
  State<ConditionSelectScreen> createState() => _ConditionSelectScreenState();
}

class _ConditionSelectScreenState extends State<ConditionSelectScreen> {
  String category = "";
  String newCategoryImage = "";
  String usedCategoryImage = "";
  getCategory() {
    if (widget.categoryId == 1 || widget.categoryId == 2) {
      category = "Tractors";
      newCategoryImage = "assets/right.jpg";
      usedCategoryImage = "assets/left.jpg";
    } else if (widget.categoryId == 3) {
      category = "Vehicles";
      newCategoryImage = "assets/right_vehicle.png";
      usedCategoryImage = "assets/left_vehicle.png";
    } else {
      category = "Vehicles";
      newCategoryImage = "assets/right_vehicle.png";
      usedCategoryImage = "assets/left_vehicle.png";
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Krishi Vikas"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            width: double.infinity,
            color: Colors.green.shade300,
            child: const Text(
              "What is the condition ?",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    TractorData.type = "new";
                    print(TractorData.type);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SelectBrandScreen(widget.categoryId)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.3),
                            blurRadius: 3,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            newCategoryImage,
                            height: 90,
                            width: 100,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "New $category",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 3,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    TractorData.type = "old";
                    print(TractorData.type);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SelectBrandScreen(widget.categoryId)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.3),
                            blurRadius: 3,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            usedCategoryImage,
                            height: 90,
                            width: 100,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Used $category",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 3,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
