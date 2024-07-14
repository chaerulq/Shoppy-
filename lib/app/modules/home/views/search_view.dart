import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/app/modules/home/views/search_result.dart';
import 'package:shoppy/app/utils/color.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_search_controller.dart';

class HomeSearchView extends GetView {
  final TextEditingController textEditingController = TextEditingController();
  final HomeSearchController searchController =
      Get.find<HomeSearchController>();

  HomeSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: greenColor2),
        title: SizedBox(
          height: kToolbarHeight - 10, // Sesuaikan dengan ketinggian AppBar
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  onChanged: (value) {
                    searchController.filterProducts(value);
                  },
                  onSubmitted: (value) async {
                    final result = await Get.to(() => const MyResultSearch(),
                        arguments: searchController.filteredProducts);
                    if (result != null) {
                      // Lakukan sesuatu dengan hasil yang diterima

                      searchController.clearFilteredProducts();
                    }
                    textEditingController.clear();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Products...',
                    hintStyle: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 14,
                        color: ktextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      borderSide: BorderSide(
                          color: greenColor2, width: 1.0), // Warna border tetap
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      borderSide: BorderSide(
                          color: greenColor2, width: 1.0), // Warna border tetap
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15), // Sesuaikan padding
                  ),
                ),
              ),
              Container(
                height: kToolbarHeight - 10,
                width: 50,
                color: greenColor2,
                child: const Icon(CupertinoIcons.camera, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Obx(() {
          if (searchController.filteredProducts.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Popular Searches",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 17,
                        color: ktextColor1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchController.popularSearches.length,
                    itemBuilder: (context, index) {
                      final product = searchController.popularSearches[index];
                      return ListTile(
                        dense: true,
                        title: Text(
                          product.title,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: ktextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        leading: const Icon(Icons.food_bank_outlined),
                        onTap: () {
                          Get.toNamed(Routes.detail, arguments: product);
                          searchController.clearFilteredProducts();
                          textEditingController.clear();
                        },
                      );
                    },
                  ),
                )
              ],
            );
          }
          return ListView.builder(
            itemCount: searchController.filteredProducts.length,
            itemBuilder: (context, index) {
              final product = searchController.filteredProducts[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1.0,
                    ),
                  ),
                ),
                child: ListTile(
                  dense: true,
                  title: Text(
                    product.title,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 14,
                        color: ktextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.detail, arguments: product);
                    searchController.clearFilteredProducts();
                    textEditingController.clear();
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
