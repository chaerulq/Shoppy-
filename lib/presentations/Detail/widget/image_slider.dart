import 'package:flutter/material.dart';
import 'package:shoppy/utils/style.dart';

class ImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentImage;
  const ImageSlider(
      {super.key, required this.onChange, required this.currentImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          child: PageView(
            onPageChanged: onChange,
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.blue),
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.red),
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.yellow),
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.amber),
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.teal),
              )
            ],
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                (index) => AnimatedContainer(
                  duration: const Duration(microseconds: 300),
                  width: currentImage == index ? 15 : 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: currentImage == index ? primaryColor : greyColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
