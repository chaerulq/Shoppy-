class Category {
  final String title;
  final String id;
  final String image;

  Category({
    required this.title,
    required this.id,
    required this.image,
  });
}

final List<Category> categories = [
  Category(
    id: "hot_deals",
    title: "Hot Deals",
    image: "assets/images/hot_deals.png",
  ),
  Category(
    id: "rice",
    title: "Rice",
    image: "assets/images/fried_rice.png",
  ),
  Category(
    id: "noodles",
    title: "Noodle",
    image: "assets/images/noodle.png",
  ),
  Category(
    id: "meat",
    title: "Meat",
    image: "assets/images/meat.png",
  ),
  Category(
    id: "seafood",
    title: "SeaFood",
    image: "assets/images/seafood.png",
  ),
  Category(
    id: "dimsum",
    title: "Dimsum",
    image: "assets/images/dimsum.png",
  ),
  Category(
    id: "snack",
    title: "Snack",
    image: "assets/images/fried_fries.png",
  ),
  Category(
    id: "drink",
    title: "Drink",
    image: "assets/images/drink.png",
  ),
  Category(
    id: "ice_cream",
    title: "Ice Cream",
    image: "assets/images/ice_cream.png",
  ),
  Category(
    id: "desert",
    title: "Desert",
    image: "assets/images/desert3.png",
  ),
];
