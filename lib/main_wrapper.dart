import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/app/modules/cart/views/cart_view.dart';
import 'package:shoppy/app/modules/favorite/views/favorite_view.dart';
import 'package:shoppy/app/modules/home/views/home_view.dart';
import 'package:shoppy/app/modules/profile/views/profile_view.dart';
import 'package:shoppy/app/utils/color.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:badges/badges.dart' as badges;
import 'app/modules/cart/controllers/cart_controller.dart';
import 'app/modules/favorite/controllers/favorite_controller.dart';
import 'app/modules/profile/controllers/profile_controller.dart';

class MainWrapper extends StatefulWidget {
  MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final ProfileController profileController = Get.put(ProfileController());
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final CartController cartController = Get.put(CartController());
  int cuttentindex = 0;

  List page = [
    HomeView(),
    FavoriteView(),
    CartView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[cuttentindex],
      bottomNavigationBar: BottomAppBar(
        // notchMargin: 10,
        elevation: 0,
        height: 68,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _bottomAppBarItem(
              context,
              icon: Icons.dashboard_outlined,
              page: 0,
              label: "Home",
            ),
            _bottomAppBarItem(
              context,
              icon: Icons.favorite_border,
              page: 1,
              label: "Favorite",
            ),
            Obx(() {
              return badges.Badge(
                badgeStyle: badges.BadgeStyle(badgeColor: greenColor2),
                showBadge: cartController.itemCount > 0,
                badgeContent: Text(
                  cartController.itemCount.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: _bottomAppBarItem(
                  context,
                  icon: Icons.shopping_cart_outlined,
                  page: 2,
                  label: "Cart",
                ),
              );
            }),
            _bottomAppBarItem(
              context,
              icon: Icons.person_2_outlined,
              page: 3,
              label: "Account",
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext buildContext,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () => setState(() {
        cuttentindex = page;
      }),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Icon(
              icon,
              color: cuttentindex == page ? greenColor2 : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                color: cuttentindex == page ? greenColor2 : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
