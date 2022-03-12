import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/select_year_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/widgets/tractor/data.dart';

class SelectModelScreen extends StatefulWidget {
  final categoryId, brandId;
  SelectModelScreen(this.categoryId, this.brandId);

  @override
  State<SelectModelScreen> createState() => _SelectModelScreenState();
}

class _SelectModelScreenState extends State<SelectModelScreen> {
  // var name = [
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
              "Select Model",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<List>(
                  future: ApiMethods().getModelsByPostApi(
                      "https://kv.ratemyevent.in/api/model",
                      widget.categoryId,
                      widget.brandId),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? snapshot.data!.length == 0
                            ? Center(
                                child: Text("No Model"),
                              )
                            : GridView.builder(
                              
                                physics: ScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              2.5),
                                ),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: InkWell(
                                      onTap: () {
                                        TractorData.modelId =
                                            snapshot.data![index]["id"];
                                        print(TractorData.modelId);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SelectYearScreen()));
                                      },
                                      child: Container(
                                         decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 2)
                                                ]),
                                            height: 200,
                                        child: Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              snapshot.data![index]["icon"],
                                              height: 45,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              snapshot.data![index]["model_name"],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ]),
                                      ),
                                    ),
                                  );
                                })
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
