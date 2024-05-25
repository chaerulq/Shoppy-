import 'package:flutter/material.dart';
import 'package:shoppy/presentations/Cart/cart_page.dart';
import 'package:shoppy/presentations/Favorite/favorite_page.dart';
import 'package:shoppy/presentations/Home/home_page.dart';
import 'package:shoppy/utils/style.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int cuttentindex = 2;
  List page = [
    const Scaffold(),
    const FavoritePage(),
    const HomePage(),
    const CartPage(),
    const Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            cuttentindex = 2;
          });
        },
        // shape: const CircleBorder(),
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.home,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 55,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  cuttentindex = 0;
                });
              },
              icon: Icon(
                Icons.grid_view_outlined,
                size: 25,
                color: cuttentindex == 0 ? primaryColor : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  cuttentindex = 1;
                });
              },
              icon: Icon(
                Icons.favorite_border,
                size: 25,
                color: cuttentindex == 1 ? primaryColor : Colors.grey.shade400,
              ),
            ),
            const SizedBox(width: 15),
            IconButton(
              onPressed: () {
                setState(() {
                  cuttentindex = 3;
                });
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 25,
                color: cuttentindex == 3 ? primaryColor : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  cuttentindex = 4;
                });
              },
              icon: Icon(
                Icons.person_2_outlined,
                size: 25,
                color: cuttentindex == 4 ? primaryColor : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      body: page[cuttentindex],
    );
  }
}
