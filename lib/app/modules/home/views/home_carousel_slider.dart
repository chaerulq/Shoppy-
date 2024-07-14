import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppy/app/utils/color.dart';

class ImageCarouselSlider extends StatefulWidget {
  final List<String> imagePath;

  ImageCarouselSlider({required this.imagePath});

  @override
  _ImageCarouselSliderState createState() => _ImageCarouselSliderState();
}

class _ImageCarouselSliderState extends State<ImageCarouselSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          items: widget.imagePath.map((path) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(),
                  child: Image.asset(path,
                      fit: BoxFit.cover, width: double.infinity),
                );
              },
            );
          }).toList(),
          carouselController: _controller,
          options: CarouselOptions(
            height: 160,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imagePath.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == entry.key ? greenColor2 : greyColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
