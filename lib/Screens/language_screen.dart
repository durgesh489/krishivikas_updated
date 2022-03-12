import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/home_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:selectable_container/selectable_container.dart';

class LanguageScreen extends StatefulWidget {
  LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            Center(
              child: Text(
                "Select Your Language",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade400),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4), blurRadius: 3)
                    ]),
                    height: width * 0.4,
                    width: width * 0.4,
                    child: Image.asset("assets/images/english.png"),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4), blurRadius: 3)
                  ]),
                  height: width * 0.4,
                  width: width * 0.4,
                  child: Image.asset("assets/images/bengali.png"),
                )
              ],
            ),

            const SizedBox(height: 35,),

            Center(
              child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4), blurRadius: 3)
                    ]),
                    height: width * 0.4,
                    width: width * 0.4,
                    child: Image.asset("assets/images/hindi.png"),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
