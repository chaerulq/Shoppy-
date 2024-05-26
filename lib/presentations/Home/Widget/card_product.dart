import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/presentations/Detail/detail_page.dart';
import 'package:shoppy/utils/style.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: greyColor, width: 1),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColor, width: 1),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Text(
                  "Rp.1000",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 15,
                        color: ktextColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "Mie Gacoan",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 12,
                      color: ktextColor,
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 135,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_shopping_cart_outlined,
                        color: Colors.white,
                        size: 17,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "ADD TO CART",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline,
                color: greyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
