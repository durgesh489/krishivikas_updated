import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/enter_tractor_details_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/tractor/data.dart';

class SelectYearScreen extends StatelessWidget {
  SelectYearScreen({Key? key}) : super(key: key);

  var year = [
    "2022",
    "2021",
    "2020",
    "2019",
    "2018",
    "2017",
    "2016",
    "2015",
    "2014",
    "2013",
    "2012",
    "2011",
    "2010"
  ];

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
              "Select Year of Purchase",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: year.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    TractorData.yearOfPurchase = int.parse(year[index]);
                    print(TractorData.yearOfPurchase);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnterTractordetails()));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                        year[index],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
