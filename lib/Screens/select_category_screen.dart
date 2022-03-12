import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/condition_select_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/widgets/tractor/data.dart';

class SelectCategoryScreen extends StatelessWidget {
  SelectCategoryScreen({Key? key}) : super(key: key);

  

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
              "What would you like to sell ?",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: FutureBuilder<List>(
                  future: ApiMethods()
                      .getData("https://kv.ratemyevent.in/api/category"),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? snapshot.data!.length == 0
                            ? Center(
                                child: Text("No Category"),
                              )
                            : GridView.builder(
                                itemCount: snapshot.data!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.25),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: InkWell(
                                      onTap: () {
                                        
                                        TractorData.categoryId =
                                            snapshot.data![index]["id"];
                                        print(TractorData.categoryId);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ConditionSelectScreen(
                                                        snapshot.data![index]
                                                            ["id"])));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                // color: Colors.grey
                                                //     .withOpacity(0.5),
                                                blurRadius: 3,
                                                // spreadRadius: 2
                                              )
                                            ],
                                            color: kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.network(
                                                snapshot.data![index]["icon"],width: 60,height: 60,),
                                            Text(
                                              snapshot.data![index]["category"],
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })
                        : Center(child: CircularProgressIndicator());
                  }),
            ),
          )
        ],
      ),
    );
  }
}
