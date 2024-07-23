import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/color.dart';

class HomeAppbarView extends GetView {
  final VoidCallback onMenuPressed;
  HomeAppbarView({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onMenuPressed,
          icon: const Icon(Icons.menu),
        ),
        Text(
          "Shoppy",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: greenColor1,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(CupertinoIcons.doc_plaintext),
        ),
      ],
    );
  }
}
