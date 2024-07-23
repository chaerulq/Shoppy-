import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/app/data/models/account_model.dart';
import 'package:shoppy/app/utils/color.dart';

import '../../../utils/fancy_button.dart';
import '../controllers/account_controller.dart';

class TopUpNextView extends StatefulWidget {
  final Account account;

  const TopUpNextView({super.key, required this.account});

  @override
  State<TopUpNextView> createState() => _TopUpNextViewState();
}

class _TopUpNextViewState extends State<TopUpNextView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phonenumberController = TextEditingController();
  final AccountController accountController = Get.find<AccountController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Text.rich(
                TextSpan(
                  text: "This is you? ",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: ktextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  children: [
                    TextSpan(
                      text: widget.account.username,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: greenColor1,
                          fontSize: 18,
                          color: greenColor1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: phonenumberController,
                expands: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "TopUp",
                  prefixIcon: const Icon(
                    Icons.wallet,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: greyColor1,
                      width: 1.0,
                    ), // Warna border tetap
                  ),
                ),
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
                    String saldoValue = phonenumberController.text.trim();
                    accountController.updateSaldo(saldo: saldoValue);
                    Get.back();
                    Get.back();
                    phonenumberController.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
