import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/app/modules/home/views/search_view.dart';

import '../../../utils/color.dart';
import '../controllers/home_search_controller.dart';

class SliverPinned extends StatelessWidget {
  final HomeSearchController searchController = Get.put(HomeSearchController());
  final CarouselController _carouselController = CarouselController();
  final RxInt _current = 0.obs;

  SliverPinned({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => HomeSearchView()),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: greyColor3,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(CupertinoIcons.search, color: greenColor1, size: 23),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Obx(() {
                      return CarouselSlider(
                        items: searchController.products.map((product) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Text(
                                product.title,
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: greenColor1,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                overflow: TextOverflow.ellipsis,
                              );
                            },
                          );
                        }).toList(),
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          height: 35,
                          autoPlay: true,
                          scrollDirection: Axis.vertical,
                          enlargeCenterPage: false,
                          viewportFraction: 1.0,
                          autoPlayInterval: const Duration(seconds: 7),
                          onPageChanged: (index, reason) {
                            _current.value = index;
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10), // Add space between container and icon
          Icon(
            CupertinoIcons.doc_plaintext,
            color: greenColor1,
            size: 23,
          ),
        ],
      ),
    );
  }
}
