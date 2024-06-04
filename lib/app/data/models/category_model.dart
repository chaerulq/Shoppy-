class Category {
  final String title;
  final String image;

  Category({
    required this.title,
    required this.image,
  });
}

final List<Category> categories = [
  Category(
    title: "Hot Deals",
    image: "assets/images/hot_deals.png",
  ),
  Category(
    title: "Rice",
    image: "assets/images/fried_rice.png",
  ),
  Category(
    title: "Noodle",
    image: "assets/images/noodle.png",
  ),
  Category(
    title: "Meat",
    image: "assets/images/meat.png",
  ),
  Category(
    title: "SeaFood",
    image: "assets/images/seafood.png",
  ),
  Category(
    title: "Dimsum",
    image: "assets/images/dimsum.png",
  ),
  Category(
    title: "Snack",
    image: "assets/images/fried_fries.png",
  ),
  Category(
    title: "Drink",
    image: "assets/images/drink.png",
  ),
  Category(
    title: "Ice Cream",
    image: "assets/images/ice_cream.png",
  ),
];
