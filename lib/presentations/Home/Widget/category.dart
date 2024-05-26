import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/models/categories.dart';
import 'package:shoppy/utils/style.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: greenColor3,
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(categories[index].image),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                categories[index].title,
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 11,
                        color: ktextColor,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
      ),
    );
  }
}
