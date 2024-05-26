import 'package:flutter/material.dart';
import 'package:shoppy/utils/style.dart';

class ImageSliderCard extends StatelessWidget {
  const ImageSliderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 120,
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: greyColor),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 15),
      ),
    );
  }
}
