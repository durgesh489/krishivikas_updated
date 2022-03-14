import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/enter_details_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:selectable_container/selectable_container.dart';

class SelectUserType extends StatefulWidget {
  const SelectUserType({Key? key}) : super(key: key);

  @override
  State<SelectUserType> createState() => _SelectUserTypeState();
}

class _SelectUserTypeState extends State<SelectUserType> {
  bool dealer = false;
  bool individual = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
            height: 70,
            width: double.infinity,
            color: Colors.green.shade300,
            child: const Text(
              "Who are you ?",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectableContainer(
                  unselectedBorderColor: Colors.transparent,
                  selectedBorderColor: kPrimaryColor,
                  selected: dealer,
                  onValueChanged: (value) {
                    setState(() {
                      dealer = value;
                      individual = false;
                    });
                  },
                  child: Container(
                    height: width * 0.36,
                    width: width * 0.36,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(color: Colors.grey, blurRadius: 10)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "assets/images/dealer.png",
                          height: width * 0.18,
                          width: width * 0.18,
                        ),
                        const Text(
                          "Dealer",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )),
              SelectableContainer(
                  unselectedBorderColor: Colors.transparent,
                  selectedBorderColor: kPrimaryColor,
                  selected: individual,
                  onValueChanged: (value) {
                    setState(() {
                      individual = value;
                      dealer = false;
                    });
                  },
                  child: Container(
                    height: width * 0.36,
                    width: width * 0.36,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "assets/images/individual.png",
                          height: width * 0.18,
                          width: width * 0.18,
                        ),
                        const Text(
                          "Individual",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    fixedSize: MaterialStateProperty.all(Size(width, 45))),
                onPressed: () {
                  if (individual || dealer) {
                    int userTypeId = individual ? 1 : 2;
                    gotoWithoutBack(context, EnterUserDetails(userTypeId));
                  } else {
                    showSnackbar(context, "Please SelectUserType One");
                  }
                },
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
