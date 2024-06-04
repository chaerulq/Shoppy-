import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/app/modules/home/views/card_product_view.dart';
import 'package:shoppy/app/modules/home/views/home_appbar_view.dart';
import 'package:shoppy/app/modules/home/views/home_banner_view.dart';
import 'package:shoppy/app/modules/home/views/home_category_view.dart';
import 'package:shoppy/app/modules/home/views/home_search_view.dart';
import 'package:shoppy/app/utils/color.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double height(x) {
      double h = MediaQuery.sizeOf(context).height;
      return h - (h - x);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height(170),
              width: double.infinity,
              decoration: BoxDecoration(color: primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height(20)),
                    const HomeAppbarView(),
                    SizedBox(height: height(15)),
                    const HomeSearchView(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height(15)),
                  Text(
                    "Top Offers!",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 17,
                        color: ktextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: height(10)),
                  const HomeBannerView(),
                  SizedBox(height: height(15)),
                  Text(
                    "Categories",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: ktextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: height(10)),
                  const HomeCategoryView(),
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
                      return const CardProductView();
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
