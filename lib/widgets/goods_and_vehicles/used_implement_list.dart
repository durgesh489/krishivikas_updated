import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';

class UsedImplementsList extends StatelessWidget {
  UsedImplementsList({Key? key}) : super(key: key);

 var img = [
   "https://www.tractorjunction.com/assets/images/images/implementTractor/mould-board-plough-35-1608289468.jpg",
   "https://www.tractorjunction.com/assets/images/images/implementTractor/regular-light.png",
   "https://www.tractorjunction.com/assets/images/images/implementTractor/tractor-tipping-trailer-30-1589961362.jpg",

 ];
 var title = ["Universal Mould Board Plough","Regular Light","Tractor Tipping Trailor",];
 var by = ["Universal","Shaktiman","Khedut"];
 var price = ["475000","675000","876000"];
  
  @override
  Widget build(BuildContext context) {

   double height = MediaQuery.of(context).size.height;
   double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: title.length,
        itemBuilder:(context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.grey, blurRadius: 2)
                ]
              ),
              height: height * 0.25,
              width: width * 0.5,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    child: Image.network(img[index], height: height * 0.13, width: width, fit: BoxFit.fill,)),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(title[index],maxLines: 1,textAlign: TextAlign.center, style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),),
                  ),

                 Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: Text("By ${by[index]}", style: const TextStyle(color: Colors.grey),),
                 ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Rs.${price[index]}", style:  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),),
                  )
                ],
              ),
            ),
          );
        } ),
    );
  }
}