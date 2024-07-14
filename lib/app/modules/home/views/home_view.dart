import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/app/modules/home/views/drawer_view.dart';
import 'package:shoppy/app/modules/home/views/home_carousel_slider.dart';
import 'package:shoppy/app/modules/home/views/search_widget.dart';
import 'package:shoppy/app/modules/home/views/sliver_pinned.dart';
import '../../home/views/card_product_view.dart';
import '../../home/views/home_appbar_view.dart';
import '../../home/views/home_category_view.dart';
import '../controllers/home_controller.dart';
import '../../../utils/color.dart';
import '../../../data/models/product_models.dart';

class HomeView extends StatefulWidget {
  HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> imagePaths = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerView(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            expandedHeight: 130,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double appBarHeight = constraints.biggest.height;
                final bool isPinned = appBarHeight <=
                    (kToolbarHeight + MediaQuery.of(context).padding.top);
                return FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding:
                      const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  title: Opacity(
                    opacity: isPinned ? 1.0 : 0.0,
                    child: SliverPinned(),
                  ),
                  background: Container(
                    decoration: BoxDecoration(color: primaryColor),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          HomeAppbarView(
                            onMenuPressed: () {
                              _scaffoldKey.currentState!.openDrawer();
                            },
                          ),
                          const SizedBox(height: 15),
                          HomeSearchWidget()
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        "Top Offers!",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 17,
                            color: ktextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ImageCarouselSlider(imagePath: imagePaths),
                      const SizedBox(height: 15),
                      Text(
                        "Categories",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: ktextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const HomeCategoryView(),
                      Text(
                        "Product for you!",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: ktextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Obx(() {
                        List<Product> filteredProducts =
                            controller.filteredProducts;
                        if (controller.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: filteredProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (1 / 1.4),
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return CardProductView(
                              product: product,
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
