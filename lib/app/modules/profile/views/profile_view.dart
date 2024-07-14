import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/app/modules/profile/views/topUp_view.dart';
import 'package:shoppy/app/modules/profile/views/register_view.dart';
import 'package:shoppy/app/utils/fancy_button.dart';
import '../../../utils/color.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  // final ProfileController cartController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor2,
        title: Text(
          "Account",
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/splash_1.png',
            width: 235,
            height: 265,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: FancyButton(
                    text: 'Sign Up',
                    onPressed: () => Get.to(() => const RegisterView()),
                    color: greenColor2,
                    borderRadius: 15,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FancyButton(
                    text: 'Top Up',
                    onPressed: () => Get.to(() => TopUpView()),
                    color: greenColor2,
                    borderRadius: 15,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
