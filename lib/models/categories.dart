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
    image: "images/hot_deals.png",
  ),
  Category(
    title: "Rice",
    image: "images/fried_rice.png",
  ),
  Category(
    title: "Noodle",
    image: "images/noodle.png",
  ),
  Category(
    title: "Meat",
    image: "images/meat.png",
  ),
  Category(
    title: "SeaFood",
    image: "images/seafood.png",
  ),
  Category(
    title: "Dimsum",
    image: "images/dimsum.png",
  ),
  Category(
    title: "Snack",
    image: "images/fried_fries.png",
  ),
  Category(
    title: "Drink",
    image: "images/drink.png",
  ),
  Category(
    title: "Ice Cream",
    image: "images/ice_cream.png",
  ),
];
