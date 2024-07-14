import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/app/modules/home/views/card_product_view.dart';
import '../../../utils/color.dart';
import '../controllers/favorite_controller.dart';

class FavoriteView extends StatelessWidget {
  final FavoriteController favoritesController = Get.find<FavoriteController>();

  FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor2,
        title: Text(
          "Favorites",
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Obx(() {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: favoritesController.favoriteItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (1 / 1.3),
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final product = favoritesController.favoriteItems[index];
                return CardProductView(product: product);
              },
            );
          }),
        ),
      ),
    );
  }
}
