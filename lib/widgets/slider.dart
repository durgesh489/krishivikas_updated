import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class Sliders extends StatelessWidget {
   //Sliders({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Image.asset("assets/top.png", fit: BoxFit.cover,),
        Image.asset("assets/top3.jpg", fit: BoxFit.cover,),
      ], 
      options: CarouselOptions(
        autoPlay: true,
         height: 195,
        disableCenter: true,
        viewportFraction: 1
      ));
    
  }
}