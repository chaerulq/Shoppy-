import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import pustaka intl
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:shoppy/app/utils/color.dart';

import '../../../data/models/product_models.dart';

class DetailDescriptionView extends GetView {
  final FavoriteController favoritesController = Get.find<FavoriteController>();
  final Product product;
  DetailDescriptionView({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    String value = product.price;
    double doublevalue = double.parse(value);
    final formattedPrice =
        NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
            .format(doublevalue);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: "Rp",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: greenColor1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    children: [
                      TextSpan(
                        text: formattedPrice,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 22,
                            color: greenColor1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined),
              ),
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Obx(() {
                  return Icon(
                    favoritesController.isFavorite(product)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: favoritesController.isFavorite(product)
                        ? greenColor2
                        : Colors.black,
                  );
                }),
                onPressed: () {
                  if (favoritesController.isFavorite(product)) {
                    favoritesController.removeFromFavorites(product);
                  } else {
                    favoritesController.addToFavorites(product);
                  }
                },
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 23,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: greenColor2,
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      product.rate,
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "(120 Reviews)",
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 23,
                color: ktextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            'Description',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 17,
                color: ktextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildParagraphs(product.description),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildParagraphs(String text) {
    List<String> paragraphs = text.split('.');
    List<Widget> widgets = [];

    for (int i = 0; i < paragraphs.length; i++) {
      String formattedParagraph = paragraphs[i]
          .trim(); // Menghilangkan spasi di awal dan akhir paragraf
      if (i == 0 && formattedParagraph.isNotEmpty) {
        // Hanya pada paragraf pertama
        formattedParagraph =
            '     $formattedParagraph'; // Menambahkan spasi di awal paragraf
      }
      formattedParagraph += '.'; // Menambahkan titik di akhir paragraf
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0), // Spacer antara paragraf
          child: Text(
            formattedParagraph,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 16,
                color: ktextColor,
              ),
            ),
          ),
        ),
      );
    }

    return widgets;
  }
}
