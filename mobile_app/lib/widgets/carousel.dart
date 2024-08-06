import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

List images = [
  'assets/images/LOGO CONGRESO ARQUIDIOCESANO DE LA FAMILIA 2024.png',
  'assets/images/principal_virgen-de-suyapa-1-1-1068x662.webp',
];

class Carousel extends StatelessWidget {
  const Carousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height / 3,
        autoPlay: true,
        viewportFraction: 1,
      ),
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              width: MediaQuery.of(context).size.width,
              // child: Text(
              //   'text $i',
              //   style: TextStyle(fontSize: 16.0),
              child: Image.asset(
                i,
                fit: BoxFit.fill,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
