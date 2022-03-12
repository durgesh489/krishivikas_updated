import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  // var img = [
  //   "https://krishivikas.com/public/mobile-demo/img/classify/img2.jpg",
  //   "https://krishivikas.com/public/mobile-demo/img/classify/img5.jpg",
  //   "https://krishivikas.com/public/mobile-demo/img/classify/img2.jpg",
  // ];
  // var title = [
  //   "Nikon camera new model 2020",
  //   "Audi Q7 for sale",
  //   "Test ads test"
  // ];
  // var price = ["126", "87665", "876"];
  // var location = ["Delhi, India", "New Delhi", "Mumbai India"];
  // var time = ["5 hours ago", "21 Dec 2020", "3 Jan 2022"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: appText("Coming Soon ...", 16, Colors.grey, FontWeight.bold),
      ),
      // body: ListView.builder(
      //   itemCount: title.length,
      //   itemBuilder: (context, index) {
      //     return Card(
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Row(
      //           children: [
      //             ClipRRect(
      //               borderRadius: BorderRadius.circular(8),
      //               child: Image.network(img[index], height: 90,width: 125,fit: BoxFit.cover,),
      //             ),

      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(title[index], style: const TextStyle(
      //                     fontSize: 16,
      //                     fontWeight: FontWeight.bold
      //                   ),),
      //                   const SizedBox(height: 8,),
      //                   Text("Rs. ${price[index]}", style: TextStyle(
      //                     fontSize: 17,
      //                     fontWeight: FontWeight.bold,
      //                     color: kPrimaryColor
      //                   ),),
      //                   const SizedBox(height: 6,),
      //                   Row(
      //                     children: [
      //                       const Icon(Icons.location_on, size: 16,color: Colors.grey,),
      //                       Padding(
      //                         padding: const EdgeInsets.only(left: 4),
      //                         child: Text(location[index]),
      //                       )
      //                     ],
      //                   ),
      //                   const SizedBox(height: 6,),
      //                   Row(
      //                     children: [
      //                       const Icon(Icons.access_time_outlined, size: 16,color: Colors.grey,),
      //                       Padding(
      //                         padding: const EdgeInsets.only(left: 4),
      //                         child: Text(time[index]),
      //                       )
      //                     ],
      //                   )
      //                 ],
      //               ),
      //             )
      //           ],
      //         )
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
