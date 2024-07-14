import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/app/modules/profile/controllers/account_controller.dart';
import 'package:shoppy/app/modules/profile/views/topUp_next_view.dart';
import 'package:shoppy/app/utils/color.dart';

import '../../../data/models/account_model.dart';
import '../../../utils/fancy_button.dart';
import '../../../utils/phone_format.dart';

class TopUpView extends StatefulWidget {
  const TopUpView({super.key});

  @override
  State<TopUpView> createState() => _TopUpViewState();
}

class _TopUpViewState extends State<TopUpView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phonenumberController = TextEditingController();
  final AccountController accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let's Top Up your account",
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: ktextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: phonenumberController,
                expands: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone number",
                  prefixIcon: const Icon(CupertinoIcons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: greyColor1,
                      width: 1.0,
                    ), // Warna border tetap
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[+\d]')),
                  LengthLimitingTextInputFormatter(
                      12), // Batasi panjang nomor telepon
                  PhoneNumberFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: FancyButton(
                borderRadius: 5,
                color: greenColor2,
                text: "Top Up",
                onPressed: () async {
                  // Hide the keyboard
                  FocusScope.of(context).unfocus();

                  // Validate the form
                  if (_formKey.currentState!.validate()) {
                    // Fetch the account asynchronously
                    String phoneNumber = phonenumberController.text.trim();
                    Account? account = await accountController
                        .fetchAccountByphoneNumber(phoneNumber);
                    if (account != null) {
                      Get.to(() => TopUpNextView(account: account));
                    } else {
                      Get.snackbar("Error", 'Phone Number not found');
                    }
                    phonenumberController.clear();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
