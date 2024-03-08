class ProductData {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;
  // final double rating;

  ProductData(
      {required this.description,
      required this.image,
      required this.name,
      required this.price,
      // required this.rating,
      required this.id});
  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
      description: json['description'],
      image: json['image'],
      name: json['name'],
      price: json['price'],
      // rating: json['rating'],
      id: json[' id']);
}
