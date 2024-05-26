import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/presentations/Home/Widget/card_image_slider.dart';
import 'package:shoppy/presentations/Home/Widget/card_product.dart';
import 'package:shoppy/presentations/Home/Widget/category.dart';
import 'package:shoppy/presentations/Home/Widget/home_app_bar.dart';
import 'package:shoppy/presentations/Home/Widget/search_bar.dart';
import 'package:shoppy/utils/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(color: primaryColor),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    CustomAppBar(),
                    SizedBox(height: 15),
                    MySearchBar(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Text(
                    "Top Offers!",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 17,
                          color: ktextColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const ImageSliderCard(),
                  const SizedBox(height: 15),
                  Text(
                    "Categories",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: ktextColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Categories(),
                  Text(
                    "Product for you!",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: ktextColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (1 / 1.5),
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return const ProductCard();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
