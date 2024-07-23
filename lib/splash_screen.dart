import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/main_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: 120,
            height: 130,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo_shoppy.png'),
              ),
            ),
          ),
        ));
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(MainWrapper());
    });
  }
}
