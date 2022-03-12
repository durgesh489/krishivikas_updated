import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/select_model_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/widgets/tractor/data.dart';

class SelectBrandScreen extends StatefulWidget {
  final categoryId;
  SelectBrandScreen(this.categoryId);

  @override
  State<SelectBrandScreen> createState() => _SelectBrandScreenState();
}

class _SelectBrandScreenState extends State<SelectBrandScreen> {
  // var img = [
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
              "Select Brand",
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
                  future: ApiMethods().getBrandsByPostApi(
                      "https://kv.ratemyevent.in/api/brand", widget.categoryId),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? snapshot.data!.length == 0
                            ? Center(
                                child: Text("No Brand"),
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
                                          TractorData.brandId =
                                              snapshot.data![index]["id"];
                                          TractorData.brandName =
                                              snapshot.data![index]["name"];
                                          print(TractorData.brandId);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SelectModelScreen(
                                                          widget.categoryId,
                                                          snapshot.data![index]
                                                              ["id"])));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 2)
                                              ]),
                                          height: 200,
                                          child: Column(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                snapshot.data![index]["logo"],
                                                height: 45,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![index]["name"],
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                        ),
                                      ));
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
