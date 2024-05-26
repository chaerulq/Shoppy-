import 'package:flutter/material.dart';
import 'package:shoppy/presentations/Detail/widget/detail_app_bar.dart';
import 'package:shoppy/presentations/Detail/widget/image_slider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int currentImage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //for back button share and favorite
              DetailAppBar(),
              ImageSlider(
                onChange: (value) {
                  setState(() {
                    currentImage = value;
                  });
                },
                currentImage: currentImage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
